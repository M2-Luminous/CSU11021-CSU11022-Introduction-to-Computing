  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Compute absolute value of value in R1

  @ *** your solution goes here ***
  MOV R0, R1     @result = value
  CMP R0, #0     @if (result < 0)
  BGE EndIfNeg   @{  End If Negative; Branch if Greater than or Equal
  RSB R0, R0, #0 @result = 0 - result Reverse SuBtract
EndIfNeg:        @}

  @ End of program ... check your result
  
End_Main:
  BX    lr

.end