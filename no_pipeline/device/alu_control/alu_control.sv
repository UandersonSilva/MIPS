module alu_control(
    input logic [1:0] aluOp_in,
    input logic [5:0] funct_in,
    output logic [3:0] aluCtrl_out
);

    always_comb
    begin
        case(aluOp_in)
            2'b00: //Memory-reference
            begin
                aluCtrl_out <= 4'b0010;
            end

            2'b01: //Branch
            begin
                aluCtrl_out <= 4'b0110;
            end

            2'b10: //R-type
            begin
                case(funct_in)
                    6'b100000: //and
                    begin
                        aluCtrl_out <= 4'b0010;
                    end

                    6'b100010: //sub
                    begin
                        aluCtrl_out <= 4'b0110;
                    end

                    6'b100100: //AND
                    begin
                        aluCtrl_out <= 4'b0000;
                    end

                    6'b100101: //OR
                    begin
                        aluCtrl_out <= 4'b0001;
                    end

                    6'b101010: //slt
                    begin
                        aluCtrl_out <= 4'b0111;
                    end

                    default: //default AND
                    begin
                        aluCtrl_out <= 4'b0000;
                    end
                endcase
            end

            default: // default AND
            begin
                aluCtrl_out <= 4'b0000;
            end
        endcase
    end

endmodule