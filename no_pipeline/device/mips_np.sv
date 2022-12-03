`include "alu/alu.sv"
`include "alu_control/alu_control.sv"
`include "control/control.sv"
`include "memory/tri_port_memory.sv"
`include "register_file/register_file.sv"
`include "others/register.sv"

module mips_np(
    input logic clock_in, reset_in, 
    input logic instr_clock_in, instrWrite_in, 
    input logic [31:0] instr_address_in, read_data_address_in,
    input logic [31:0] instr_in,
    output logic [31:0] read_instr_out, read_data_out
);

    logic [31:0] pc, next_pc, pc_plus4, ext_address;
    logic [31:0] branch_dst, dst_address, instruction, b;
    logic [31:0] data, alu_out, read_data_0, read_data_1, write_data;
    logic [15:0] address;
    logic [5:0] opcode, funct;
    logic [4:0] rd, rs, rt, write_register;
    logic [3:0] aluCtrl;
    logic [1:0] aluOp;
    logic zero, jump, branch, memtoReg, memRead, memWrite;
    logic aluSrc, regDst, regWrite, clock_delayed; 
    
    assign opcode  = instruction[31:26];
    assign rs      = instruction[25:21];
    assign rt      = instruction[20:16];
    assign rd      = instruction[15:11];
    assign funct   = instruction[5:0];
    assign address = instruction[15:0];  



    register #(32) pc0(
        .reg_in(next_pc),
        .reg_wr(1'b1),
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

    adder_sub #(32) branch_add(
        .a_in({ext_address[29:0], 2'b00}),
        .b_in(pc_plus4),
        .op_in(1'b0),
        .s_out(branch_dst),
        .cb_out()
    );

    assign dst_address = (branch & zero) ? branch_dst : pc_plus4;
    assign next_pc = jump ? {pc_plus4[31:28], instruction[25:0], 2'b00} : dst_address;

    control c0(
        .opcode_in(opcode),
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

    tri_port_memory #(.ADDRESS_WIDTH(32)) dmem0(
        .write_data_in(read_data_1),
        .write_address_in(alu_out),
        .read_address_0_in(alu_out),
        .read_address_1_in(read_data_address_in),
        .write_in(memWrite),
        .read_en_0_in(memRead),
        .read_en_1_in(1'b1),
        .memMode_in(2'b00), //write word
        .read_clock_in(~clock_delayed),
        .write_clock_in(clock_in),
        .read_data_0_out(data),
        .read_data_1_out(read_data_out)
    );

    assign write_register = regDst ? rd : rt;
    assign write_data = memtoReg ? data : alu_out;

    register_file #(.DATA_WIDTH(32)) rf0(
        .write_data_in(write_data),
        .write_register_in(write_register),
        .read_register_0_in(rs),
        .read_register_1_in(rt),
        .regWrite_in(regWrite),
        .clock_in(clock_in),
        .read_data_0_out(read_data_0),
        .read_data_1_out(read_data_1)
    );

    assign ext_address = {{16{address[15]}}, address};
    assign b = aluSrc ? ext_address :  read_data_1;

    alu #(32) alu0(
        .a_in(read_data_0), 
        .b_in(b),
        .aluCtrl_in(aluCtrl),
        .alu_out(alu_out),
        .zero_out(zero)
    );

    alu_control ac0(
        .aluOp_in(aluOp),
        .funct_in(funct),
        .aluCtrl_out(aluCtrl)
    );

    always @(clock_in)
    begin
        clock_delayed <= #(0.25) clock_in; 
    end

endmodule