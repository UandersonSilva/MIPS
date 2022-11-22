# Memory
MIPS memory access is based on byte addressing. This means that each address references one byte in memory and a full word (32 bits) occupies 4 addresses (4 bytes). It is possible to access each byte individually, half words and full word. This version of MIPS only supports full word access.

## Access codes (for writing)

write | memMode  | Semantics
------|----------|--------------------------------------------------------------------------------------
word  |    0x    |   mem[write_address_in[address_width-1:2]] <= write_data_in // 4 bytes at once
half  |    10    |   mem[write_address_in[address_width-1:1]] <= write_data_in[15:0] // 2 bytes at once
byte  |    11    |   mem[write_address_in[address_width-1:0]] <= write_data_in[7:0] // 1 byte at once

## Runtime output (test/tpm_test.sv)

#[3] read_address_0: 0x00 read_data_0: 0xxxxxxxxx  
#read_address_1: xff read_data_1: 0xxxxxxxxx  
#write_address: x00 write_data: 0x00000001 memWrite: 1 memMode: 00 clock: 1  

#[5] read_address_0: 0x00 read_data_0: 0x00000001  
#read_address_1: xff read_data_1: 0xxxxxxxxx  
#write_address: x00 write_data: 0x00000001 memWrite: 0 memMode: 00 clock: 1  

#[7] read_address_0: 0x00 read_data_0: 0x00000001  
#read_address_1: xff read_data_1: 0xxxxxxxxx  
#write_address: xff write_data: 0xffff0f05 memWrite: 1 memMode: 00 clock: 1  

#[9] read_address_0: 0x00 read_data_0: 0x00000001  
#read_address_1: xff read_data_1: 0xffff0f05  
#write_address: xff write_data: 0xffff0f05 memWrite: 0 memMode: 00 clock: 1  

#[11] read_address_0: 0x1c read_data_0: 0x00000001  
#read_address_1: xff read_data_1: 0xffff0f05  
#write_address: x1c write_data: 0xffffabab memWrite: 1 memMode: 11 clock: 1  

#[13] read_address_0: 0x1c read_data_0: 0xxxxxxxab  
#read_address_1: xff read_data_1: 0xffff0f05  
#write_address: x1c write_data: 0xffffabab memWrite: 0 memMode: 11 clock: 1  

#[15] read_address_0: 0x1c read_data_0: 0xxxxxxxab  
#read_address_1: xff read_data_1: 0xffff0f05  
#write_address: x1d write_data: 0x1f7fcd00 memWrite: 1 memMode: 11 clock: 1  

#[17] read_address_0: 0x1c read_data_0: 0xxxxx00ab  
#read_address_1: xff read_data_1: 0xffff0f05  
#write_address: x1d write_data: 0x1f7fcd00 memWrite: 0 memMode: 11 clock: 1  

#[19] read_address_0: 0x1c read_data_0: 0xxxxx00ab  
#read_address_1: xff read_data_1: 0xffff0f05  
#write_address: x1e write_data: 0x4321fab0 memWrite: 1 memMode: 11 clock: 1  

#[21] read_address_0: 0x1c read_data_0: 0xxxb000ab  
#read_address_1: xff read_data_1: 0xffff0f05  
#write_address: x1e write_data: 0x4321fab0 memWrite: 0 memMode: 11 clock: 1  

#[23] read_address_0: 0x1c read_data_0: 0xxxb000ab  
#read_address_1: xff read_data_1: 0xffff0f05  
#write_address: x1f write_data: 0x8197f11b memWrite: 1 memMode: 11 clock: 1  

#[25] read_address_0: 0x1c read_data_0: 0x1bb000ab  
#read_address_1: xff read_data_1: 0xffff0f05  
#write_address: x1f write_data: 0x8197f11b memWrite: 0 memMode: 11 clock: 1  

#[27] read_address_0: 0x19 read_data_0: 0x1bb000ab  
#read_address_1: xff read_data_1: 0xffff0f05  
#write_address: x19 write_data: 0x1234abcd memWrite: 1 memMode: 10 clock: 1  

#[29] read_address_0: 0x19 read_data_0: 0xxxxxabcd  
#read_address_1: xff read_data_1: 0xffff0f05  
#write_address: x19 write_data: 0x1234abcd memWrite: 0 memMode: 10 clock: 1  

#[31] read_address_0: 0x19 read_data_0: 0xxxxxabcd  
#read_address_1: xff read_data_1: 0xffff0f05  
#write_address: x1a write_data: 0xf00f0ff0 memWrite: 1 memMode: 10 clock: 1  

#[33] read_address_0: 0x19 read_data_0: 0x0ff0abcd  
#read_address_1: xff read_data_1: 0xffff0f05  
#write_address: x1a write_data: 0xf00f0ff0 memWrite: 0 memMode: 10 clock: 1  

#[35] read_address_0: 0x00 read_data_0: 0x00000001  
#read_address_1: xff read_data_1: 0xffff0f05  
#write_address: x1a write_data: 0xf00f0ff0 memWrite: 0 memMode: 10 clock: 1  

#[37] read_address_0: 0x1c read_data_0: 0x1bb000ab  
#read_address_1: x19 read_data_1: 0x0ff0abcd  
#write_address: x1a write_data: 0xf00f0ff0 memWrite: 0 memMode: 10 clock: 1  

*This memory description has 3 ports to facilitate future tests.