# ALU Control
The AlU control receives aluOp code from main Control and funct field from the current instruction and, according to these inputs, defines the aluCtrl code to request the correct ALU action.

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
R-type           |   10   |slt        |100010         |slt         |0111