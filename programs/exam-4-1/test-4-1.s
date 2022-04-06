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

  @ Set R1 to the start address of stringA in ROM
  LDR   R1, =stringA

  @ Set R2 to the start address of stringB in ROM
  LDR   R2, =stringB

  @ Set R0 to the address in RAM where stringC should be stored
  LDR   R0, =stringC

  BX    LR


  .section  .rodata

@ String to search in
stringA:
  .asciz  "At least five people reported seeing the UFO near Cork"

@ Hint: try a simpler test string for debugging
@ stringA:
@   .asciz  "go UFO go"

@ String to search for
stringB:
  .asciz  "UFO"



  .section  .data

@ Space in RAM for new, redacted string
stringC:
  .space  256     @ enough space for stringC

.end
