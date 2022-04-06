  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global Init_Test

  .global tickets
  .global draw


  .section  .text


  .type     Init_Test, %function
Init_Test:

  LDR     R1, =tickets          @ address of tickets
  LDR     R2, =draw             @ address of draw
  BX      LR



  .section  .rodata             @ store original sets in Read Only Memory (ROM)

  .align 8                      @ you can ignore this - it just forces tickets to
                                @   start at some address 0x??????00
tickets:
  .word  4                      @ number of tickets
  .byte   3, 17,  2, 20, 22     @ first ticket
  .byte  30,  8,  2, 19,  7     @ second ticket
  .byte  14, 15, 10, 11, 12     @ third ticket
  .byte   9, 10,  4, 11, 17     @ fourth ticket  

  .align 8                      @ you can ignore this - it just forces tickets to
                                @   start at some address 0x??????00
draw:
  .byte   2, 17,  9, 22, 20     @ draw

.end