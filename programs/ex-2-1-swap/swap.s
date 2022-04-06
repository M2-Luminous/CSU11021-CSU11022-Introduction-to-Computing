  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:
  ADD R0, R0, R1
  SUB R1, R0, R1
  SUB R0, R0, R1
   
End_Main:
  BX    lr

.end
