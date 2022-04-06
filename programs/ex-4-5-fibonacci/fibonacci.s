  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Calculate Fibonacci number Fn, where n is stored in R1
  @ Store the result in R0

  @ *** your solution goes here ***

 LDR  R2, =1
 LDR  R0, =0
WhileFib:
  
 CMP  R1, #0
 BEQ  EndWhFib
 ADD  R3, R0, R2
 MOV  R0, R2
 MOV  R2, R3
 SUB  R1, R1, #1
 B    WhileFib
 
EndWhFib:


           @ End of program ... check your result
  @MOV R4, #0        @ fn2 = 0
  @MOV R5, #1        @ fn1 = 1
  @MOV R0, #1        @ fn = 1
  @MOV R6, #2        @ curr = 2
@WhileFib:
  @CMP R6, R1        @ while (curr < n)
  @BHS EndWhFib      @ {
  @MOV R4, R5        @ fn2 = fn1
  @MOV R5, R0        @ fn1 = fn
  @ADD R6, R6, #1    @ curr = curr + 1
  @ADD R0, R5, R4    @ fn = fn1 + fn2
  @B WhileFib        @ }
@EndWhFib:
End_Main:
  BX    lr

.end