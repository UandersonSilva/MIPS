# mips

## Instruction Cycle

![instruction cycle](../alib/instruction_cycle_pipeline.svg) 

In this structure, a instruction cycle takes 5 clock cycles to be done. 

## Connections

![mips representation](../alib/mips_representation.svg)  

This MIPS description has the following connections:
- **clock_in:** main clock signal;
- **reset_in:** it resets PC to 0;
- **instr_clock_in:** clock signal for instructions writing;
- **instr_write_in:** it enables the instruction writing;
- **instr_address_in:** instruction address;
- **instr_in:** instruction to be written;
- **read_instr_out:** value in imem[instr_address_in];
- **read_data_address_in:** data address;
- **read_data_out:** value in dmem[read_data_address_in].