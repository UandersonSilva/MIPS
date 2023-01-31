module fwu(
    input logic [4:0] id_rs, id_rt,
    input logic [4:0] ex_rs, ex_rt, ex_rd,
    input logic [4:0] mem_rd, wb_rd,
    input logic ex_regWrite, mem_regWrite, wb_regWrite, id_branch,
    output logic [1:0] ex_muxA, ex_muxB, //00 - id_ex | 01 - mem | 1* - wb
    output logic [1:0] id_muxA, id_muxB //00 - id | 01 - ex | 10 - mem | 11 - wb
);

    always_latch
    begin
        if((mem_regWrite == 1'b1) && (mem_rd != 5'd0) && (ex_rs == mem_rd))
            ex_muxA <= 2'b01;

        else if((wb_regWrite == 1'b1) && (wb_rd != 5'd0) && (ex_rs == wb_rd))
            ex_muxA <= 2'b10;

        else
            ex_muxA <= 2'b00;

        if((mem_regWrite == 1'b1) && (mem_rd != 5'd0) && (ex_rt == mem_rd))
            ex_muxB <= 2'b01;       

        else if((wb_regWrite == 1'b1) && (wb_rd != 5'd0) && (ex_rt == wb_rd))
            ex_muxB <= 2'b10;

        else
            ex_muxB <= 2'b00;
    end

    always_comb
    begin
        if(id_branch == 1'b1)
        begin
            if((ex_regWrite == 1'b1) && (ex_rd != 5'd0) && (id_rs == ex_rd))
                id_muxA <= 2'b01;

            else if((mem_regWrite == 1'b1) && (mem_rd != 5'd0) && (id_rs == mem_rd))
                id_muxA <= 2'b10;

            else if((wb_regWrite == 1'b1) && (wb_rd != 5'd0) && (id_rs == wb_rd))
                id_muxA <= 2'b11;
            
            else
                id_muxA <= 2'b00;

                
            if((ex_regWrite == 1'b1) && (ex_rd != 5'd0) && (id_rt == ex_rd))
                id_muxB <= 2'b01;
           
            else if((ex_regWrite == 1'b1) && (ex_rd != 5'd0) && (id_rt == mem_rd))
                id_muxB <= 2'b10;

            else if((wb_regWrite == 1'b1) && (wb_rd != 5'd0) && (id_rt == wb_rd))
                id_muxB <= 2'b11;

            else
                id_muxB <= 2'b00;   
        end

        else
        begin
            id_muxA <= 2'b00;
            id_muxB <= 2'b00;
        end
    end
endmodule