`include "../register_file.sv"

module rf_test#(
    DATA_WIDTH = 16,
    ADDRESS_WIDTH = 5
);

    logic [DATA_WIDTH - 1:0] write_data_in, read_data_0, read_data_1;
    logic [ADDRESS_WIDTH - 1:0] write_register, read_register_0, read_register_1;
    logic regWrite, clock;

    register_file rf0(
    .write_data_in(write_data_in),
    .write_register_in(write_register),
    .read_register_0_in(read_register_0),
    .read_register_1_in(read_register_1),
    .regWrite_in(regWrite),
    .clock_in(clock),
    .read_data_0_out(read_data_0),
    .read_data_1_out(read_data_1)
    );

    task display_hexa();
        $display("[%0t] read_register_0: x%0d read_data_0: 0x%4h",  $time, read_register_0, read_data_0, 
        "\nread_register_1: x%0d read_data_1: 0x%4h", read_register_1, read_data_1,
        "\nwrite_register: x%0d write_data: 0x%4h regWrite: %b clock: %b", 
            write_register, write_data_in, regWrite, clock);
    endtask

    task display_bits();
        $display("[%0t] read_register_0: %5b read_data_0: %16b", $time, read_register_0, read_data_0, 
        "\nread_register_1: x%5b read_data_1: %16b", read_register_1, read_data_1, 
        "\nwrite_register: x%5b write_data: %16b regWrite: %b clock: %b", 
            write_register, write_data_in, regWrite, clock);
    endtask

    initial
    begin
        clock = 1'b0;
        forever #1 clock = ~clock;
    end

    initial 
    begin
        regWrite = 1'b0;
        @(posedge clock);
        write_data_in = 16'h0001;
        write_register = 5'd1;
        read_register_0 =  5'd1;
        read_register_1 = 5'd30;
        #1 regWrite = 1'b1;
        @(posedge clock) display_hexa();
        regWrite = 1'b0;
        @(posedge clock) display_hexa();
        
        #1 write_data_in = 16'h0005;
        write_register = 5'd30;
        regWrite = 1'b1;
        @(posedge clock) display_hexa();
        regWrite = 1'b0;
        @(posedge clock) display_hexa();
        
        #1 write_data_in = 16'hffff;
        write_register = 5'd15;
        read_register_0 =  5'd15;
        regWrite = 1'b1;
        @(posedge clock) display_hexa();
        regWrite = 1'b0;
        @(posedge clock) display_hexa();
        
        #1 write_data_in = 16'hfffb;
        write_register = 5'd16;
        read_register_1 = 5'd16;
        regWrite = 1'b1;
        @(posedge clock) display_hexa();
        regWrite = 1'b0;
        @(posedge clock) display_hexa();

        #1 write_data_in = 16'h0ff0;
        write_register = 5'd0;
        read_register_0 =  5'd0;
        regWrite = 1'b1;
        @(posedge clock) display_hexa();
        regWrite = 1'b0;
        @(posedge clock) display_hexa();

        #1 write_data_in = 16'hf00f;
        write_register = 5'd31;
        read_register_0 =  5'd31;
        regWrite = 1'b1;
        @(posedge clock) display_hexa();
        regWrite = 1'b0;
        @(posedge clock) display_hexa();

        read_register_0 = 5'd30;
        read_register_1 = 5'd1;
        @(posedge clock) display_hexa();
        
        read_register_0 = 5'd15;
        read_register_1 = 5'd16;
        @(posedge clock) display_hexa();

        read_register_0 = 5'd0;
        read_register_1 = 5'd31;
        @(posedge clock) display_hexa();

        $stop;
    end

endmodule