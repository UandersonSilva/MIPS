`include "../device/mips_np.sv"
`include "tb_pkg.sv"
`include "mips_interface.sv"

module tb_top;
    import tb_pkg::*;

    mips_interface mips_if();

    mips_np mnp0(
        .clock_in(mips_if.clock), 
        .reset_in(mips_if.reset_in), 
        .instr_clock_in(mips_if.clock), 
        .instrWrite_in(mips_if.instrWrite_in), 
        .instr_address_in(mips_if.instr_address_in), 
        .read_data_address_in(mips_if.read_data_address_in),
        .instr_in(mips_if.instr_in),
        .read_instr_out(mips_if.read_instr_out), 
        .read_data_out(mips_if.read_data_out)
    );

    initial
    begin
        string test_name;

        base_test t0;
        
        $value$plusargs("TEST=%s", test_name);

        case(test_name)
            "INITIAL_TEST":
            begin
                initial_test selected;
                selected = new();
                t0 = selected;
            end

            "COUNT_TEST":
            begin
                count_test selected;
                selected = new();
                t0 = selected;
            end

            default:
            begin
                initial_test selected;
                selected = new();
                t0 = selected;
                test_name = $sformatf("DEFAULT(INITIAL_TEST)");
            end
        endcase

        t0.env_r.mips_if = mips_if;

        $display("%c[2;35m", 27, "[TB_TOP] Running %s", test_name);
        $display("%c[0m", 27);
        
        t0.run();
        #2;
        $finish;
    end
endmodule : tb_top