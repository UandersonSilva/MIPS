module control(
    input logic [5:0] opcode_in,
    output logic [1:0] aluOp_out,
    output logic branch_out, jump_out, memtoReg_out,
    output logic memRead_out, memWrite_out, aluSrc_out,
    output logic regWrite_out, regDst_out
);

    always_comb
    begin
        case(opcode_in)
            6'b000000: //R-type
            begin
                branch_out   <= 1'b0;
                jump_out     <= 1'b0;
                memtoReg_out <= 1'b0;
                memRead_out  <= 1'b0;
                memWrite_out <= 1'b0;
                aluSrc_out   <= 1'b0;
                aluOp_out    <= 2'b10;
                regWrite_out <= 1'b1;
                regDst_out   <= 1'b1;
            end

            6'b000010: //jump
            begin
                branch_out   <= 1'b0;
                jump_out     <= 1'b1;
                memtoReg_out <= 1'b0;
                memRead_out  <= 1'b0;
                memWrite_out <= 1'b0;
                aluSrc_out   <= 1'b0;
                aluOp_out    <= 2'b00;
                regWrite_out <= 1'b0;
                regDst_out   <= 1'b0;
            end

            6'b000100: //branch
            begin
                branch_out   <= 1'b1;
                jump_out     <= 1'b0;
                memtoReg_out <= 1'b0;
                memRead_out  <= 1'b0;
                memWrite_out <= 1'b0;
                aluSrc_out   <= 1'b0;
                aluOp_out    <= 2'b01;
                regWrite_out <= 1'b0;
                regDst_out   <= 1'b0;
            end

            6'b001001: //I-type(addiu)
            begin
                branch_out   <= 1'b0;
                jump_out     <= 1'b0;
                memtoReg_out <= 1'b0;
                memRead_out  <= 1'b0;
                memWrite_out <= 1'b0;
                aluSrc_out   <= 1'b1;
                aluOp_out    <= 2'b00;
                regWrite_out <= 1'b1;
                regDst_out   <= 1'b0;
            end


            6'b100011: //mem-ref (lw)
            begin
                branch_out   <= 1'b0;
                jump_out     <= 1'b0;
                memtoReg_out <= 1'b1;
                memRead_out  <= 1'b1;
                memWrite_out <= 1'b0;
                aluSrc_out   <= 1'b1;
                aluOp_out    <= 2'b00;
                regWrite_out <= 1'b1;
                regDst_out   <= 1'b0;
            end

            6'b101011: //mem-ref (sw)
            begin
                branch_out   <= 1'b0;
                jump_out     <= 1'b0;
                memtoReg_out <= 1'b0;
                memRead_out  <= 1'b0;
                memWrite_out <= 1'b1;
                aluSrc_out   <= 1'b1;
                aluOp_out    <= 2'b00;
                regWrite_out <= 1'b0;
                regDst_out   <= 1'b0;
            end

            default:
            begin
                branch_out   <= 1'b0;
                jump_out     <= 1'b0;
                memtoReg_out <= 1'b0;
                memRead_out  <= 1'b0;
                memWrite_out <= 1'b0;
                aluSrc_out   <= 1'b0;
                aluOp_out    <= 2'b00;
                regWrite_out <= 1'b0;
                regDst_out   <= 1'b0;
            end
        endcase
    end
endmodule