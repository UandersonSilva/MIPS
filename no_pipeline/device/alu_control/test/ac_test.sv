`include "../alu_control.sv"

module ac_test;

    logic [1:0] aluOp;
    logic [5:0] funct;
    logic [3:0] aluCtrl;

    alu_control ac0(
        .aluOp_in(aluOp),
        .funct_in(funct),
        .aluCtrl_out(aluCtrl)
    );

    task display_bits();
        $display("[%0t] aluOp_in: %2b funct_in: %6b => aluCtrl_out: %4b", 
            $time, aluOp, funct, aluCtrl);
    endtask

    initial
    begin
        aluOp = 2'b00;
        funct = 6'b000000;
        #1 display_bits();

        aluOp = 2'b01;
        funct = 6'b000000;
        #1 display_bits();

        aluOp = 2'b10;
        funct = 6'b100000;
        #1 display_bits();

        aluOp = 2'b10;
        funct = 6'b100010;
        #1 display_bits();

        aluOp = 2'b10;
        funct = 6'b100100;
        #1 display_bits();

        aluOp = 2'b10;
        funct = 6'b100101;
        #1 display_bits();

        aluOp = 2'b10;
        funct = 6'b101010;
        #1 display_bits();

        aluOp = 2'b10;
        funct = 6'b100111;
        #1 display_bits();

        aluOp = 2'b11;
        funct = 6'b000000;
        #1 display_bits();
    end
endmodule