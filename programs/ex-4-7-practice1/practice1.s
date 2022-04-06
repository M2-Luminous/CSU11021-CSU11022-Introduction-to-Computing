  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ if (a < b)
  @ {
  @   r = a;
  @ }
  @ else {
  @   r = b;
  @ }  

  @ *** your solution goes here ***
  CMP R1, R2
  BGE ElseR
  MOV R0, R1
  B   EndR
  ElseR:
  MOV R0, R2
  EndR:
  @ End of program ... check your result

End_Main:
  BX    lr

.end