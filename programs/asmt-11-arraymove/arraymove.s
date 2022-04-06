  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  @
  @ write your program here
  @
  MOV R3, #0
  MOV R4, #0                      //initialize all the parameters

  LDR R3, [R0, R1, LSL #2]        
  LDR R4, [R0, R2, LSL #2]        //load the numbers that we are going to swap

  STR R3, [R0, R2, LSL #2]        //put the swap number  into its correct address
  
  CMP R1, R2
  BHI allOtherNumbersShiftToRight
  BLO allOtherNumbersShiftToLeft      //the action to place all the other numbers into correct address

allOtherNumbersShiftToRight:
  CMP R1, R2
  BEQ Endshift                         //ends when the program detect all the numbers have been moved into the right address
  ADD R2, R2, #1                       //move to the right place we need to add 4
  LDR R3, [R0, R2, LSL #2]
  STR R4, [R0, R2, LSL #2]
  MOV R4, R3                           //refresh the numbers in the R4 parameter
  B   allOtherNumbersShiftToRight
  

allOtherNumbersShiftToLeft:
  CMP R1, R2
  BEQ Endshift                         //ends when the program detect all the numbers have been moved into the right address
  SUB R2, R2, #1                       //move to the left place we need to subtract 4
  LDR R3, [R0, R2, LSL #2]
  STR R4, [R0, R2, LSL #2]
  MOV R4, R3                            //refresh the numbers in the R4 parameter
  B   allOtherNumbersShiftToLeft


Endshift:                              //terminate the program
  @ End of program ... check your result

End_Main:
  BX    lr

