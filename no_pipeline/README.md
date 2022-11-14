# No pipeline
In this MIPS structure, all instructions take the same number of clock cycles (monocycle processor) to be executed (here, 1-cicle). To make it possible, it is necessary to use a memory for instructions and another for data.

## Instructions
The following instructions will be available:
 - The memory-reference instructions load word (lw) and store word (sw);
 - The arithmetic-logical instructions add, sub, AND, OR and slt;
 - The instructions branch equal (beq) and jump (j).
Other integer instructions (shift, multiply, divide) and floating point instructions will not be included in this version.

### Instruction classes
- R-type instructions

![MIPS R-type instr](alib/MIPS_R_type_instr.svg)

The opcode field [31:26] is 0, rs and rt fields are source registers, and rd the destination one. The shamt field is used for shift operations (not available in this version), and the funct field defines the ALU function to be performed (add -> 6'b100000, sub -> 6'b100010, AND -> 6'b100100, OR -> 6'b100101 and slt(store if less than) -> 6'b101010).

- Memory-reference instructions

![MIPS mr instr](alib/MIPS_memory_reference_instr.svg)

The opcode field [31:26] is 35 (6'b100011) for load and 43 (6'b101011) for store operations. The rs field indicates the register that contains the value to be added to the address field one to obtain the memory address. For load operations, register rt stores the value received from memory at the calculated address (rt <= mem[rs + address]). For store operations, register rt contais the value to be stored in memory at the calculated address (rt => mem[rs + address]).    


![MIPS np structure](alib/MIPS_np_structure.svg)