`include "adder_sub/adder_sub.sv"

module alu #(
    parameter WIDTH = 16
)(
    input logic [WIDTH-1:0] a_in, b_in,
    input logic [3:0] aluCtrl_in,
    output logic [WIDTH-1:0] alu_out,
    output logic zero_out
);
    logic [WIDTH-1:0] as_out;
    logic as_cb;

    adder_sub #(WIDTH) add_sub(
        .a_in(a_in),
        .b_in(b_in),
        .op_in(aluCtrl_in[2]),
        .s_out(as_out),
        .cb_out(as_cb)
    );

    assign alu_out = 
        (aluCtrl_in == 4'b0000) ? a_in & b_in :
        (aluCtrl_in == 4'b0001) ? a_in | b_in :
        (aluCtrl_in == 4'b0010) || (aluCtrl_in == 4'b0110) ? as_out :
        (aluCtrl_in == 4'b0111) ? {{(WIDTH-1){1'b0}}, ~as_cb} :
        (aluCtrl_in == 4'b1100) ? ~(a_in | b_in) : {(WIDTH-1){1'bz}};

    assign zero_out = (as_out == {(WIDTH){1'b0}}) ? 1'b1 : 1'b0;

endmodule



