class input_monitor;
    transaction_port #(input_transaction) monitor_tp;

    function void read(logic [WIDTH-1:0] instr_address_in, 
                        logic [WIDTH-1:0] read_data_address_in, 
                        logic [WIDTH-1:0] instr_in,
                        logic instrWrite_in);
        input_transaction t_in;
        t_in = new();

        t_in.instr_address_in     = instr_address_in;
        t_in.read_data_address_in = read_data_address_in;
        t_in.instr_in             = instr_in;
        t_in.instrWrite_in        = instrWrite_in;
        t_in.reset_in             = reset_in;

        monitor_tp.write(t_in);
    endfunction : read
endclass : input_monitor