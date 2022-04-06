  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  
  .global   nextValid

@ nextValid subroutine
@ Find the next higher valid value that can be placed in a specified cell in a
@   Sudoku grid.
@
@ Parameters:
@   R0: start address of 2D array representing the Sudoku grid
@   R1: row number of cell
@   R2: column number of cell
@ Return:
@   R0: next higher value or 0 if there is no valid higher value
nextValid:
  PUSH  {R3-R12, LR}
  MOV   R12, #9        //set the maximum next number to 9 and the result will be set to 0 if there is no more other result
  MUL   R3, R1, R12
  ADD   R3, R3, R2
  LDRB  R4, [R0, R3]
  MOV   R11, R4
  MOV   R10, R0        //protect the starting address from R0
  MOV   R8, R1
  MOV   R9, R2
WhileValid:
  CMP   R11, R12
  BGE   EndWhValid
  ADD   R11, R11, #1
  MOV   R0, R10
  MOV   R1, R8
  MOV   R2, R11
  BL    countInRow
  CMP   R0, #0
  BEQ   checkColumn
  BNE   WhileValid

checkColumn:
  MOV   R0, R10
  MOV   R1, R9
  MOV   R2, R11
  BL    countInCol
  CMP   R0, #0
  BEQ   terminateLoop
  BNE   WhileValid
EndWhValid:
  MOV   R0, #0
  B     EndProgram
terminateLoop:
  MOV   R0, R11
  B     EndProgram

EndProgram:

  POP  {R3-R12, PC}
  @
  @ write your subroutine here
  @



@
@ Copy your countInRow, countInCol and countIn3x3 subroutines here
@
countInRow:
PUSH  {R3-R12, LR}
  MOV R12, #9  //set the maximum row number and column number into 9
  MUL R3, R1, R12   //get to the correct index of the 2 dimension array
  MOV R11, #0//limit count
  MOV R10, #0//occurence count
While:
  CMP R11, R12
  BEQ EndWh
  LDRB R4, [R0, R3]//load the number
  CMP R4, R2              //compare the loaded value with the value to count
  BEQ countPlus
  BNE countSkip

countPlus:
  ADD R10, R10, #1
  ADD R3, R3, #1
  B   backToLoop

countSkip:
  ADD R3, R3, #1
  B   backToLoop

backToLoop:

  ADD R11, R11, #1

  B   While
EndWh:

  MOV R0, R10
  POP  {R3-R12, PC}



countInCol:
PUSH  {R3-R12, LR}
  MOV R12, #9  //set the maximum row number and column number into 9
  MOV R11, #0//limit count
  MOV R10, #0//occurence count
While1:
  CMP R11, R12
  BEQ EndWh1
  LDRB R4, [R0, R1]       //load the number
  CMP R4, R2              //compare the loaded value with the value to count
  BEQ countPlus1
  BNE countSkip1

countPlus1:
  ADD R10, R10, #1
  ADD R1, R1, #9
  B   backToLoop1

countSkip1:
  ADD R1, R1, #9
  B   backToLoop1

backToLoop1:

  ADD R11, R11, #1

  B   While1
EndWh1:

  MOV R0, R10
  POP  {R3-R12, PC}


.end