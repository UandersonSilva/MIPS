class multiplication_test extends base_test;
    bit equal = 1'b0;

    task run;//It Performs a sequence of sum operations to reach the value of the 11x9 multiplication. 
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
        data_i.instr_in             = 32'b001001_00000_10100_0000000000001011; //addiu $0, $20, 0xb (11)
        data_i.instr_address_in     = 32'h00000004;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b001001_00000_00111_0000000000001001; //addiu $0, $7, 9
        data_i.instr_address_in     = 32'h00000008;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();

        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b001001_00000_00101_0000000000000000; //addiu $0, $5, 0
        data_i.instr_address_in     = 32'h0000000c;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();

        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b001001_00000_00100_0000000000000000; //addiu $0, $4, 0
        data_i.instr_address_in     = 32'h00000010;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();

        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b001001_00000_00011_0000000000000000; //addiu $0, $3, 0
        data_i.instr_address_in     = 32'h00000014;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();

        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b101011_00000_00101_0000000000001100; //sw $0, $5, 0x000c
        data_i.instr_address_in     = 32'h00000018;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b000000_00101_10100_00101_00000_100000; //add $5, $20, $5
        data_i.instr_address_in     = 32'h0000001c;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b101011_00000_00101_0000000000001100; //sw $0, $5, 0x000c
        data_i.instr_address_in     = 32'h00000020;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b000000_00100_00001_00100_00000_100000; //add $4, $1, $4
        data_i.instr_address_in     = 32'h00000024;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b000000_00100_00111_00011_00000_101010; //slt $4, $7, $3
        data_i.instr_address_in     = 32'h00000028;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();

        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b000100_00001_00011_1111111111111011; //beq $1, $3, 0xfffb (-5)
        data_i.instr_address_in     = 32'h0000002c;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b000010_00000000000000000000000000; //j 0x0000000
        data_i.instr_address_in     = 32'h00000030;
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
            data_i.instr_address_in     = 32'h00000030;
            data_i.read_data_address_in = 32'h0000000c;
            data_i.instrWrite_in        = 1'b0;
            super.insert_data();
            
            @(data_i.done);

            super.obtain_data();
        end

        data_i = new();
        data_i.reset_in             = 1'b0;
        data_i.instr_in             = 32'b111111_00000000000000000000000000; //check
        data_i.instr_address_in     = 32'h00000018;
        data_i.read_data_address_in = 32'h0000000c;
        data_i.instrWrite_in        = 1'b0;
        super.insert_data();
        
        @(data_i.done);

        super.obtain_data();

        while(previous_data.read_data_out < 32'd99)//Checking
        begin
            data_i = new();
            data_i.reset_in             = 1'b0;
            data_i.instr_address_in     = 32'h0000001c;
            data_i.read_data_address_in = 32'h0000000c;
            data_i.instrWrite_in        = 1'b0;

            if(equal)
            begin
                data_i.instr_in = 32'b000010_00000000000000000000000000; //j 0x0000000
            end
            else
            begin
                data_i.instr_in = 32'b111111_00000000000000000000000000; //check
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
endclass : multiplication_test