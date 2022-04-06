  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  
  .global   countInRow

@ countInRow subroutine
@ Count the number of occurrences of a specified value in one row a Sudoku grid.
@
@ Parameters:
@   R0: start address of 2D array representing the Sudoku grid
@   R1: row number
@   R2: value to count
@ Return:
@   R0: number of occurrences of value in specified row
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
  @
  @ write your subroutine here
  @

.end