  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  LDR R5 ,=10
  LDR R6 ,=100
  LDR R7 ,=1000
  LDR R8 ,=0x30

  SUB R4, R4, R8 
  MUL R4, R4, R7

  SUB R3, R3, R8
  MUL R3, R3, R6

  SUB R2, R2, R8
  MUL R2, R2, R5

  SUB R1, R1, R8

  ADD R0, R1, R2
  ADD R0, R0, R3
  ADD R0, R0, R4

End_Main:
  BX    lr

.end
