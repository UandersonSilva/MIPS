interface mips_interface();
    import tb_pkg::*;

    logic clock, reset_in; 
    logic instrWrite_in; 
    logic [WIDTH - 1:0] instr_address_in, read_data_address_in;
    logic [WIDTH - 1:0] instr_in;
    logic [WIDTH - 1:0] read_instr_out, read_data_out;

    input_monitor  input_monitor_r;
    output_monitor output_monitor_r;

    event input_read;
    event output_read;

    initial
    begin
        clock = 0;
        forever 
        begin
           #1;
           clock = ~clock;
        end
    end

    task send_data(
            input logic [WIDTH-1:0] iinstr_address,
            input logic [WIDTH-1:0] iread_data_address,
            input logic [WIDTH-1:0] iinstr,
            input logic iinstrWrite,
            input logic ireset,
            output logic [WIDTH-1:0] oread_instr,
            output logic [WIDTH-1:0] oread_data
        );

        @(negedge clock);
        #0.1;
        instr_address_in     = iinstr_address;
        read_data_address_in = iread_data_address;
        instr_in             = iinstr;
        instrWrite_in        = iinstrWrite;
        reset_in             = ireset;         

        @(negedge clock);
        #0.1
        oread_instr = read_instr_out;
        oread_data  = read_data_out;
        
    endtask : send_data

    always @(posedge clock)
    begin : input_monitor_read
        input_monitor_r.read(instr_address_in, read_data_address_in, instr_in, instrWrite_in, reset_in);
        -> input_read;
    end

    always @(negedge clock)
    begin : output_monitor_read
        
        output_monitor_r.read(read_instr_out, read_data_out);
        -> output_read;
    end
endinterface : mips_interface