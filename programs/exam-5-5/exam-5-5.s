  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  
  .global   solveSudoku

@ solveSudoku subroutine
@ Solve a Sudoku puzzle.
@
@ Parameters:
@   R0: start address of 2D array representing the Sudoku grid
@   R1: row number of next cell to modify
@   R2: column number if next cell to modify
@ Return:
@   R0: 1 if a solution was found, zero otherwise

//     int solveSudoku ( grid , row , column ) {
//     if ( row >= 9) {
//     // Success !! We have filled every preceding cell with a valid number
//     result = 1;
//     }
//     else {
//     result = 0;
//     // calculate the row , column number of the next cell
//     next_column = column + 1;
//     next_row = row ;
//     if ( next_column >= 9) {
//     next_column = 0;
//     next_row = next_row + 1;
//     }
//     // get the value of the current cell
//     current = grid [ row , column ];
//     if ( current != 0) {
//     // this was a non - empty cell in the puzzle so we cannot change it
//     // skip it and move on to the next cell
//     result = solveSudoku ( grid , next_row , next_column );
//     }
//     else {
//     // this was an empty cell in the puzzle
//     // try successive values to recursively solve the puzzle
//     next = nextValid ( grid , row , column );
//     while ( next != 0 && result != 1) {
//     grid [ row , column ] = next ;
//     result = solveSudoku ( grid , next_row , next_column );
//     next = nextValid ( grid , row , column );
//     }
//     // tried every possibility - reset cell to empty
//     if ( result == 0) {
//     grid [ row , column ] = 0;
//     }
//     }
//     }
//     return result ;
//     }
solveSudoku:
PUSH  {R3-R12, LR}
  CMP   R1, #9
  BNE   EndIf
  MOV   R0, #1//if(row >= 9), then the result will be 1
EndIf:
  MOV   R0, #0
  ADD   R3, R2, #1 //next column = column + 1
  MOV   R4, R1     //next row = row
  
  CMP   R3, #9     //if ( next_column >= 9) {
  BLT   EndIf1
  MOV   R3, #0     //next_column = 0;
  ADD   R4, R4, #1 //next_row = next_row + 1;
EndIf1:

  MOV   R12, #9
  MUL   R5, R1, R12
  ADD   R5, R5, R2
  LDRB  R6, [R0, R5]
  CMP   R6, #0
  BEQ   emptyCell
  BNE   nonEmptyCell

  MOV   R11, R0
nonEmptyCell:
  MOV   R0, R11
  MOV   R1, R4
  MOV   R2, R3
  BL    solveSudoku//result = solveSudoku ( grid , next_row , next_column );
  B     EndPro
emptyCell:
  MOV   R0, R11
  BL    nextValid
  MOV   R7, R0//next = nextValid ( grid , row , column );
  MOV   R0, R11

while:
  CMP  R0, #1
  BEQ  Endwh
  CMP  R7, #0
  BEQ  Endwh

  MOV  R0, R11
  BL   nextValid
  MOV  R5, R0
  
  MOV  R0, R11
  MOV  R1, R4
  MOV  R2, R3
  BL   solveSudoku
  MOV  R8, R0
  MOV  R0, R11
  BL   nextValid
  MOV  R7, R0
  MOV  R0, R8

  CMP  R0, #0
  BNE  EndIf2
  MOV  R5, #0
EndIf2:

  B    while
Endwh:

MOV   R0, R8

EndPro:








POP  {R3-R12, PC}



  @
  @ write your subroutine here
  @



@
@ Copy your countInRow, countInCol, countIn3x3 and nextValid subroutines here
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

countIn3x3:
  PUSH    {R4-R12, LR}                      @ add any registers R4...R12 that you use

  @
  @ your implementation goes here
  @
  MOV   R11, #0
  MOV   R12, R0

  SUB   R4, R1, #1  
  CMP   R4, #0
  BGE   FirstStep
  MOV   R4, #0                    //if minimum size is less than 0, then we change it into 0

FirstStep:
  SUB   R5, R2, #1 
  CMP   R5, #0
  BGE   SecondStep
  MOV   R5, #0                    //if minimum size is less than 0, then we change it into 0 

SecondStep:
  ADD   R6, R1, #1
  CMP   R6, #8
  BLE   ThirdStep
  MOV   R6, #8                    //if maximum size is higher than 8, then we change it into 8 

ThirdStep:
  ADD   R7, R2, #1
  CMP   R7, #8
  BLE   FinalStep
  MOV   R7, #8                    //if maximum size is higher than 8, then we change it into 8 

FinalStep:                        //all these steps above is to define the size of the square that we are going to calculate

                                  //we always need to protect the data from R0 to R3 because they can be interupt in any time
  MOV   R10, R4                   //R10 is a count to detect whether the program has reached to the end of the column
  MOV   R9, #0
While3:
  MOV   R8, R5                    //R8 is a count to detect whether the program has reached to the end of the row 
  CMP   R10, R6                   //r4 versus r6
  BHI   EndWh3
While2:
  CMP   R8, R7                    //r5 versus r7
  BHI   EndWh2
  MOV   R0, R12
  MOV   R1, R10
  MOV   R2, R8
  BL    get9x9
  CMP   R0, R3
  BEQ   countPlus2
  B     continue

countPlus2:
  ADD   R9, R9, #1
  B     continue
continue:

  ADD   R8, R8, #1                //column count++
  B     While2
EndWh2:
  ADD   R10, R10, #1              //row count++
  B     While3
EndWh3:

  MOV   R0, R9


  POP     {R4-R12, PC}                      @ add any registers R4...R12 that you use
  @
  @ write your subroutine here
  @

get9x9:
  PUSH    {R4, LR}                      @ add any registers R4...R12 that you use

  @
  @ your implementation goes here
  @
  MOV   R4, #9
  MUL   R1, R1, R4                      
  ADD   R2, R2, R1                      //addressing formula
  LDRB  R0, [R0, R2]                    //get the element in the correct address

  POP     {R4, PC}                      @ add any registers R4...R12 that you use

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
.end