  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @
  @ Write a program to implement all of the following operations:
  @
  @   1. Clear (i.e. change to zero) the middle two bytes of the
  @      value in R1.
  @
  @   2. Set (i.e. change to one) the four most significant bits
  @      of the value in R2.
  @
  @   3. Invert every second bit of the value in R3, starting
  @      with the least significant bit.
  @
  LDR   R1, =0xC0000000
  LDR   R2, =0x40000000
  ADDS  R0, R1, R2
  @ *** your solution goes here ***

  @ End of program ... check your result

End_Main:
  BX    lr

.end