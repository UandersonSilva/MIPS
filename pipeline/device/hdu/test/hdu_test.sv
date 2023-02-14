`include "../hdu.sv"

module hdu_test;
    logic id_ex_memRead;
    logic [4:0] id_ex_rd;
    logic [15:0] instruction2msb_in;
    logic pc_wr_out, if_id_wr_out, flush_control_out;
    
    hdu hdu0(
        .id_ex_memRead(id_ex_memRead), 
        .id_ex_rd(id_ex_rd),
        .instruction2msb_in(instruction2msb_in), 
        .pc_wr_out(pc_wr_out), 
        .if_id_wr_out(if_id_wr_out),
        .flush_control_out(flush_control_out)
    );

    function void display_values();
        $display("##Values##");
        $display("[%0t] id_ex_memRead: %b id_ex_rd: %0d", $time, id_ex_memRead, id_ex_rd);
        $display("[%0t] instruction2msb_in: %0d_%0d_%0d", $time, instruction2msb_in[15:10], instruction2msb_in[9:5], instruction2msb_in[4:0]);
        $display("[%0t] pc_wr_out: %b if_id_wr_out: %b flush_control_out: %b", $time, pc_wr_out, if_id_wr_out, flush_control_out);
    endfunction

    initial
    begin
        id_ex_memRead = 1'b0;
        id_ex_rd = 5'd0;
        instruction2msb_in = 16'b000000_00000_00000;

        #1;
        display_values();

        id_ex_memRead = 1'b0;
        id_ex_rd = 5'd0;
        instruction2msb_in = 16'b000100_00000_00000;

        #1;
        display_values();

        id_ex_memRead = 1'b0;
        id_ex_rd = 5'd8;
        instruction2msb_in = 16'b000100_01000_10000;

        #1;
        display_values();

        id_ex_memRead = 1'b1;
        id_ex_rd = 5'd8;
        instruction2msb_in = 16'b000100_01000_10000;

        #1;
        display_values();

        id_ex_memRead = 1'b1;
        id_ex_rd = 5'd16;
        instruction2msb_in = 16'b000100_01000_10000;

        #1;
        display_values();

        id_ex_memRead = 1'b1;
        id_ex_rd = 5'd30;
        instruction2msb_in = 16'b000100_01000_10000;

        #1;
        display_values();
    end
endmodule