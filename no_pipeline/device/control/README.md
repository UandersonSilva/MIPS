# Control

The Control device sends commands according to the opcode input. When an unknown input is detected, all outputs are set to 0. 

## Control codes

opcode |Instr. type  | Branch | Jump | MemtoReg | MemRead | MemWrite | AluSrc | AluOp | RegWrite | RegDst
-------|------------ |--------|------|----------|---------|----------|--------|-------|----------|---------
000000 |R-type       |0       |0     |0         |0        |0         |0       |10     |1         |1
001001 |I-type(addiu)|0       |0     |0         |0        |0         |1       |00     |1         |1
100011 |mem-ref(lw)  |0       |0     |1         |1        |0         |1       |00     |1         |0
101011 |mem-ref(sw)  |0       |0     |x         |0        |1         |1       |00     |0         |x
000100 |branch(beq)  |1       |0     |x         |0        |0         |0       |01     |0         |x
000010 |jump         |x       |1     |x         |0        |0         |0       |xx     |0         |x

## Runtime output (test/control_test.sv)

#control_code: branch[9], jump[8], memtoReg[7], memRead[6], memWrite[5], aluSrc[4], aluOp[3:2], regWrite[1], regDst[0]  
#[1] opcode_in: 000000 => control_code: 0000001011  
#[2] opcode_in: 000010 => control_code: 0100000000  
#[3] opcode_in: 000100 => control_code: 1000000100
#[4] opcode_in: 001001 => control_code: 0000010011  
#[5] opcode_in: 100011 => control_code: 0011010010  
#[6] opcode_in: 101011 => control_code: 0000110000  
#[7] opcode_in: 111111 => control_code: 0000000000  