`include "../fwu.sv"

module fwu_test;
    logic [4:0] id_rs, id_rt;
    logic [4:0] ex_rs, ex_rt, ex_rd;
    logic [4:0] mem_rd, wb_rd;
    logic ex_regWrite, mem_regWrite, wb_regWrite, id_branch;
    logic [1:0] ex_muxA, ex_muxB;
    logic [1:0] id_muxA, id_muxB;
    
    fwu fwu0(
        .id_rs(id_rs), 
        .id_rt(id_rt),
        .ex_rs(ex_rs), 
        .ex_rt(ex_rt), 
        .ex_rd(ex_rd),
        .mem_rd(mem_rd), 
        .wb_rd(wb_rd),
        .ex_regWrite(ex_regWrite), 
        .mem_regWrite(mem_regWrite), 
        .wb_regWrite(wb_regWrite), 
        .id_branch(id_branch),
        .ex_muxA(ex_muxA), 
        .ex_muxB(ex_muxB),
        .id_muxA(id_muxA), 
        .id_muxB(id_muxB)
    );

    function void display_values();
        $display("##Values##");
        $display("[%0t] id_rs: %0d id_rt: %0d", $time, id_rs, id_rt);
        $display("[%0t] ex_rs: %0d ex_rt: %0d ex_rd: %0d", $time, ex_rs, ex_rt, ex_rd);
        $display("[%0t] mem_rd: %0d wb_rd: %0d", $time, mem_rd, wb_rd);
        $display("[%0t] ex_regWrite: %b mem_regWrite: %b wb_regWrite: %b", $time, ex_regWrite, mem_regWrite, wb_regWrite);
        $display("[%0t] id_branch: %b", $time, id_branch);
        $display("[%0t] ex_muxA: %0d ex_muxB: %0d", $time, ex_muxA, ex_muxB);
        $display("[%0t] id_muxA: %0d id_muxB: %0d", $time, id_muxA, id_muxB);
    endfunction

    initial
    begin
        id_rs = 5'd0;
        id_rt = 5'd0;
        ex_rs = 5'd0;
        ex_rt = 5'd0;
        ex_rd = 5'd0;
        mem_rd = 5'd0;
        wb_rd = 5'd0;
        ex_regWrite = 1'b0;
        mem_regWrite = 1'b0;
        wb_regWrite = 1'b0;
        id_branch = 1'b0;

        #1;
        display_values();

        id_rs = 5'd0;
        id_rt = 5'd0;
        ex_rs = 5'd5;
        ex_rt = 5'd0;
        ex_rd = 5'd0;
        mem_rd = 5'd5;
        wb_rd = 5'd0;
        ex_regWrite = 1'b0;
        mem_regWrite = 1'b0;
        wb_regWrite = 1'b0;
        id_branch = 1'b0;

        #1;
        display_values();

        id_rs = 5'd0;
        id_rt = 5'd0;
        ex_rs = 5'd5;
        ex_rt = 5'd4;
        ex_rd = 5'd0;
        mem_rd = 5'd5;
        wb_rd = 5'd4;
        ex_regWrite = 1'b0;
        mem_regWrite = 1'b1;
        wb_regWrite = 1'b1;
        id_branch = 1'b0;

        #1;
        display_values();

        id_rs = 5'd0;
        id_rt = 5'd0;
        ex_rs = 5'd7;
        ex_rt = 5'd3;
        ex_rd = 5'd0;
        mem_rd = 5'd3;
        wb_rd = 5'd7;
        ex_regWrite = 1'b0;
        mem_regWrite = 1'b1;
        wb_regWrite = 1'b1;
        id_branch = 1'b0;

        #1;
        display_values();

        id_rs = 5'd8;
        id_rt = 5'd2;
        ex_rs = 5'd5;
        ex_rt = 5'd0;
        ex_rd = 5'd2;
        mem_rd = 5'd8;
        wb_rd = 5'd0;
        ex_regWrite = 1'b1;
        mem_regWrite = 1'b1;
        wb_regWrite = 1'b0;
        id_branch = 1'b1;

        #1;
        display_values();

        id_rs = 5'd2;
        id_rt = 5'd9;
        ex_rs = 5'd1;
        ex_rt = 5'd0;
        ex_rd = 5'd2;
        mem_rd = 5'd8;
        wb_rd = 5'd9;
        ex_regWrite = 1'b1;
        mem_regWrite = 1'b1;
        wb_regWrite = 1'b1;
        id_branch = 1'b1;

        #1;
        display_values();

        id_rs = 5'd8;
        id_rt = 5'd6;
        ex_rs = 5'd5;
        ex_rt = 5'd0;
        ex_rd = 5'd6;
        mem_rd = 5'd6;
        wb_rd = 5'd6;
        ex_regWrite = 1'b1;
        mem_regWrite = 1'b1;
        wb_regWrite = 1'b1;
        id_branch = 1'b1;

        #1;
        display_values();

        id_rs = 5'd3;
        id_rt = 5'd6;
        ex_rs = 5'd5;
        ex_rt = 5'd0;
        ex_rd = 5'd3;
        mem_rd = 5'd6;
        wb_rd = 5'd3;
        ex_regWrite = 1'b1;
        mem_regWrite = 1'b1;
        wb_regWrite = 1'b1;
        id_branch = 1'b1;

        #1;
        display_values();

        id_rs = 5'd3;
        id_rt = 5'd6;
        ex_rs = 5'd3;
        ex_rt = 5'd9;
        ex_rd = 5'd6;
        mem_rd = 5'd5;
        wb_rd = 5'd3;
        ex_regWrite = 1'b1;
        mem_regWrite = 1'b1;
        wb_regWrite = 1'b1;
        id_branch = 1'b1;

        #1;
        display_values();
    end    
endmodule