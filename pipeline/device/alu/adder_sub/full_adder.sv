module full_adder(
    input logic a, b, ci,
    output logic s, co
);
    logic axb;

    assign axb = a ^ b;
    assign s = axb ^ ci;
    assign co = (a & b) | (axb & ci);
endmodule