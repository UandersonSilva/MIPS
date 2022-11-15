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