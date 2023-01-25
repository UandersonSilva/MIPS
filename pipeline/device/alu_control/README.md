# ALU Control
The ALU control receives aluOp code from main Control and funct field from the current instruction and, according to these inputs, defines the aluCtrl code to request the correct ALU action.

## Control Codes

Instruction Type | aluOp  | Operation |Function Field | ALU action | aluCtrl
-----------------|--------|-----------|---------------|------------|---------
Memory-reference |   00   |lw         |xxxxxx         |add         |0010
Memory-reference |   00   |sw         |xxxxxx         |add         |0010
Branch           |   01   |beq        |xxxxxx         |sub         |0110
R-type           |   10   |add        |100000         |add         |0010
R-type           |   10   |sub        |100010         |sub         |0110
R-type           |   10   |AND        |100100         |AND         |0000
R-type           |   10   |OR         |100101         |OR          |0001
R-type           |   10   |slt        |101010         |slt         |0111

## Runtime output (test/ac_test.sv)

#[1] aluOp_in: 00 funct_in: 000000 => aluCtrl_out: 0010  
#[2] aluOp_in: 01 funct_in: 000000 => aluCtrl_out: 0110  
#[3] aluOp_in: 10 funct_in: 100000 => aluCtrl_out: 0010  
#[4] aluOp_in: 10 funct_in: 100010 => aluCtrl_out: 0110  
#[5] aluOp_in: 10 funct_in: 100100 => aluCtrl_out: 0000  
#[6] aluOp_in: 10 funct_in: 100101 => aluCtrl_out: 0001  
#[7] aluOp_in: 10 funct_in: 101010 => aluCtrl_out: 0111  
#[8] aluOp_in: 10 funct_in: 100111 => aluCtrl_out: 0000  
#[9] aluOp_in: 11 funct_in: 000000 => aluCtrl_out: 0000  