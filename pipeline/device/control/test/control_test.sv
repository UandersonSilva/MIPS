`include "../control.sv"

module control_test;
    logic [5:0] opcode;
    logic [1:0] aluOp;
    logic branch, jump, memtoReg;
    logic memRead, memWrite, aluSrc;
    logic regWrite, regDst;

    logic [9:0] control_code;

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

    task display_bits();
        control_code = {branch, jump, memtoReg, memRead, memWrite, aluSrc, aluOp, regWrite, regDst};
        $display("[%0t] opcode_in: %6b => control_code: %10b", $time, opcode, control_code);
    endtask

    initial
    begin
        $display("control_code: branch[9], jump[8], memtoReg[7], memRead[6], memWrite[5], aluSrc[4], aluOp[3:2], regWrite[1], regDst[0]");

        opcode = 6'b000000;
        #1 display_bits();

        opcode = 6'b000010;
        #1 display_bits();

        opcode = 6'b000100;
        #1 display_bits();

        opcode = 6'b001001;
        #1 display_bits();

        opcode = 6'b100011;
        #1 display_bits();

        opcode = 6'b101011;
        #1 display_bits();

        opcode = 6'b111111;
        #1 display_bits();
    end
endmodule