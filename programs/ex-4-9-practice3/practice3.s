  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ while (h >= 13) {
  @ 	h = h - 12;
  @ }

  @ *** your solution goes here ***

  @ End of program ... check your result
  
WhileSub:
  CMP R0, #13
  BLO EndWhSub
  SUB R0, R0, 12
  B   WhileSub
EndWhSub:

End_Main:
  BX    lr

.end