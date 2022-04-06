  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global Init_Test


  .section  .text


  .type     Init_Test, %function
Init_Test:

  LDR   R1, =0x28A8C2BE   @ test value
  LDR   R2, =0xA          @ search for pattern 1010
  LDR   R3, =4            @ search for a 4-bit pattern
  
  BX    LR

.end
