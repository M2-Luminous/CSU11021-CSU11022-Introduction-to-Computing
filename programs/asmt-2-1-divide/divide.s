  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Write an ARM Assembly Language Program that will divide a
  @   value, a, in R2 by another value, b, in R3.
  
  @ *** your solution goes here ***
  MOV   R0, #0
  CMP   R3, #0
  BEQ   ERROR
WhileDivide:
  CMP   R2, R3
  BLT   EndWhDivide
  SUB   R1, R2, R3
  MOV   R2, R1
  ADD   R0, R0, #1
  B     WhileDivide
EndWhDivide:
  MOV   R1, R2
ERROR:




  @ End of program ... check your result

End_Main:
  BX    lr

.end
