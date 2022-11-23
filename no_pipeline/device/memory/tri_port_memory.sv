module tri_port_memory#(
    ADDRESS_WIDTH = 8
)(
    input write_in, write_clock_in, read_clock_in, read_en_0_in, read_en_1_in, 
    input logic [1:0] memMode_in,
    input logic [ADDRESS_WIDTH - 1:0] read_address_0_in, read_address_1_in, write_address_in,
    input logic [31:0] write_data_in,
    output logic [31:0] read_data_0_out, read_data_1_out
);

    logic [7:0] bank3 [2**ADDRESS_WIDTH - 3:0];
    logic [7:0] bank2 [2**ADDRESS_WIDTH - 3:0];
    logic [7:0] bank1 [2**ADDRESS_WIDTH - 3:0];
    logic [7:0] bank0 [2**ADDRESS_WIDTH - 3:0];

    logic [31:0] read_data_0, read_data_1;

    

    always_ff @(posedge write_clock_in) 
    begin
        if(write_in)
        begin
            if(memMode_in[1]) //memMode_in[1] == 1 -> byte/half 
            begin
                if(memMode_in[0]) //memMode_in[0] == 1 -> byte;
                begin
                    case(write_address_in[1:0])
                        2'b00:
                        begin
                            bank0[write_address_in[ADDRESS_WIDTH-1:2]] <= write_data_in[7:0];
                        end
                        2'b01:
                        begin
                            bank1[write_address_in[ADDRESS_WIDTH-1:2]] <= write_data_in[7:0];
                        end
                        2'b10:
                        begin
                            bank2[write_address_in[ADDRESS_WIDTH-1:2]] <= write_data_in[7:0];
                        end
                        2'b11:
                        begin
                            bank3[write_address_in[ADDRESS_WIDTH-1:2]] <= write_data_in[7:0];
                        end
                        default:
                        begin
                            bank0[write_address_in[ADDRESS_WIDTH-1:2]] <= write_data_in[7:0];
                        end
                    endcase
                end
                else //memMode_in[0] == 0 -> half
                begin
                    if(write_address_in[1])
                    begin
                        bank3[write_address_in[ADDRESS_WIDTH-1:2]] <= write_data_in[15:8];
                        bank2[write_address_in[ADDRESS_WIDTH-1:2]] <= write_data_in[7:0];
                    end
                    else
                    begin
                        bank1[write_address_in[ADDRESS_WIDTH-1:2]] <= write_data_in[15:8];
                        bank0[write_address_in[ADDRESS_WIDTH-1:2]] <= write_data_in[7:0];
                    end   
                end
            end
            else //memMode_in[1] == 0 -> word
            begin
                bank3[write_address_in[ADDRESS_WIDTH-1:2]] <= write_data_in[31:24];
                bank2[write_address_in[ADDRESS_WIDTH-1:2]] <= write_data_in[23:16];
                bank1[write_address_in[ADDRESS_WIDTH-1:2]] <= write_data_in[15:8];
                bank0[write_address_in[ADDRESS_WIDTH-1:2]] <= write_data_in[7:0];
            end
        end
    end
    
    always_ff @(posedge read_clock_in) 
    begin
        read_data_0[31:24] <= bank3[read_address_0_in[ADDRESS_WIDTH-1:2]];
        read_data_0[23:16] <= bank2[read_address_0_in[ADDRESS_WIDTH-1:2]];
        read_data_0[15:8]  <= bank1[read_address_0_in[ADDRESS_WIDTH-1:2]];
        read_data_0[7:0]   <= bank0[read_address_0_in[ADDRESS_WIDTH-1:2]];
        
        read_data_1[31:24] <= bank3[read_address_1_in[ADDRESS_WIDTH-1:2]];
        read_data_1[23:16] <= bank2[read_address_1_in[ADDRESS_WIDTH-1:2]];
        read_data_1[15:8]  <= bank1[read_address_1_in[ADDRESS_WIDTH-1:2]];
        read_data_1[7:0]   <= bank0[read_address_1_in[ADDRESS_WIDTH-1:2]];
    end	 

    assign read_data_0_out = read_en_0_in ? read_data_0 : {32{1'bz}};
    assign read_data_1_out = read_en_1_in ? read_data_1 : {32{1'bz}};

endmodule