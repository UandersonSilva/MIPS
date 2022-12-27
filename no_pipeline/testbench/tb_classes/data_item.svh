class data_item;
    logic [WIDTH-1:0] instr_address_in, read_data_address_in, instr_in; 
    logic instrWrite_in, reset_in;
    logic [WIDTH-1:0] read_instr_out, read_data_out;

    event done;

    function bit compare(data_item compared);
        bit same = 0;
        if(compared == null)
            $display("%0t [DATA ITEM]: Null pointer. Comparison aborted.", $time);
        else
        same = (compared.instr_address_in == instr_address_in) &&
            (compared.read_data_address_in == read_data_address_in) && 
            (compared.instr_in == instr_in) && 
            (compared.instrWrite_in == instrWrite_in) &&
            (compared.reset_in == reset_in) && 
            (compared.read_instr_out == read_instr_out) &&
            (compared.read_data_out == read_data_out);;

        return same;
    endfunction : compare

    function void copy(data_item copied);
        instr_address_in     = copied.instr_address_in;
        read_data_address_in = copied.read_data_address_in;
        instr_in             = copied.instr_in;
        instrWrite_in        = copied.instrWrite_in;
        reset_in             = copied.reset_in;
        read_instr_out       = copied.read_instr_out;
        read_data_out        = copied.read_data_out;
    endfunction : copy

    function data_item clone();
        data_item cloned;
        cloned = new();

        cloned.instr_address_in     = instr_address_in;
        cloned.read_data_address_in = read_data_address_in;
        cloned.instr_in             = instr_in;
        cloned.instrWrite_in        = instrWrite_in;
        cloned.reset_in             = reset_in;
        cloned.read_instr_out       = read_instr_out;
        cloned.read_data_out        = read_data_out;

        return cloned;
    endfunction : clone

    function string convert2string_b();
        string s, instr_format_in, instr_format_out;

        case(instr_in[31:26])
            _r_type:
            begin
                instr_format_in = $sformatf("%6b_%5b_%5b_%5b_%5b_%6b", instr_in[31:26], 
                                                                    instr_in[25:21], 
                                                                    instr_in[20:16],
                                                                    instr_in[15:11],
                                                                    instr_in[10:6],
                                                                    instr_in[5:0]);
            end

            _j:
            begin
                instr_format_in = $sformatf("%6b_%26b", instr_in[31:26], instr_in[25:0]);       
            end

            _check:
            begin
                instr_format_in = $sformatf("checking");
            end

            default:
            begin
                instr_format_in = $sformatf("%6b_%5b_%5b_%16b", instr_in[31:26], 
                                                            instr_in[25:21], 
                                                            instr_in[20:16], 
                                                            instr_in[15:0]);
            end
        endcase

        case(read_instr_out[31:26])
            _r_type:
            begin
                instr_format_out = $sformatf("%6b_%5b_%5b_%5b_%5b_%6b", read_instr_out[31:26], 
                                                                    read_instr_out[25:21], 
                                                                    read_instr_out[20:16],
                                                                    read_instr_out[15:11],
                                                                    read_instr_out[10:6],
                                                                    read_instr_out[5:0]);
            end

            _j:
            begin
                instr_format_out = $sformatf("%6b_%26b", read_instr_out[31:26], read_instr_out[25:0]);       
            end

            _check:
            begin
                instr_format_in = $sformatf("checking");
            end

            default:
            begin
                instr_format_out = $sformatf("%6b_%5b_%5b_%16b", read_instr_out[31:26], 
                                                            read_instr_out[25:21], 
                                                            read_instr_out[20:16], 
                                                            read_instr_out[15:0]);
            end
        endcase


        s = $sformatf("instr_address_in: %32b", instr_address_in, 
        " instr_in: %s", instr_format_in, " instrWrite_in: %b", instrWrite_in, 
        " reset_in: %b", reset_in, " read_data_address_in: %32b", read_data_address_in, 
        " :: read_instr_out: %s", instr_format_out, " read_data_out: %32b", read_data_out);

        return s;
    endfunction : convert2string_b

    function string convert2string();
        string s, instr_format_in, instr_format_out;
        opcode_t opcode;
        funct_t funct;

        opcode = opcode_t'(instr_in[31:26]);
        funct  = funct_t'(instr_in[5:0]);

        case(opcode)
            _r_type:
            begin
                if(funct == 6'b000000)
                    instr_format_in = $sformatf("end");
                else
                begin
                    instr_format_in = $sformatf("%s $%0d, $%0d, $%0d", funct.name(), 
                                                                instr_in[25:21], 
                                                                instr_in[20:16],
                                                                instr_in[15:11]);
                end
            end

            _j:
            begin
                instr_format_in = $sformatf("%s 0x%7h", opcode.name(), instr_in[25:0]);       
            end

            _check:
            begin
                instr_format_in = $sformatf("checking");
            end

            default:
            begin
                instr_format_in = $sformatf("%s $%0d, $%0d, 0x%4h", opcode.name(), 
                                                            instr_in[25:21], 
                                                            instr_in[20:16], 
                                                            instr_in[15:0]);
            end
        endcase

        opcode = opcode_t'(read_instr_out[31:26]);
        funct  = funct_t'(read_instr_out[5:0]);

        case(opcode)
            _r_type:
            begin
                if(funct == 6'b000000)
                    instr_format_out = $sformatf("end");
                else
                begin
                    instr_format_out = $sformatf("%s $%0d, $%0d, $%0d", funct.name(), 
                                                                instr_in[25:21], 
                                                                instr_in[20:16],
                                                                instr_in[15:11]);
                end
            end

            _j:
            begin
                instr_format_out = $sformatf("%s 0x%7h", opcode.name(), read_instr_out[25:0]);       
            end

            _check:
            begin
                instr_format_in = $sformatf("checking");
            end

            default:
            begin
                instr_format_out = $sformatf("%s $%0d, $%0d, 0x%4h", opcode.name(), 
                                                            read_instr_out[25:21], 
                                                            read_instr_out[20:16], 
                                                            read_instr_out[15:0]);
            end
        endcase

        s = {$sformatf("instr_address_in: 0x%8h", instr_address_in), 
        $sformatf(" instr_in: "), instr_format_in, $sformatf(" instrWrite_in: %b", instrWrite_in),
        $sformatf(" reset_in: %b", reset_in), $sformatf(" read_data_address_in: 0x%8h", read_data_address_in), 
        $sformatf(" :: read_instr_out: "), instr_format_out, $sformatf(" read_data_out: 0x%8h", read_data_out)};

        return s;
    endfunction : convert2string

endclass : data_item