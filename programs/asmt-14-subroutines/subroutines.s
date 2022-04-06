  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  
  .global  get9x9
  .global  set9x9
  .global  average9x9
  .global  blur9x9


@ get9x9 subroutine
@ Retrieve the element at row r, column c of a 9x9 2D array
@   of word-size values stored using row-major ordering.
@
@ Parameters:
@   R0: address - array start address
@   R1: r - row number
@   R2: c - column number
@
@ Return:
@   R0: element at row r, column c
get9x9:
  PUSH    {R4, LR}                      @ add any registers R4...R12 that you use

  @
  @ your implementation goes here
  @
  MOV   R4, #9
  MUL   R1, R1, R4                      
  ADD   R2, R2, R1                      //addressing formula
  LDR   R0, [R0, R2, LSL #2]            //get the element in the correct address

  POP     {R4, PC}                      @ add any registers R4...R12 that you use



@ set9x9 subroutine
@ Set the value of the element at row r, column c of a 9x9
@   2D array of word-size values stored using row-major
@   ordering.
@
@ Parameters:
@   R0: address - array start address
@   R1: r - row number
@   R2: c - column number
@   R3: value - new word-size value for array[r][c]
@
@ Return:
@   none
set9x9:
  PUSH    {R4, LR}                      @ add any registers R4...R12 that you use

  @
  @ your implementation goes here
  @
  MOV   R4, #9
  MUL   R1, R1, R4
  ADD   R2, R2, R1                      //addressing formula
  STR   R3, [R0, R2, LSL #2]            //put the element into correct address

  POP     {R4, PC}                      @ add any registers R4...R12 that you use



@ average9x9 subroutine
@ Calculate the average value of the elements up to a distance of
@   n rows and n columns from the element at row r, column c in
@   a 9x9 2D array of word-size values. The average should include
@   the element at row r, column c.
@
@ Parameters:
@   R0: address - array start address
@   R1: r - row number
@   R2: c - column number
@   R3: n - element radius
@
@ Return:
@   R0: average value of elements
average9x9:
  PUSH    {R4-R12, LR}                      @ add any registers R4...R12 that you use

  @
  @ your implementation goes here
  @
  MOV   R11, #0
  MOV   R12, R0

  SUB   R4, R1, R3  
  CMP   R4, #0
  BGE   FirstStep
  MOV   R4, #0                    //if minimum size is less than 0, then we change it into 0

FirstStep:
  SUB   R5, R2, R3 
  CMP   R5, #0
  BGE   SecondStep
  MOV   R5, #0                    //if minimum size is less than 0, then we change it into 0 

SecondStep:
  ADD   R6, R1, R3
  CMP   R6, #8
  BLE   ThirdStep
  MOV   R6, #8                    //if maximum size is higher than 8, then we change it into 8 

ThirdStep:
  ADD   R7, R2, R3
  CMP   R7, #8
  BLE   FinalStep
  MOV   R7, #8                    //if maximum size is higher than 8, then we change it into 8 

FinalStep:                        //all these steps above is to define the size of the square that we are going to calculate

                                  //we always need to protect the data from R0 to R3 because they can be interupt in any time
  MOV   R10, R4                   //R10 is a count to detect whether the program has reached to the end of the column
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
  ADD   R11, R0                   //total:all the number in the square add together
  ADD   R8, R8, #1                //column count++
  B     While2
EndWh2:
  ADD   R10, R10, #1              //row count++
  B     While1
EndWh1:
  SUB   R8, R7, R5                
  SUB   R9, R6, R4                
  ADD   R8, R8, #1
  ADD   R9, R9, #1
  MUL   R8, R8, R9                 //calculate the square size in order to get the total amount of the elements in the square
  UDIV  R0, R11, R8                //average = total / total amount
  

  POP     {R4-R12, PC}                      @ add any registers R4...R12 that you use


//r start = Max(0, r - 2)
//r end   = Min(8, r + 2)
//c start = Max(0, c - 2)
//c end   = Min(8, c + 2)
@ blur9x9 subroutine
@ Create a new 9x9 2D array in memory where each element of the new
@ array is the average value the elements, up to a distance of n
@ rows and n columns, surrounding the corresponding element in an
@ original array, also stored in memory.
@
@ Parameters:
@   R0: addressA - start address of original array
@   R1: addressB - start address of new array
@   R2: n - radius
@
@ Return:
@   none
blur9x9:
  PUSH    {R4, R5, R10-R12, LR}                      @ add any registers R4...R12 that you use

  @
  @ your implementation goes here
  @
  MOV   R12, R0                     //store the start address of original array
  MOV   R11, R1                     //store the start address of new array
  MOV   R10, R2                     //store the radius                              incase this all three original data get interupted
  MOV   R4, #0
while1:

  CMP   R4, #9                      //row number
  BHS   Endwh1
  MOV   R5, #0
while2:
  CMP   R5, #9                      //column number
  BHS   Endwh2

  MOV   R0, R12
  MOV   R1, R4
  MOV   R2, R5
  MOV   R3, R10
  BL    average9x9                  //put correct parameter into R0,1,2,3 in order to use average9*9 method

  MOV   R3, R0
  MOV   R0, R11
  MOV   R1, R4
  MOV   R2, R5
  BL    set9x9                      //put correct parameter into R0,1,2,3 in order to use set9*9 method
  
  ADD   R5, R5, #1
  B     while2
Endwh2:   
  ADD   R4, R4, #1
  B     while1
Endwh1:


  POP     {R4, R5, R10-R12, PC}                      @ add any registers R4...R12 that you use
//blur 9*9(origAddress, newAddress, radius){
//  for(r = 0; r < 9; r++){
//    for(c = 0; c < 9; c++){
//      avg = average 9*9(origAddress, r, c, radius);
//      set 9*9(newAddress, r, c, avg);
//    }
//  }
//}
//blur 9*9(origAddress, newAddress, radius)
//r = 0;
//while(r < 9){
//  c = 0;
//  while(c < 9){
//  avg = average 9*9(origAddress, r, c, radius);
//  set 9*9(newAddress, r, c, avg);
//  c++;
//  }
//r++;
//}
.end