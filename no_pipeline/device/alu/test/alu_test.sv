`include "../alu.sv"

module alu_test;
    localparam WIDTH = 16;
    
    typedef enum logic [3:0] {
        _and = 4'b0000,
        _or  = 4'b0001,
        _add = 4'b0010,
        _sub = 4'b0110,
        _slt = 4'b0111,
        _nor = 4'b1100
    } operation_t;

    logic signed [WIDTH-1:0] a, b, out;
    operation_t aluCtrl;
    logic zero;

    alu #(WIDTH) alu0(
        .a_in(a), 
        .b_in(b),
        .aluCtrl_in(aluCtrl),
        .alu_out(out),
        .zero_out(zero)
    );

    task display_values();
        $display("[%0t] a_in: %0d %s b_in: %0d => alu_out: %0d zero_out: %b", 
            $time, a, aluCtrl.name(), b, out, zero);
    endtask

    task display_bits();
        $display("[%0t] a_in: %16b b_in: %16b aluCtrl_in: %4b => alu_out: %16b zero_out: %b", 
            $time, a, b, aluCtrl, out, zero);
    endtask

    task display_hexa();
        $display("[%0t] a_in: 0x%4h %s b_in: 0x%4h => alu_out: 0x%4h zero_out: %b", 
            $time, a, aluCtrl.name(), b, out, zero);
    endtask

    initial
    begin
        a = 16'h0040;
        b = 16'h00FF;
        aluCtrl = _and;
        #1;
        display_hexa();


        aluCtrl = _or;
        #1;
        display_hexa();

        aluCtrl = _add;
        #1;
        display_values();

        aluCtrl = _sub;
        #1;
        display_values();

        aluCtrl = _nor;
        #1;
        display_hexa();

        aluCtrl = _slt;
        #1;
        display_values();

        b = 16'h0040;
        a = 16'h00FF;
        aluCtrl = _slt;
        #1;
        display_values();

        b = 16'h00FF;
        a = 16'h00FF;
        aluCtrl = _slt;
        #1;
        display_values();
    end
endmodule