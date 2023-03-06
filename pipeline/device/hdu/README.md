# Hazard Detection Unit (hdu)

This component detects hazards involving branch instructions and data memory (beq instruction needs a data that has not yet been fetched from data memory) and prevents the PC and IF_ID update by 1 clock cycle.  

## Example


## Stalling Condition

condition | result
----------|--------
(opcode == 5'd4) && (id_ex_memRead) (id_ex_rd != 5'd0) && ((rs == id_ex_rd) \|\| (rt == id_ex_rd)) | pc_wr_out <= 1'b0 
\|\| |  if_id_wr_out <= 1'b0 
\|\| |  flush_control_out <= 1'b1
others    | pc_wr_out <= 1'b1
\|\| |  if_id_wr_out <= 1'b1
\|\| |  flush_control_out <= 1'b0

