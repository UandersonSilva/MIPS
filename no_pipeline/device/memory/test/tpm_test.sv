`include "../tri_port_memory.sv"

module tpm_test#(
    ADDRESS_WIDTH = 8
);

    logic [31:0] write_data_in, read_data_0, read_data_1;
    logic [ADDRESS_WIDTH - 1:0] write_address, read_address_0, read_address_1;
    logic [1:0] memMode;
    logic memWrite, read_en_0, read_en_1, clock;

   tri_port_memory #(ADDRESS_WIDTH) tpm0(
    .write_data_in(write_data_in),
    .write_address_in(write_address),
    .read_address_0_in(read_address_0),
    .read_address_1_in(read_address_1),
    .write_in(memWrite),
    .read_en_0_in(read_en_0),
    .read_en_1_in(read_en_1),
    .memMode_in(memMode),
    .read_clock_in(~clock),
    .write_clock_in(clock),
    .read_data_0_out(read_data_0),
    .read_data_1_out(read_data_1)
    );

    task display_hexa();
        $display("[%0t] read_address_0: 0x%2h read_data_0: 0x%8h read_en_0_in: %b",  $time, read_address_0, read_data_0, read_en_0, 
        "\nread_address_1: x%2h read_data_1: 0x%8h read_en_1_in: %b", read_address_1, read_data_1, read_en_1,
        "\nwrite_address: x%2h write_data: 0x%8h memWrite: %b memMode: %2b clock: %b", 
            write_address, write_data_in, memWrite, memMode, clock);
    endtask

    task display_bits();
        $display("[%0t] read_address_0: %8b read_data_0: %32b read_en_0_in: %b", $time, read_address_0, read_data_0, read_en_0,
        "\nread_address_1: x%8b read_data_1: %32b read_en_0_in: %b", read_address_1, read_data_1, read_en_1,
        "\nwrite_address: x%8b write_data: %32b memWrite: %b memMode: %2b clock: %b", 
            write_address, write_data_in, memWrite, memMode, clock);
    endtask

    initial
    begin
        clock = 1'b0;
        forever #1 clock = ~clock;
    end

    initial 
    begin
        memWrite = 1'b0;
        memMode = 2'b00;// word mode
        read_en_0 = 1'b1;
        read_en_1 = 1'b1;
        @(posedge clock);
        write_data_in = 32'h00000001;
        write_address = 8'h00;
        read_address_0 =  8'h00;
        read_address_1 = 8'hff;
        #1 memWrite = 1'b1;
        @(posedge clock) display_hexa();
        memWrite = 1'b0;
        @(posedge clock) display_hexa();
        
        #1 write_data_in = 32'hffff0f05;
        write_address = 8'hff;
        memWrite = 1'b1;
        @(posedge clock) display_hexa();
        memWrite = 1'b0;
        @(posedge clock) display_hexa();
        
        #1 write_data_in = 32'hffffabab;
        write_address = 8'h1c;
        read_address_0 =  8'h1c;
        memWrite = 1'b1;
        memMode = 2'b11; //byte mode
        @(posedge clock) display_hexa();
        memWrite = 1'b0;
        @(posedge clock) display_hexa();

        #1 write_data_in = 32'h1f7fcd00;
        write_address = 8'h1d;
        read_address_0 =  8'h1c;
        memWrite = 1'b1;
        memMode = 2'b11; //byte mode
        @(posedge clock) display_hexa();
        memWrite = 1'b0;
        @(posedge clock) display_hexa();

        #1 write_data_in = 32'h4321fab0;
        write_address = 8'h1e;
        read_address_0 =  8'h1c;
        memWrite = 1'b1;
        memMode = 2'b11; //byte mode
        @(posedge clock) display_hexa();
        memWrite = 1'b0;
        @(posedge clock) display_hexa();

        #1 write_data_in = 32'h8197f11b;
        write_address = 8'h1f;
        read_address_0 =  8'h1c;
        memWrite = 1'b1;
        memMode = 2'b11; //byte mode
        @(posedge clock) display_hexa();
        memWrite = 1'b0;
        @(posedge clock) display_hexa();

        #1 write_data_in = 32'h1234abcd;
        write_address = 8'h19;
        read_address_0 =  8'h19;
        memWrite = 1'b1;
        memMode = 2'b10; //half mode
        @(posedge clock) display_hexa();
        memWrite = 1'b0;
        @(posedge clock) display_hexa();

        #1 write_data_in = 32'hf00f0ff0;
        write_address = 8'h1a;
        read_address_0 =  8'h19;
        memWrite = 1'b1;
        memMode = 2'b10; //half mode
        @(posedge clock) display_hexa();
        memWrite = 1'b0;
        @(posedge clock) display_hexa();

        read_address_0 = 8'h00;
        read_address_1 = 8'hff;
        @(posedge clock) display_hexa();
        
        read_address_0 = 8'h1c;
        read_address_1 = 8'h19;
        @(posedge clock) display_hexa();

        read_en_0 = 1'b0;
        #1 display_hexa();

        read_en_1 = 1'b0;
        #1 display_hexa();

        read_en_0 = 1'b1;
        read_en_1 = 1'b1;
        #1 display_hexa();

        $stop;
    end

endmodule