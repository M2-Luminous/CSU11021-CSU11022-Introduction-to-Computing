  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:
  
  @
  @ write your program here
  @
  MOV R12, #4
  MOV R11, #1
  MOV R10, #1

  @ get string lenth from each 
  LDR R3, [R1]
  ADD R8, R3, #0
  LDR R4, [R2]
  ADD R7, R4, #1
  @ now get first part of sets 
  ADD R1, R1, #4
  LDR R5, [R1]
  ADD R2, R2, #4
  LDR R6, [R2]
  @move set a to set C
CountR0andstoreR1:
  ADD R0, R0, #4
  While:
  STR R5, [R0]
  ADD R11, R11, #1  @countall
  ADD R0, R0, #4
  ADD R1, R1, #4
  LDR R5, [R1]
  ADD R9, R9, #1    @count set a 
  CMP R9, R3
  BNE While
  B   AddinNonIntersect

AddinNonIntersect:
  @ return to start of R1
  MUL R3, R3, R12
  SUB R1, R1, R3
  LDR R5, [R1]
  MOV R12, #4
  MOV R9, #0


Check:
  CMP R5, R6
  BEQ ChangesetB
  ADD R1, R1, #4
  LDR R5, [R1]
  ADD R9, R9, #1
  CMP R9, R8
  BEQ  AddtosetC
  B   Check

  ChangesetB:
  ADD R10, R10, #1
  CMP R10, R7
  BEQ over
  ADD R2, R2, #4
  LDR R6, [R2]
  MUL R9, R9, R12
  SUB R9, R9, R12
  SUB R1, R1, R9
  SUB R1, R1, #4
  LDR R5, [R1]
  MOV R12, #4
  MOV R9, #0
  B   Check

  AddtosetC:
  ADD R11, R11, #1
  STR R6, [R0]
  ADD R0, R0, #4
  B   ChangesetB

  over:
  MOV R7, #1
  ADD R7, R11, #0
  SUB R7, R7, #1
  MUL R11, R11, R12
  SUB R0, R0, R11
  STR R7, [R0]


  @ End of program ... check your result

End_Main:
  BX    lr

