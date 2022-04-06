  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  
  .global   searchLR

@ searchLR subroutine
@
@ Parameters:
@   R0: start address of 2D array
@   R1: start address of string
@ Return:
@   R0: 0 if the string was not found, 1 if it was found
searchLR:
//14 * 14 = 196 maximum element number
//196 - 1 = 195 maximum index
//detecting words -- use LDRB

  PUSH  {R4-R12, LR}

  //R3, stands for the array address
  //R4, stands for the string address
  //R5, string length that I wrote a subroutine to get

  
  MOV   R3, R0
  MOV   R4, R1
  MOV   R0, R4
  BL    count
  MOV   R5, R0//put the length into R5

  MOV   R0, #0
  MOV   R8, #12
  SUB   R6, R8, R5//get the safe zone for the horizontal string
   
  MOV   R7, #0//initialization
While1:

  CMP   R7, R8
  BGE   EndWh1
  MOV   R9, #0//initialization

While2:

  CMP   R9, R6
  BGT   EndWh2
  MOV   R12, #0

While3:
  
  CMP   R12, R5
  BGE   EndWh3

  MUL   R10, R7, R8    //get the correct index of the element
  ADD   R10, R10, R9
  ADD   R10, R10, R12

  LDRB  R10, [R3, R10]//load the first compare element
  LDRB  R11, [R4, R12]//load the secodn compare element

  CMP   R10, R11
  BEQ   Equal
  BNE   NotEqual

Equal:
  ADD   R12, R12, #1
  B     While3
EndWh3:

  MOV   R0, #1
NotEqual:
  CMP   R0, #1
  BEQ   EndProgram                          
  ADD   R9, R9, #1//jump to the next index
  B     While2
EndWh2: 

  ADD   R7, R7, #1//jump to the next index
  B     While1

EndWh1:

EndProgram:

  POP  {R4-R12, PC}










//count subroutine
count:
  PUSH  {R4, R5, LR}

  MOV   R5, #0
While0:
  LDRB  R4, [R1]
  CMP   R4, #0
  BEQ   EndWh0

  ADD   R5, R5, #1
  ADD   R1, R1, #1

  B     While0
EndWh0:
  MOV   R0, R5

  POP   {R4, R5, PC}

.end