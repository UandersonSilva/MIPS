class initial_test extends base_test;
    task run;
        super.run();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b101011_00000_00000_0000000000000000; //sw $0, $0, 0
        data_i.instr_address_in     = 32'h00000000;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1; 
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b001001_00000_00101_0000000000000101; //addiu $0, $5, 5
        data_i.instr_address_in     = 32'h00000004;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b101011_00000_00101_0000000000001100; //sw $0, $5, c
        data_i.instr_address_in     = 32'h00000008;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b000000_00000_00101_00011_00000_101010; //slt $0, $5, $3, 0x0000
        data_i.instr_address_in     = 32'h0000000c;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();

        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b101011_00000_00011_0000000000000100; //sw $0, $3, 0x0004
        data_i.instr_address_in     = 32'h00000010;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();

        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b001001_00000_00100_0000000000001111; //addiu $0, $4, 0x000f
        data_i.instr_address_in     = 32'h00000014;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();

        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b000000_00100_00101_00110_00000_100100; //and $4, $5, $6, 0x00
        data_i.instr_address_in     = 32'h00000018;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b101011_00000_00110_0000000000001000; //sw $0, $6, 0x0008
        data_i.instr_address_in     = 32'h0000001c;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b000000_00100_00101_00111_00000_100101; //or $4, $5, $7, 0x00
        data_i.instr_address_in     = 32'h00000020;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b101011_00000_00111_0000000000010000; //sw $0, $7, 0x0010
        data_i.instr_address_in     = 32'h00000024;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b000000_00100_00101_01000_00000_100000; //add $4, $5, $8, 0x00
        data_i.instr_address_in     = 32'h00000028;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b101011_00000_01000_0000000000010100; //sw $0, $8, 0x0014
        data_i.instr_address_in     = 32'h0000002c;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b000000_00100_00101_01001_00000_100010; //sub $4, $5, $9, 0x00
        data_i.instr_address_in     = 32'h00000030;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b101011_00000_01001_0000000000011000; //sw $0, $9, 0x0018
        data_i.instr_address_in     = 32'h00000034;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b100011_00000_01011_0000000000011000; //lw $0, $11, 0x0018
        data_i.instr_address_in     = 32'h00000038;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b101011_00000_01011_0000000000011100; //sw $0, $11, 0x001c
        data_i.instr_address_in     = 32'h0000003c;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b000100_00000_00000_0000000000000001; //beq $0, $0, 0x0001
        data_i.instr_address_in     = 32'h00000040;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b101011_00000_01011_0000000000011100; //sw $0, $11, 0x001c
        data_i.instr_address_in     = 32'h00000044;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b000010_00000000000000000000000000; //j 0x0000000
        data_i.instr_address_in     = 32'h00000048;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        //Start execution

        while($isunknown(previous.read_data_out))
        begin
            data_i = new();
            data_i.reset_in             = 1'b0;
            data_i.instr_in             = 32'b000010_00000000000000000000000000; //j 0x0000000
            data_i.instr_address_in     = 32'h00000048;
            data_i.read_data_address_in = 32'h0000001c;
            data_i.instrWrite_in        = 1'b0;
            super.insert_data();
            
            @(data_i.done);

            super.obtain_data();
        end

        data_i = new();
        data_i.reset_in             = 1'b0;
        data_i.instr_in             = 32'b111111_00000000000000000000000000; //check
        data_i.instr_address_in     = 32'h00000048;
        data_i.read_data_address_in = 32'h00000004;
        data_i.instrWrite_in        = 1'b0;
        super.insert_data();
        
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b0;
        data_i.instr_in             = 32'b111111_00000000000000000000000000; //check
        data_i.instr_address_in     = 32'h00000048;
        data_i.read_data_address_in = 32'h00000008;
        data_i.instrWrite_in        = 1'b0;
        super.insert_data();
        
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b0;
        data_i.instr_in             = 32'b111111_00000000000000000000000000; //check
        data_i.instr_address_in     = 32'h00000048;
        data_i.read_data_address_in = 32'h0000000c;
        data_i.instrWrite_in        = 1'b0;
        super.insert_data();
        
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b0;
        data_i.instr_in             = 32'b111111_00000000000000000000000000; //check
        data_i.instr_address_in     = 32'h00000048;
        data_i.read_data_address_in = 32'h00000010;
        data_i.instrWrite_in        = 1'b0;
        super.insert_data();
        
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b0;
        data_i.instr_in             = 32'b111111_00000000000000000000000000; //check
        data_i.instr_address_in     = 32'h00000048;
        data_i.read_data_address_in = 32'h00000014;
        data_i.instrWrite_in        = 1'b0;
        super.insert_data();
        
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b0;
        data_i.instr_in             = 32'b111111_00000000000000000000000000; //check
        data_i.instr_address_in     = 32'h00000048;
        data_i.read_data_address_in = 32'h00000018;
        data_i.instrWrite_in        = 1'b0;
        super.insert_data();
        
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b0;
        data_i.instr_in             = 32'b111111_00000000000000000000000000; //check
        data_i.instr_address_in     = 32'h00000048;
        data_i.read_data_address_in = 32'h0000001c;
        data_i.instrWrite_in        = 1'b0;
        super.insert_data();
        
        @(data_i.done);

        super.obtain_data();
    endtask : run
endclass : initial_test