  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global Init_Test

  .global origStr
  .global newStr


  .section  .text


  .type     Init_Test, %function
Init_Test:

  LDR     R0, =newStr       @ start address of new string in RAM
  LDR     R1, =origStr      @ start address of original string in ROM
  BX      LR


  .section  .rodata

origStr:
  .asciz  "The CSU11021 exam has begun. It lasts 24 hours."



  .section  .data
newStr:
  .space  256     @ enough space for the TELEGRAM string

.end
