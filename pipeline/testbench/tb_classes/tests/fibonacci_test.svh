class fibonacci_test extends base_test;
    bit equal = 1'b0;
    bit sum_instr = 1'b0;

    task run;// Fibonacci sequence values until the first one greater than 128
        super.run();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b001001_00000_00001_0000000000000001; //addiu $0, $1, 1
        data_i.instr_address_in     = 32'h00000000;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b001001_00000_11110_0000000010000000; //addiu $0, $30, 0x80 (128)
        data_i.instr_address_in     = 32'h00000004;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b001001_00000_01111_0000000000000000; //addiu $0, $15, 0
        data_i.instr_address_in     = 32'h00000008;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b101011_00000_01111_0000000000001100; //sw $0, $15, 0x000c
        data_i.instr_address_in     = 32'h0000000c;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b001001_00000_10000_0000000000000001; //addiu $0, $16, 1
        data_i.instr_address_in     = 32'h00000010;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b000000_01111_10000_01111_00000_100000; //add $15, $16, $15
        data_i.instr_address_in     = 32'h00000014;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b101011_00000_01111_0000000000001100; //sw $0, $15, 0x000c
        data_i.instr_address_in     = 32'h00000018;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b000000_11110_01111_00011_00000_101010; //slt $30, $15, $3
        data_i.instr_address_in     = 32'h0000001c;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();

        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b000100_00001_00011_0000000000000100; //beq $1, $3, 0x0004
        data_i.instr_address_in     = 32'h00000020;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b000000_01111_10000_10000_00000_100000; //add $15, $16, $16
        data_i.instr_address_in     = 32'h00000024;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b101011_00000_10000_0000000000001100; //sw $0, $16, 0x000c
        data_i.instr_address_in     = 32'h00000028;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b000000_10000_11110_00011_00000_101010; //slt $16, $30, $3
        data_i.instr_address_in     = 32'h0000002c;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();

        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b000100_00001_00011_1111111111111000; //beq $1, $3, 0xfff8 (-8)
        data_i.instr_address_in     = 32'h00000030;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b000010_00000000000000000000000000; //j 0x0000000
        data_i.instr_address_in     = 32'h00000034;
        data_i.read_data_address_in = 32'h0000000c;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        //Execution

        while(previous_data.read_data_out === {WIDTH{1'bx}})
        begin
            data_i = new();
            data_i.reset_in             = 1'b0;
            data_i.instr_in             = 32'b000010_00000000000000000000000000; //j 0x0000000
            data_i.instr_address_in     = 32'h00000034;
            data_i.read_data_address_in = 32'h0000000c;
            data_i.instrWrite_in        = 1'b0;
            super.insert_data();
            
            @(data_i.done);

            super.obtain_data();
        end

        data_i = new();
        data_i.reset_in             = 1'b0;
        data_i.instr_in             = 32'b111111_00000000000000000000000000; //check
        data_i.instr_address_in     = 32'h00000008;
        data_i.read_data_address_in = 32'h0000000c;
        data_i.instrWrite_in        = 1'b0;
        super.insert_data();
        
        @(data_i.done);

        super.obtain_data();
        sum_instr = ~sum_instr;

        while(previous_data.read_data_out < 32'd128)//Checking sequence item
        begin
            data_i = new();
            data_i.reset_in             = 1'b0;
            
            data_i.read_data_address_in = 32'h0000000c;
            data_i.instrWrite_in        = 1'b0;

            if(sum_instr)
            begin
                data_i.instr_address_in     = 32'h00000024;
            end
            else
            begin
                data_i.instr_address_in     = 32'h00000014;
            end

            if(equal)
            begin
                data_i.instr_in = 32'b000010_00000000000000000000000000; //j 0x0000000
            end
            else
            begin
                data_i.instr_in = 32'b111111_00000000000000000000000000; //check
                sum_instr = ~sum_instr;
            end

            super.insert_data();

            @(data_i.done);
            
            equal = (data_i.read_data_out == previous_data.read_data_out) ? 1'b1 : 1'b0;

            super.obtain_data();
        end

        data_i = new();
        data_i.reset_in             = 1'b0;
        data_i.instr_in             = 32'b111111_00000000000000000000000000; //check
        data_i.instr_address_in     = previous_data.instr_address_in;
        data_i.read_data_address_in = 32'h0000000c;
        data_i.instrWrite_in        = 1'b0;
        super.insert_data();
        
        @(data_i.done);

        super.obtain_data();

    endtask : run
endclass : fibonacci_test