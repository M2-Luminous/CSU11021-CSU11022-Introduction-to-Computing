  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  
  .global   searchTB
  .global   searchTLBR



@ searchTB subroutine
@
@ Parameters:
@   R0: start address of 2D array
@   R1: start address of string
@ Return:
@   R0: 0 if the string was not found, 1 if it was found
@
@ Write your searchTB subroutine here
@
searchTB:
  //R3, stands for the array address
  //R4, stands for the string address
  //R5, string length that I wrote a subroutine to get
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
While4:

  CMP   R7, R6//we choose R6 different from R8
  BGE   EndWh4
  MOV   R9, #0//initialization

While5:

  CMP   R9, R8//we choose R8 different from R6
  BGT   EndWh5
  MOV   R12, #0

While6:
  
  CMP   R12, R5
  BGE   EndWh6

  ADD   R11, R7, R12
  MUL   R10, R11, R8    
  ADD   R10, R10, R9  //get the correct index of the element(this time different from the horizontal one)

  LDRB  R10, [R3, R10]//load the first compare element
  LDRB  R11, [R4, R12]//load the secodn compare element

  CMP   R10, R11
  BEQ   Equal1
  BNE   NotEqual1

Equal1:
  ADD   R12, R12, #1
  B     While6
EndWh6:

  MOV   R0, #1
NotEqual1:
  CMP   R0, #1
  BEQ   EndProgram1                          
  ADD   R9, R9, #1//jump to the next index
  B     While5
EndWh5: 

  ADD   R7, R7, #1//jump to the next index
  B     While4

EndWh4:

EndProgram1:

  POP  {R4-R12, PC}




@ searchTLBR subroutine
@
@ Parameters:
@   R0: start address of 2D array
@   R1: start address of string
@ Return:
@   R0: 0 if the string was not found, 1 if it was found
searchTLBR:

@
@ Write your searchTLBR subroutine here
@
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
while1:

  CMP   R7, R6//we choose R6 differemt from R8
  BGE   Endwh1
  MOV   R9, #0//initialization

while2:

  CMP   R9, R6//we choose R6 as usual
  BGT   Endwh2
  MOV   R12, #0

while3:
  
  CMP   R12, R5
  BGE   Endwh3

  ADD   R11, R7, R12    //add a single digit to shift the top-bottom direction into top left- bottom right direction
  MUL   R10, R11, R8
  ADD   R10, R10, R9
  ADD   R10, R10, R12   //get the correct index of the element

  LDRB  R10, [R3, R10]//load the first compare element
  LDRB  R11, [R4, R12]//load the secodn compare element

  CMP   R10, R11
  BEQ   equal
  BNE   Notequal

equal:
  ADD   R12, R12, #1
  B     while3
Endwh3:

  MOV   R0, #1
Notequal:
  CMP   R0, #1
  BEQ   endProgram                          
  ADD   R9, R9, #1//jump to the next index
  B     while2
Endwh2: 

  ADD   R7, R7, #1//jump to the next index
  B     while1

Endwh1:

endProgram:

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