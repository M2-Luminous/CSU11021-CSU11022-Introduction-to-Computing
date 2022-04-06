  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Write an ARM Assembly Language program to evaluate
  @   x^3 - 4x^2 + 3x + 8

  @ *** your solution goes here ***

  @ End of program ... check your result
  MUL R2, R1, R1
  MUL R3, R2, R1
  LDR R6, =4
  LDR R7, =3
  MUL R4, R2, R6
  MUL R5, R1, R7
  SUB R0, R3, R4
  ADD R0, R0, R5
  ADD R0, R0, #8

End_Main:
  BX    lr

.end
