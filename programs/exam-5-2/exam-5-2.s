  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  
  .global   countInCol

@ countInCol subroutine
@ Count the number of occurrences of a specified value in one column of a Sudoku grid.
@
@ Parameters:
@   R0: start address of 2D array representing the Sudoku grid
@   R1: column number
@   R2: value to count
@ Return:
@   R0: number of occurrences of value in specified column
countInCol:
PUSH  {R3-R12, LR}
countInRow:
  MOV R12, #9  //set the maximum row number and column number into 9
  MOV R11, #0//limit count
  MOV R10, #0//occurence count
While:
  CMP R11, R12
  BEQ EndWh
  LDRB R4, [R0, R1]       //load the number
  CMP R4, R2              //compare the loaded value with the value to count
  BEQ countPlus
  BNE countSkip

countPlus:
  ADD R10, R10, #1
  ADD R1, R1, #9
  B   backToLoop

countSkip:
  ADD R1, R1, #9
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