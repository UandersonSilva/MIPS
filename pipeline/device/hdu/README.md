# Hazard Detection Unit (hdu)

This component detects hazards involving branch instructions and data memory (beq instruction needs a data that has not yet been fetched from data memory) and prevents the PC and IF_ID update by 1 clock cycle.  