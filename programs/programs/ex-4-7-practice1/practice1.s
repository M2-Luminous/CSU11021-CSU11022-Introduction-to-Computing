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

  @ End of program ... check your result

End_Main:
  BX    lr

.end