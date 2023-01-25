# Pipeline
In this MIPS structure, the instructions execution is divided into five stages (five-stage pipeline). These stages are:  
 - Instruction Fetch (**IF**);
 - Instruction Decode (**ID**);
 - Execution or address calculation (**EX**);
 - Data Memory access (**MEM**);
 - Write Back (**WB**).  

## Instructions
The following instructions will be available:
 - The memory-reference instructions load word (lw) and store word (sw);
 - The arithmetic-logical R-type (register reference) instructions add, sub, AND, OR and slt;
 - The arithmetic-logical I-type (immediate) addiu;
 - The instructions branch equal (beq) and jump (j).
Other integer instructions (shift, multiply, divide) and floating point instructions will not be included in this version.

### Instruction classes
- R-type instructions

![MIPS R-type instr](alib/MIPS_R_type_instr.svg)

The opcode field [31:26] is 0, rs and rt fields are source registers, and rd the destination one. The shamt field is used for shift operations (not available in this version), and the funct field defines the ALU function to be performed (add -> 6'b100000, sub -> 6'b100010, AND -> 6'b100100, OR -> 6'b100101 and slt(set on less than) -> 6'b101010).

- I-type instructions

![MIPS I-type instr](alib/MIPS_I_type_instr.svg)

The opcode field is 9 (6'b001001) for addiu. The rs register contains one of the sources values and the rt is the destination register. The other source value comes from the 16-bit immediate field, that is extended to a 32-bit word according to the operation. If the operation to be performed is addiu, it is used the sign extended value. Otherwise, it is used the zero extended value.

- Memory-reference instructions

![MIPS mr instr](alib/MIPS_memory_reference_instr.svg)

The opcode field [31:26] is 35 (6'b100011) for load and 43 (6'b101011) for store operations. The rs field indicates the register that contains the value to be added to the address field one to obtain the memory address. For load operations, register rt stores the value received from memory at the calculated address (rt <= mem[rs + address]). For store operations, register rt contais the value to be stored in memory at the calculated address (rt => mem[rs + address]).    

- Branch instruction

![MIPS branch instr](alib/MIPS_branch_instr.svg)

The opcode field [31:26] is 4 (6'b000100) for branch equal (beq). The registers rs and rt as sources for the comparison operation. The address field value is extended, shifted left by 2 and added to the next PC value (PC + 4 + address) to obtain the branch target address.

- Jump instruction

![MIPS j instr](alib/MIPS_j_instr.svg)

The opcode field [31:26] is 2 (6'b000010) for jump (j). The jump target address is composed by the 4 most significant bits of current PC + 4 (next instruction address) concatenated with the 26-bit address field. The 2 least significant bits remaining receive 00.  
jump_address <= {PC_plus_4[31:28], address, 2'b00}

## Structure

![MIPS np structure](alib/MIPS_structure.svg)  

The following actions are performed at each stage:
 - Instruction Fetch (**IF**): The instruction pointed to by the PC value is read from instruction memory and the PC is updated;  
 - Instruction Decode (**ID**); The instruction is decoded, the control signals for its execution are generated and the requested data is read from the register file. Furthermore, if it is the **beq** or **j** instruction, its execution is done at this stage as well;  
 - Execution or address calculation (**EX**): According to the values generated in the **ID** stage, the instruction is executed or the data memory address is obtained;
 - Data Memory access (**MEM**): If it is a memory access instruction (**lw** or **sw**), the data memory is accessed for reading or writing;
 - Write Back (**WB**): The execution result is stored in the register file according to the instruction.