class driver;
    virtual mips_interface mips_if;
    mailbox #(data_item) data_mbox;

    task run();
        data_item data_i;

        forever
        begin
            data_mbox.get(data_i);
            
            #0.1;
            if(data_i == null)
                $display("%0t [DRIVER]: No data item.", $time);
            else
            begin
                mips_if.send_data(data_i.instr_address_in, 
                                data_i.read_data_address_in, 
                                data_i.instr_in, 
                                data_i.instrWrite_in,
                                data_i.reset_in,
                                data_i.read_instr_out, 
                                data_i.read_data_out
                                );
                ->data_i.done;

                @(data_i.done);
            end
        end
    endtask : run

endclass : driver