package tb_pkg;
    localparam WIDTH = 32;

    typedef enum logic [5:0] {
        _r_type = 6'b000000,
        _j      = 6'b000010,
        _beq    = 6'b000100,
        _addiu  = 6'b001001,
        _lw     = 6'b100011,
        _sw     = 6'b101011,
        _check  = 6'b111111                       
    } opcode_t;

    typedef enum logic [5:0] {
        _add = 6'b100000,
        _sub = 6'b100010,
        _AND = 6'b100100,
        _OR  = 6'b100101,
        _slt = 6'b101010
    } funct_t;

    `include "./tb_classes/data_item.svh"
    `include "./tb_classes/input_transaction.svh"
    `include "./tb_classes/output_transaction.svh"
    `include "./tb_classes/transaction_port.svh"

    `include "./tb_classes/input_monitor.svh"
    `include "./tb_classes/output_monitor.svh"

    `include "./tb_classes/scoreboard.svh"

    `include "./tb_classes/driver.svh"
    `include "./tb_classes/env.svh"
    
    `include "./tb_classes/tests/base_test.svh"
    `include "./tb_classes/tests/initial_test.svh"
    `include "./tb_classes/tests/count_test.svh"
    `include "./tb_classes/tests/fibonacci_test.svh"

endpackage : tb_pkg