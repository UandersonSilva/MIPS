module register_file#(
    parameter DATA_WIDTH = 16,
    parameter ADDRESS_WIDTH = 5
)
(
    input regWrite_in, clock_in,
    input logic [ADDRESS_WIDTH - 1:0] read_register_0_in, read_register_1_in, write_register_in,
    input logic [DATA_WIDTH - 1:0] write_data_in,
    output logic [DATA_WIDTH - 1:0] read_data_0_out, read_data_1_out
);

    logic [DATA_WIDTH - 1:0] rf [2**ADDRESS_WIDTH - 1:0];

    logic start = 1'b1;

    always_ff @(posedge clock_in) 
    begin
        if(start)
        begin
            rf[{ADDRESS_WIDTH{1'b0}}] <= {DATA_WIDTH{1'b0}};
            start = 1'b0;
        end

        if(regWrite_in && (write_register_in != {ADDRESS_WIDTH{1'b0}}))
            rf[write_register_in] <= write_data_in;
    end
    
    assign read_data_0_out = rf[read_register_0_in];
    assign read_data_1_out = rf[read_register_1_in];

endmodule