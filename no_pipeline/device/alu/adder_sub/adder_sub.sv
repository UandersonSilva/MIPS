`include "full_adder.sv"

module adder_sub #(
    parameter WIDTH = 8
)(
    input logic [WIDTH - 1:0] a_in, b_in,
    input logic op_in,
    output logic [WIDTH - 1:0] s_out,
    output logic cb_out
);
    genvar i;

    logic [WIDTH - 1:0] b;
    logic [WIDTH - 2:0] cb;

    assign b = b_in[WIDTH - 1:0] ^ {WIDTH{op_in}};

    full_adder fa_0(
            .a(a_in[0]),
            .b(b[0]),
            .ci(op_in),
            .s(s_out[0]),
            .co(cb[0])
        );

    generate
        for(i = 1; i < WIDTH-1; i++)
        begin : multi_fa
            full_adder fa_n(
                .a(a_in[i]),
                .b(b[i]),
                .ci(cb[i-1]),
                .s(s_out[i]),
                .co(cb[i])
            );
        end
    endgenerate

    full_adder fa_l(
        .a(a_in[WIDTH-1]),
        .b(b[WIDTH-1]),
        .ci(cb[WIDTH-2]),
        .s(s_out[WIDTH-1]),
        .co(cb_out)
    );

endmodule