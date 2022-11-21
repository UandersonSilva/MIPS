# Memory
MIPS memory access is based on byte addressing. This means that each address references one byte in memory and a full word (32 bits) occupies 4 addresses (4 bytes). It is possible to access each byte individually, half words and full word. This version of MIPS only supports full word access.

## Access codes (for writing)
write | memMode  | Semantics
------|----------|--------------------------------------------------------------------------------------
word  |    00    |   mem[write_address_in[address_width-1:2]] <= write_data_in // 4 bytes at once
word  |    01    |   mem[write_address_in[address_width-1:2]] <= write_data_in  // 4 bytes at once
half  |    10    |   mem[write_address_in[address_width-1:1]] <= write_data_in[15:0] // 2 bytes at once
byte  |    11    |   mem[write_address_in[address_width-1:0]] <= write_data_in[7:0] // 1 byte at once
