`include "alu/alu.sv"
`include "alu_control/alu_control.sv"
`include "control/control.sv"
`include "fwu/fwu.sv"
`include "hdu/hdu.sv"
`include "memory/tri_port_memory.sv"
`include "register_file/register_file.sv"
`include "others/register.sv"

module mips(
    input logic clock_in, reset_in, 
    input logic instr_clock_in, instrWrite_in, 
    input logic [31:0] instr_address_in, read_data_address_in,
    input logic [31:0] instr_in,
    output logic [31:0] read_instr_out, read_data_out
);

    logic [31:0] pc, next_pc, pc_plus4, if_id_pc_plus4, ext_address;
    logic [31:0] branch_dst, dst_address, instruction, if_id_instruction;
    logic [31:0] alu_out, id_rs_data, id_rt_data, jump_dst, id_ex_imm;
    logic [31:0] ex_rd_data, mem_rd_data, wb_rd_data, branch_rs, branch_rt;
    logic [31:0] id_ex_rs_data, id_ex_rt_data, a_data, b_data, selected_b_data;
    logic [31:0] ex_mem_data_memAddress, ex_mem_write_data, mem_read_data;
    logic [31:0] mem_wb_read_data, mem_wb_data;
    logic [15:0] id_address;
    logic [7:0] control_signals, id_ex_control_signals;
    logic [5:0] id_opcode, id_funct, id_ex_funct;
    logic [4:0] id_rs, id_rt, id_rd, id_ex_rs, id_ex_rt, id_ex_rd, mem_wb_rd;
    logic [4:0] selected_ex_rd, ex_mem_rd;
    logic [3:0] aluCtrl, ex_mem_control_signals;
    logic [1:0] aluOp, id_ex_aluOp, id_muxA, id_muxB, ex_muxA, ex_muxB;
    logic [1:0] mem_wb_control_signals;
    logic zero, jump, branch, memtoReg, memRead, memWrite;
    logic aluSrc, regDst, regWrite, clock_delayed;
    logic beq_rst, pc_wr, if_id_wr, flush_control;
    logic id_ex_memRead, id_ex_aluSrc, id_ex_regDst, id_ex_regWrite;
    logic ex_mem_memtoReg, ex_mem_regWrite, ex_mem_memRead, ex_mem_memWrite; 
    logic mem_wb_memtoReg, mem_wb_regWrite;


      
    assign next_pc = (jump | (branch & beq_rst)) ? dst_address : pc_plus4;

    register #(32) pc0(
        .reg_in(next_pc),
        .reg_wr(pc_wr),
        .reg_reset(reset_in),
        .clock(~clock_in),
        .reg_out(pc)
    );

    adder_sub #(32) pc_add(
        .a_in(pc),
        .b_in(32'd4),
        .op_in(1'b0),
        .s_out(pc_plus4),
        .cb_out()
    );

    tri_port_memory #(.ADDRESS_WIDTH(32)) imem0(
        .write_data_in(instr_in),
        .write_address_in(instr_address_in),
        .read_address_0_in(instr_address_in),
        .read_address_1_in(pc),
        .write_in(instrWrite_in),
        .read_en_0_in(1'b1),
        .read_en_1_in(1'b1),
        .memMode_in(2'b00), //write word
        .read_clock_in(~clock_delayed),
        .write_clock_in(instr_clock_in),
        .read_data_0_out(read_instr_out),
        .read_data_1_out(instruction)
    );

    //-------------FETCH_DECODE--------------

    register #(64) if_id(
        .reg_in({pc_plus4, instruction}),
        .reg_wr(if_id_wr),
        .reg_reset(reset_in),
        .clock(clock_in),
        .reg_out({if_id_pc_plus4, if_id_instruction})
    );

    assign id_opcode  = if_id_instruction[31:26];
    assign id_rs      = if_id_instruction[25:21];
    assign id_rt      = if_id_instruction[20:16];
    assign id_rd      = if_id_instruction[15:11];
    assign id_funct   = if_id_instruction[5:0];
    assign id_address = if_id_instruction[15:0];
    assign ext_address = {{16{id_address[15]}}, id_address};    
    

    adder_sub #(32) branch_add(
        .a_in({ext_address[29:0], 2'b00}),
        .b_in(if_id_pc_plus4),
        .op_in(1'b0),
        .s_out(branch_dst),
        .cb_out()
    );

    control c0(
        .opcode_in(id_opcode),
        .aluOp_out(aluOp),
        .branch_out(branch), 
        .jump_out(jump), 
        .memtoReg_out(memtoReg),
        .memRead_out(memRead), 
        .memWrite_out(memWrite), 
        .aluSrc_out(aluSrc),
        .regWrite_out(regWrite), 
        .regDst_out(regDst)
    );

    assign control_signals = flush_control ? 8'b0 : {regWrite, memtoReg, memWrite, memRead, aluSrc, aluOp, regDst};

    register_file #(.DATA_WIDTH(32)) rf0(
        .write_data_in(wb_rd_data),
        .write_register_in(mem_wb_rd),
        .read_register_0_in(id_rs),
        .read_register_1_in(id_rt),
        .regWrite_in(mem_wb_regWrite),
        .clock_in(~clock_in),
        .read_data_0_out(id_rs_data),
        .read_data_1_out(id_rt_data)
    );

    assign branch_rs = (id_muxA == 2'b00) ? id_rs_data : 
                    (id_muxA == 2'b01) ? ex_rd_data :
                    (id_muxA == 2'b10) ? mem_rd_data :
                    wb_rd_data;
    
    assign branch_rt = (id_muxB == 2'b00) ? id_rt_data : 
                    (id_muxB == 2'b01) ? ex_rd_data :
                    (id_muxB == 2'b10) ? mem_rd_data :
                    wb_rd_data;

    assign beq_rst = (branch_rs == branch_rt) ? 1'b1 : 1'b0;

    assign jump_dst = {if_id_pc_plus4[31:28], if_id_instruction[25:0], 2'b00};

    assign dst_address = branch ? branch_dst : jump_dst;

    hdu hdu0(
        .id_ex_memRead(id_ex_memRead), 
        .id_ex_rt(id_ex_rt),
        .instruction2msb_in(if_id_instruction[31:16]), 
        .pc_wr_out(pc_wr), 
        .if_id_wr_out(if_id_wr),
        .flush_control_out(flush_control)
    );


//----------------DECODE_EXECUTE---------------------

    register #(125) id_ex(
        .reg_in({control_signals, id_rs_data, id_rt_data, id_rs, id_rt, ext_address, id_funct, id_rd}),
        .reg_wr(1'b1),
        .reg_reset(reset_in),
        .clock(clock_in),
        .reg_out({id_ex_control_signals, id_ex_rs_data, id_ex_rt_data, id_ex_rs, id_ex_rt, id_ex_imm, id_ex_funct, id_ex_rd})
    );


    assign id_ex_memRead = id_ex_control_signals[4];
    assign id_ex_aluOp  = id_ex_control_signals[2:1];
    assign id_ex_aluSrc = id_ex_control_signals[3];
    assign id_ex_regDst = id_ex_control_signals[0];

    alu_control ac0(
        .aluOp_in(id_ex_aluOp),
        .funct_in(id_ex_funct),
        .aluCtrl_out(aluCtrl)
    );

    assign a_data = (ex_muxA == 2'b00) ? id_ex_rs_data : 
                    (ex_muxA == 2'b01) ? mem_rd_data : 
                    wb_rd_data;

    assign selected_b_data = (ex_muxB == 2'b00) ? id_ex_rt_data: 
                    (ex_muxB == 2'b01) ? mem_rd_data : 
                    wb_rd_data;

    assign b_data = (id_ex_aluSrc) ? id_ex_imm : selected_b_data;

    alu #(32) alu0(
        .a_in(a_data), 
        .b_in(b_data),
        .aluCtrl_in(aluCtrl),
        .alu_out(alu_out),
        .zero_out()
    );

    assign ex_rd_data = alu_out;

    assign selected_ex_rd = (id_ex_regDst) ? id_ex_rd : id_ex_rt;

    assign id_ex_regWrite = id_ex_control_signals[7];

    fwu fwu0(
        .id_rs(id_rs), 
        .id_rt(id_rt),
        .ex_rs(id_ex_rs), 
        .ex_rt(id_ex_rt), 
        .ex_rd(id_ex_rd),
        .mem_rd(ex_mem_rd), 
        .wb_rd(mem_wb_rd),
        .ex_regWrite(id_ex_regWrite), 
        .mem_regWrite(ex_mem_regWrite), 
        .wb_regWrite(mem_wb_regWrite), 
        .id_branch(branch),
        .ex_muxA(ex_muxA), 
        .ex_muxB(ex_muxB),
        .id_muxA(id_muxA), 
        .id_muxB(id_muxB)
    );

    //-----------------EXECUTE_MEMORY--------------------

    register #(73) ex_mem(
        .reg_in({id_ex_control_signals[7:4], alu_out, selected_b_data, selected_ex_rd}),
        .reg_wr(1'b1),
        .reg_reset(reset_in),
        .clock(clock_in),
        .reg_out({ex_mem_control_signals, ex_mem_data_memAddress, ex_mem_write_data, ex_mem_rd})
    );

    assign ex_mem_memRead  = ex_mem_control_signals[0];
    assign ex_mem_memWrite = ex_mem_control_signals[1];
    assign ex_mem_memtoReg = ex_mem_control_signals[2];
    assign ex_mem_regWrite = ex_mem_control_signals[3];

    tri_port_memory #(.ADDRESS_WIDTH(32)) dmem0(
        .write_data_in(ex_mem_write_data),
        .write_address_in(ex_mem_data_memAddress),
        .read_address_0_in(ex_mem_data_memAddress),
        .read_address_1_in(read_data_address_in),
        .write_in(ex_mem_memWrite),
        .read_en_0_in(ex_mem_memRead),
        .read_en_1_in(1'b1),
        .memMode_in(2'b00), //write word
        .read_clock_in(~clock_delayed),
        .write_clock_in(~clock_in),
        .read_data_0_out(mem_read_data),
        .read_data_1_out(read_data_out)
    );

    assign mem_rd_data = ex_mem_memtoReg ?  mem_read_data : ex_mem_data_memAddress;

    always @(clock_in)
    begin
        clock_delayed <= #(0.25) clock_in; 
    end

    //--------------------memory_writeback-------------------

    register #(71) mem_wb(
        .reg_in({ex_mem_control_signals[3:2], mem_read_data, ex_mem_data_memAddress, ex_mem_rd}),
        .reg_wr(1'b1),
        .reg_reset(reset_in),
        .clock(clock_in),
        .reg_out({mem_wb_control_signals, mem_wb_read_data, mem_wb_data, mem_wb_rd})
    );

    assign mem_wb_memtoReg = mem_wb_control_signals[0];
    assign mem_wb_regWrite = mem_wb_control_signals[1];

    assign wb_rd_data = mem_wb_memtoReg ? mem_wb_read_data : mem_wb_data;

endmodule