# Register File

The register file has 32 registers addressed by 5-bit buses (2 buses for reading and 1 for writing). The value of register 0 must always be 0. Therefore, this register cannot be written.

## Runtime output

#[3] read_register_0: x1 read_data_0: 0xxxxx  
#read_register_1: x30 read_data_1: 0xxxxx  
#write_register: x1 write_data: 0x0001 regWrite: 1 clock: 1  

#[5] read_register_0: x1 read_data_0: 0x0001  
#read_register_1: x30 read_data_1: 0xxxxx  
#write_register: x1 write_data: 0x0001 regWrite: 0 clock: 1  

#[7] read_register_0: x1 read_data_0: 0x0001  
#read_register_1: x30 read_data_1: 0xxxxx  
#write_register: x30 write_data: 0x0005 regWrite: 1 clock: 1  

#[9] read_register_0: x1 read_data_0: 0x0001  
#read_register_1: x30 read_data_1: 0x0005  
#write_register: x30 write_data: 0x0005 regWrite: 0 clock: 1  

#[11] read_register_0: x15 read_data_0: 0xxxxx  
#read_register_1: x30 read_data_1: 0x0005  
#write_register: x15 write_data: 0xffff regWrite: 1 clock: 1  

#[13] read_register_0: x15 read_data_0: 0xffff  
#read_register_1: x30 read_data_1: 0x0005  
#write_register: x15 write_data: 0xffff regWrite: 0 clock: 1  

#[15] read_register_0: x15 read_data_0: 0xffff  
#read_register_1: x16 read_data_1: 0xxxxx  
#write_register: x16 write_data: 0xfffb regWrite: 1 clock: 1  

#[17] read_register_0: x15 read_data_0: 0xffff  
#read_register_1: x16 read_data_1: 0xfffb  
#write_register: x16 write_data: 0xfffb regWrite: 0 clock: 1  

#[19] read_register_0: x0 read_data_0: 0x0000  
#read_register_1: x16 read_data_1: 0xfffb  
#write_register: x0 write_data: 0x0ff0 regWrite: 1 clock: 1  

#[21] read_register_0: x0 read_data_0: 0x0000  
#read_register_1: x16 read_data_1: 0xfffb  
#write_register: x0 write_data: 0x0ff0 regWrite: 0 clock: 1  

#[23] read_register_0: x31 read_data_0: 0xxxxx  
#read_register_1: x16 read_data_1: 0xfffb  
#write_register: x31 write_data: 0xf00f regWrite: 1 clock: 1  

#[25] read_register_0: x31 read_data_0: 0xf00f  
#read_register_1: x16 read_data_1: 0xfffb  
#write_register: x31 write_data: 0xf00f regWrite: 0 clock: 1  

#[27] read_register_0: x30 read_data_0: 0x0005  
#read_register_1: x1 read_data_1: 0x0001  
#write_register: x31 write_data: 0xf00f regWrite: 0 clock: 1  

#[29] read_register_0: x15 read_data_0: 0xffff  
#read_register_1: x16 read_data_1: 0xfffb  
#write_register: x31 write_data: 0xf00f regWrite: 0 clock: 1  

#[31] read_register_0: x0 read_data_0: 0x0000  
#read_register_1: x31 read_data_1: 0xf00f  
#write_register: x31 write_data: 0xf00f regWrite: 0 clock: 1  
#** Note: $stop    : ../device/register_file/test/rf_test.sv(107)  
#Time: 31 ns  Iteration: 1  Instance: /rf_test  
#Break at ../device/register_file/test/rf_test.sv line 107  