  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Write an ARM Assembly Language program to evaluate
  @   ax^2 + bx + c for given values of a, b, c and x

  @ *** your solution goes here ***

  @ End of program ... check your result
  MUL R5, R1, R1
  MUL R6, R5, R2
  MUL R7, R1, R3
  ADD R0, R6, R7
  ADD R0, R0, R4

End_Main:
  BX    lr

.end
