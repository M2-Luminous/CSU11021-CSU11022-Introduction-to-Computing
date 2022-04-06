  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ if (ch >= 'A' && ch <= 'Z') {
  @ 	ch = ch + 0x20;
  @ }

  @ *** your solution goes here ***
  CMP R0, #'A'
  BLO EndIfHC
  CMP R0, #'Z'
  BHI EndIfHC
  ADD R0, R0, #0x20
EndIfHC:
  @ End of program ... check your result

End_Main:
  BX    lr

.end