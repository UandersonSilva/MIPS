# Forwarding Unit (fwu)

This component deals with some data hazards that can occur between pipeline stages when the instruction to be executed needs a data (from some register) that is not updated because the previous intruction, that will update it, don't complete write back stage. So, it is necessary to forward the updated data from the write back or memory access or execute stage.