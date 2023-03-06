class output_monitor;
    transaction_port #(output_transaction) monitor_tp;
    
    function void read(logic [WIDTH-1:0] read_instr_out, 
                        logic [WIDTH-1:0] read_data_out);
        output_transaction t_out;
        t_out = new();

        t_out.read_instr_out = read_instr_out;
        t_out.read_data_out  = read_data_out;

        monitor_tp.write(t_out);
    endfunction : read
endclass : output_monitor