class input_transaction;
    logic [WIDTH-1:0] instr_address_in, read_data_address_in, instr_in;
    logic instrWrite_in, reset_in;

    function bit compare(input_transaction compared);
        bit same = 0;
        if(compared == null)
            $display("%0t [INPUT TRANSACTION]: Null pointer. Comparison aborted.", $time);
        else
            same = (compared.instr_address_in == instr_address_in) &&
                   (compared.read_data_address_in == read_data_address_in) && 
                   (compared.instr_in == instr_in) && 
                   (compared.instrWrite_in == instrWrite_in) && 
                   (compared.reset_in == reset_in);
        return same;
    endfunction : compare

    function void copy(input_transaction copied);
        instr_address_in     = copied.instr_address_in;
        read_data_address_in = copied.read_data_address_in;
        instr_in             = copied.instr_in;
        instrWrite_in        = copied.instrWrite_in;
        reset_in             = copied.reset_in;
    endfunction : copy

    function input_transaction clone();
        input_transaction cloned;
        cloned = new();

        cloned.instr_address_in     = instr_address_in;
        cloned.read_data_address_in = read_data_address_in;
        cloned.instr_in             = instr_in;
        cloned.instrWrite_in        = instrWrite_in;
        cloned.reset_in             = reset_in;

        return cloned;
    endfunction : clone

    function string convert2string_b();
        string s, instr_format;

        case(instr_in[31:26])
            _r_type:
            begin
                instr_format = $sformatf("%6b_%5b_%5b_%5b_%5b_%6b", instr_in[31:26], 
                                                                    instr_in[25:21], 
                                                                    instr_in[20:16],
                                                                    instr_in[15:11],
                                                                    instr_in[10:6],
                                                                    instr_in[5:0]);
            end

            _j:
            begin
                instr_format = $sformatf("%6b_%26b", instr_in[31:26], instr_in[25:0]);       
            end

            default:
            begin
                instr_format = $sformatf("%6b_%5b_%5b_%16b", instr_in[31:26], 
                                                            instr_in[25:21], 
                                                            instr_in[20:16], 
                                                            instr_in[15:0]);
            end
        endcase

        s = $sformatf("instr_address_in: %32b", instr_address_in, 
        " instr_in: ", instr_format, "instrWrite_in: %b", instrWrite_in, 
        " reset_in: %b", reset_in, " read_data_address_in: %32b", read_data_address_in);

        return s;
    endfunction : convert2string_b

    function string convert2string();
        string s, instr_format;
        opcode_t opcode;
        funct_t funct;

        opcode = opcode_t'(instr_in[31:26]);
        funct = funct_t'(instr_in[5:0]);

        case(opcode)
            _r_type:
            begin
                if(funct == 6'b000000)
                    instr_format = $sformatf("end");
                else
                begin
                    instr_format = $sformatf("%s $%0d, $%0d, $%0d", funct.name(), 
                                                                instr_in[25:21], 
                                                                instr_in[20:16],
                                                                instr_in[15:11]);
                end
            end

            _j:
            begin
                instr_format = $sformatf("%s 0x%7h", opcode.name(), instr_in[25:0]);       
            end

            _check:
            begin
                instr_format = $sformatf("checking");
            end

            default:
            begin
                instr_format = $sformatf("%s $%0d, $%0d, 0x%4h", opcode.name(), 
                                                            instr_in[25:21], 
                                                            instr_in[20:16], 
                                                            instr_in[15:0]);
            end
        endcase

        s = $sformatf("instr_address_in: 0x%8h", instr_address_in, 
        " instr_in: ", instr_format, " instrWrite_in: ", instrWrite_in,
        " reset_in: %b", reset_in, " read_data_address_in: 0x%8h", read_data_address_in);

        return s;
    endfunction : convert2string

endclass : input_transaction