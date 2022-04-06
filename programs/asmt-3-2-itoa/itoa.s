  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Write an ARM Assembly Language Program that will convert
  @   a signed value (integer) in R3 into three ASCII characters that
  @   represent the integer as a decimal value in ASCII form, prefixed
  @   by the sign (+/-).
  @ The first character in R0 should represent the sign
  @ The second character in R1 should represent the most significaint digit
  @ The third character in R2 should represent the least significant digit
  @ Store 'N', '/', 'A' if the integer is outside the range -99 ... 0 ... +99

  
  @ *** your solution goes here ***
  CMP R3, #99
  BGT EndIf
  CMP R3, #-99
  BLT EndIf                 @ judge whether the input is in the range or not

  CMP R3, #0
  BEQ EndIfZero
  BGT EndIfPos
  BLT EndIfNeg              @ divide into three options when input 3 different types

EndIf:
  MOV R0, #0x4E
  MOV R1, #0x2F
  MOV R2, #0x41
  B   End                   @ judge whether the input is in the range or not

EndIfZero:
  MOV R0, #0x20
  MOV R1, #0x30
  MOV R2, #0x30
  B   End                   @ system print out the answer when input is zero

EndIfPos:
  MOV R0, #0x2B
  MOV R9, #10
  UDIV  R8, R3, R9
  ADD R1, R8, #0x30
  MUL R8, R8, R9
  SUB R7, R3, R8
  ADD R2, R7, #0x30
  B   End                   @ system print out the answer when input is positive

EndIfNeg:
  RSB R3, R3, #0            @ change the negative number into positive one to calculate much more easier
  MOV R0, #0x2D
  MOV R9, #10
  UDIV  R6, R3, R9
  ADD R1, R6, #0x30
  MUL R6, R6, R9
  SUB R5, R3, R6
  ADD R2, R5, #0x30
  B   End                   @ system print out the answer when input is negative

End:




 
  @ End of program ... check your result

End_Main:
  BX    lr

.end
