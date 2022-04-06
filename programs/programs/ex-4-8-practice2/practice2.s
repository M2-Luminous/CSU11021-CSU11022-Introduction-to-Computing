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

  @ End of program ... check your result

End_Main:
  BX    lr

.end