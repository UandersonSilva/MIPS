class count_test extends base_test;
    bit equal = 1'b0;

    task run; //Count 0-10 and after 10-0
        super.run();
        
        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b001001_00000_01010_0000000000001010; //addiu $0, $10, a
        data_i.instr_address_in     = 32'h00000000;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();
        
        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b001001_00000_00010_0000000000000001; //addiu $0, $2, 1
        data_i.instr_address_in     = 32'h00000004;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();
        
        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             =  32'b001001_00000_00001_0000000000000000; //addiu $0, $1, 0
        data_i.instr_address_in     = 32'h00000008;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b101011_00000_00001_0000000000000100; //sw $0, $1, 0x0004
        data_i.instr_address_in     = 32'h0000000c;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b000000_00001_00010_00001_00000_100000; //add $1, $2, $1
        data_i.instr_address_in     = 32'h00000010;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b101011_00000_00001_0000000000000100; //sw $0, $1, 0x0004
        data_i.instr_address_in     = 32'h00000014;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b000000_00001_01010_00011_00000_101010; //slt $1, $10, $3
        data_i.instr_address_in     = 32'h00000018;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();

        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b000100_00010_00011_1111111111111100; //beq $2, $3, 0xfffc (-4)
        data_i.instr_address_in     = 32'h0000001c;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b000000_00001_00010_00001_00000_100010; //sub $1, $2, $1
        data_i.instr_address_in     = 32'h00000020;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b101011_00000_00001_0000000000000100; //sw $0, $1, 0x0004
        data_i.instr_address_in     = 32'h00000024;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b000000_00000_00001_00011_00000_101010; //slt $0, $1, $3
        data_i.instr_address_in     = 32'h00000028;
        data_i.read_data_address_in = 32'h00000000;
        data_i.instrWrite_in        = 1'b1;
        super.insert_data();

        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.reset_in             = 1'b1;
        data_i.instr_in             = 32'b000100_00010_00011_1111111111111100; //beq $2, $3, 0xfffc (-4)
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
        data_i.read_data_address_in = 32'h00000004;
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
            data_i.read_data_address_in = 32'h00000004;
            data_i.instrWrite_in        = 1'b0;
            super.insert_data();
            
            @(data_i.done);

            super.obtain_data();
        end

        data_i = new();
        data_i.reset_in             = 1'b0;
        data_i.instr_in             = 32'b111111_00000000000000000000000000; //check
        data_i.instr_address_in     = 32'h0000000c;
        data_i.read_data_address_in = 32'h00000004;
        data_i.instrWrite_in        = 1'b0;
        super.insert_data();
        
        @(data_i.done);

        super.obtain_data();

        while(previous_data.read_data_out < 32'd10)//Checking counting 0-10
        begin
            data_i = new();
            data_i.reset_in             = 1'b0;
            data_i.instr_address_in     = 32'h00000010;
            data_i.read_data_address_in = 32'h00000004;
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
        data_i.instr_address_in     = 32'h00000010;
        data_i.read_data_address_in = 32'h00000004;
        data_i.instrWrite_in        = 1'b0;
        super.insert_data();
        
        @(data_i.done);

        super.obtain_data();

        while(previous_data.read_data_out > 32'd0)//Checking counting 10-0
        begin
            data_i = new();
            data_i.reset_in             = 1'b0;
            data_i.instr_address_in     = 32'h00000020;
            data_i.read_data_address_in = 32'h00000004;
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
        data_i.instr_address_in     = 32'h00000020;
        data_i.read_data_address_in = 32'h00000004;
        data_i.instrWrite_in        = 1'b0;
        super.insert_data();
        
        @(data_i.done);

        super.obtain_data();

    endtask : run
endclass : count_test