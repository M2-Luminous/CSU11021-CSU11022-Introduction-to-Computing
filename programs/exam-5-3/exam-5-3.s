  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  
  .global   countIn3x3

@ countIn3x3 subroutine
@ Count the number of occurrences of a specified value in one 3x3 subgrid
@   of a Sudoku grid.
@
@ Parameters:
@   R0: start address of 2D array representing the Sudoku grid
@   R1: row number of any row in the 3x3 subgrid
@   R2: column number of any column in the 3x3 subgrid
@   R3: value to count
@ Return:
@   R0: number of occurrences of value in specified 3x3 subgrid
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
While1:
  MOV   R8, R5                    //R8 is a count to detect whether the program has reached to the end of the row 
  CMP   R10, R6                   //r4 versus r6
  BHI   EndWh1
While2:
  CMP   R8, R7                    //r5 versus r7
  BHI   EndWh2
  MOV   R0, R12
  MOV   R1, R10
  MOV   R2, R8
  BL    get9x9
  CMP   R0, R3
  BEQ   countPlus
  B     continue

countPlus:
  ADD   R9, R9, #1
  B     continue
continue:

  ADD   R8, R8, #1                //column count++
  B     While2
EndWh2:
  ADD   R10, R10, #1              //row count++
  B     While1
EndWh1:

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
.end