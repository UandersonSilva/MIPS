class output_transaction;
    logic [WIDTH-1:0] read_instr_out, read_data_out;

    function bit compare(output_transaction compared);
        bit same;
   
        same = (compared.read_instr_out == read_instr_out) &&
                (compared.read_data_out == read_data_out);
        return same;
    endfunction : compare

    function void copy(output_transaction copied);
        read_instr_out = copied.read_instr_out;
        read_data_out  = copied.read_data_out;
    endfunction : copy

    function output_transaction clone();
        output_transaction cloned;
        cloned = new();

        cloned.read_instr_out = read_instr_out;
        cloned.read_data_out  = read_data_out;

        return cloned;
    endfunction : clone

    function string convert2string_b();
        string s, instr_format;

        case(read_instr_out[31:26])
            _r_type:
            begin
                instr_format = $sformatf("%6b_%5b_%5b_%5b_%5b_%6b", read_instr_out[31:26], 
                                                                    read_instr_out[25:21], 
                                                                    read_instr_out[20:16],
                                                                    read_instr_out[15:11],
                                                                    read_instr_out[10:6],
                                                                    read_instr_out[5:0]);
            end

            _j:
            begin
                instr_format = $sformatf("%6b_%26b", read_instr_out[31:26], read_instr_out[25:0]);       
            end

            default:
            begin
                instr_format = $sformatf("%6b_%5b_%5b_%16b", read_instr_out[31:26], 
                                                            read_instr_out[25:21], 
                                                            read_instr_out[20:16], 
                                                            read_instr_out[15:0]);
            end
        endcase

        s = $sformatf("read_instr_out: ", instr_format, " read_data_out: %32b", read_data_out);

        return s;
    endfunction : convert2string_b

    function string convert2string();
        string s, instr_format;
        opcode_t opcode;
        funct_t funct;

        opcode = opcode_t'(read_instr_out[31:26]);
        funct = funct_t'(read_instr_out[5:0]);

        case(opcode)
            _r_type:
            begin
                if(funct == 6'b000000)
                    instr_format = $sformatf("end");
                else
                begin
                    instr_format = $sformatf("%s $%0d, $%0d, $%0d", funct.name(), 
                                                                read_instr_out[25:21], 
                                                                read_instr_out[20:16],
                                                                read_instr_out[15:11]);
                end
            end

            _j:
            begin
                instr_format = $sformatf("%s 0x%7h", opcode.name(), read_instr_out[25:0]);       
            end

            _check:
            begin
                instr_format = $sformatf("checking");
            end

            default:
            begin
                instr_format = $sformatf("%s $%0d, $%0d, 0x%4h", opcode.name(), 
                                                            read_instr_out[25:21], 
                                                            read_instr_out[20:16], 
                                                            read_instr_out[15:0]);
            end
        endcase

        s = $sformatf("read_instr_out: ", instr_format, " read_data_out: 0x%8h", read_data_out);

        return s;
    endfunction : convert2string

endclass : output_transaction