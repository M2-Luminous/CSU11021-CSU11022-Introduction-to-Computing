  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ if (v < 10) {
  @ 	a = 1;
  @ }
  @ else if (v < 100) {
  @ 	a = 10;
  @ }
  @ else if (v < 1000) {
  @ 	a = 100;
  @ }
  @ else {
  @ 	a = 0;
  @ }  

  @ *** your solution goes here ***
  CMP R1, #10
  BHS ElseCompare1
  MOV R0, #1
  B   EndCompare
ElseCompare1:
  CMP R1, #100
  BHS ElseCompare2
  MOV R0, 10
  B   EndCompare
ElseCompare2:
  CMP R1, #1000
  BHS ElseCompare3
  MOV R0, #100
  B   EndCompare
ElseCompare3:
  MOV R0, #0
EndCompare:
  @ End of program ... check your result

End_Main:
  BX    lr

.end