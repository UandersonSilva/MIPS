# ALU 
ALU control codes according to the function to be required:

Function | aluCtrl     | Semantics
---------|-------------|----------------------------------------------------------------
AND      | 0000        |   OUT = A and B (bitwise AND); Zero is updated
OR       | 0001	       |   OUT = A or B (bitwise OR); Zero is updated
add      | 0010 	   |   OUT = A + B; Zero is updated
sub      | 0110	       |   OUT = A - B; Zero is updated
slt	     | 0111	       |   OUT = (A < B) ? 1 : 0; Zero is updated 
NOR      | 1100        |   OUT = ~(A or B) (bitwise NOR); Zero is updated
others   | others      |   OUT = Z (High impedance); Zero is updated

## Runtime outputs (test/alu_test.sv)

Running on edaplayground platform => 
[mips_alu](https://www.edaplayground.com/x/kRVN)

#KERNEL: [1] a_in: 0x0040 _and b_in: 0x00ff => alu_out: 0x0040 zero_out: 0  
#KERNEL: [2] a_in: 0x0040 _or b_in: 0x00ff => alu_out: 0x00ff zero_out: 0  
#KERNEL: [3] a_in: 64 _add b_in: 255 => alu_out: 319 zero_out: 0  
#KERNEL: [4] a_in: 64 _sub b_in: 255 => alu_out: -191 zero_out: 0  
#KERNEL: [5] a_in: 0x0040 _nor b_in: 0x00ff => alu_out: 0xff00 zero_out: 0  
#KERNEL: [6] a_in: 64 _slt b_in: 255 => alu_out: 1 zero_out: 0  
#KERNEL: [7] a_in: 255 _slt b_in: 64 => alu_out: 0 zero_out: 0  
#KERNEL: [8] a_in: 255 _slt b_in: 255 => alu_out: 0 zero_out: 1  