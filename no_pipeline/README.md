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

![MIPS np structure](alib/MIPS_R_type_instr.svg)

The opcode field (31:26) is 0, rs and rt fields are source registers, and rd the destination one. The shamt field is used for shift operations (not available in this version), and the funct field defines the ALU function to be performed (add -> 6'b100000, sub -> 6'b100010, AND -> 6'b100100, OR -> 6'b100101 and slt(store if less than) -> 6'b101010).


![MIPS np structure](alib/MIPS_np_structure.svg)