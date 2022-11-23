# Control

## Control codes

opcode |Instr. type | Branch | Jump | MemtoReg | MemRead | MemWrite | AluSrc | AluOp | RegWrite | RegDst
-------|------------|--------|------|----------|---------|----------|--------|-------|----------|---------
000000 |R-type      |0       |0     |0         |0        |0         |0       |10     |1         |1
100011 |mem-ref(lw) |0       |0     |1         |1        |0         |1       |00     |1         |0
101011 |mem-ref(sw) |0       |0     |x         |0        |1         |1       |00     |0         |x
000100 |branch(beq) |1       |0     |x         |0        |0         |0       |01     |0         |x
000010 |jump        |x       |1     |x         |0        |0         |0       |xx     |0         |x