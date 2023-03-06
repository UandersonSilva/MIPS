module hdu(
    input logic id_ex_memRead,
    input logic [4:0] id_ex_rt,
    input logic [15:0] instruction2msb_in,
    output logic pc_wr_out, if_id_wr_out, flush_control_out    
);

    logic [5:0] opcode;
    logic [4:0] rs, rt;

    assign opcode = instruction2msb_in[15:10];
    assign rs     = instruction2msb_in[9:5];
    assign rt     = instruction2msb_in[4:0];


    always_comb
    begin
        if((opcode == 6'd4) && (id_ex_memRead))
        begin
            if((id_ex_rt != 5'd0) && ((rs == id_ex_rt) || (rt == id_ex_rt)))
            begin
                pc_wr_out         <= 1'b0;
                if_id_wr_out      <= 1'b0;
                flush_control_out <= 1'b1;
            end
            
            else
            begin
                pc_wr_out         <= 1'b1;
                if_id_wr_out      <= 1'b1;
                flush_control_out <= 1'b0;
            end
        end

        else
        begin
            pc_wr_out         <= 1'b1;
            if_id_wr_out      <= 1'b1;
            flush_control_out <= 1'b0;
        end
    end
endmodule