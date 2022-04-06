  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  
  .global   fp_add

@ fp_add subroutine
@ Add two IEEE-754 floating point numbers
@
@ Paramaters:
@   R0: a - first number
@   R1: b - second number
@
@ Return:
@   R0: result - a+b
@
fp_add:
  PUSH    {R4-R11, LR}                      @ add any registers R4...R12 that you use
  MOV   R4, R0              //save the first number
  MOV   R5, R1              //save the second number

  MOV   R0, R4
  BL    fp_exp
  MOV   R6, R0              //get the first number's exponent

  MOV   R0, R4
  BL    fp_frac
  MOV   R7, R0              //get the first number's fraction

  MOV   R0, R5
  BL    fp_exp
  MOV   R8, R0              //get the second number's exponent

  MOV   R0, R5
  BL    fp_frac
  MOV   R9, R0              //get the second number's fraction

  CMP   R6, R8
  BEQ   endChange           //don't need to change when the exponents are the same
  BGT   firstExponent       //change R8 in order to fit in R6
  BLT   secondExponent      //change R6 in order to fit in R8

firstExponent:
  SUB   R10, R6, R8
  CMP   R9, #0
  BGT   positive1           //check whether the number is negative or not
  NEG   R9, R9              //transform the number into positive in order to shift correct number
  MOV   R9, R9, LSR R10     //logical shift the less exponent in order to equal two numbers
  NEG   R9, R9              //chabge the number back into negative
  B     endChange

positive1:
  MOV   R9, R9, LSR R10
  B     endChange

secondExponent:
  SUB   R10, R8, R6
  MOV   R6, R8
  CMP   R7, #0
  BGT   positive2           //check whether the number is negative or not
  NEG   R7, R7              //transform the number into positive in order to shift correct number
  MOV   R7, R7, LSR R10     //logical shift the less exponent in order to equal two numbers
  NEG   R7, R7              //change the number back into negative
  B     endChange

positive2:
  MOV   R7, R7, LSR R10     
  B     endChange

endChange:

  ADD   R11, R7, R9
  MOV   R0, R11             //add the fraction and put it into R0
  MOV   R1, R6              //put the exponent into R1
  BL    fp_enc




  @
  @ your implementation goes here
  @

  POP     {R4-R11, PC}                      @ add any registers R4...R12 that you use


@
@ Copy your fp_frac, fp_exp, fp_enc subroutines from Assignment #6 here

fp_exp:
  PUSH    {R4, LR}                      @ add any registers R4...R12 that you use

  @
  @ your implementation goes here
  @
  AND   R4, R0, #0x7F800000         //introduce the number 01111111100000000000000000000000 in order to make sure we can get the correct data in correct index
  MOV   R4, R4, LSR #23             //shift to the exponent part directly
  SUB   R4, R4, #127                //using 2's complement
  MOV   R0, R4

  POP     {R4, PC}                      @ add any registers R4...R12 that you use

fp_frac:
  PUSH    {R4-R7, LR}                      @ add any registers R4...R12 that you use
  MOV   R4, R0
  MOV   R5, R0
  LDR   R12, =0x007FFFFF
  
  AND   R6, R4, R12                 //introduce the number 00000000111111111111111111111111 in order to make sure we can get the correct data in correct index
  ADD   R6, R6, #0x00800000         //BIC R6, R6, #0xFF800000

  AND   R5, R5, #0x80000000         //get the sign value using the binary number 10000000000000000000000000000000
  CMP   R5, #0
  BEQ   Positive
  BNE   Negative

Positive:
  MOV   R0, R6
  B     End

Negative:
  RSB   R6, R6, #0
  MOV   R0, R6
  B     End  

End:
  @
  @ your implementation goes here
  @

  POP     {R4-R7,PC}                      @ add any registers R4...R12 that you use

fp_enc:
  PUSH    {R4-R12, LR}                      @ add any registers R4...R12 that you use

  @
  @ your implementation goes here
  @
  MOV   R4, R0                 //get the exponent
  MOV   R5, R1                 //get the fraction
  MOV   R6, #0
  LDR   R7, =-1                //count
  MOV   R8, #0x80000000        //1000 0000 0000 0000 0000 0000 0000 0000
  MOV   R11, #2
  AND   R8, R8, R4             //get the sign value in order to check whether the number is positive or negative

  CMP   R8, #0
  BEQ   While
  BNE   Neg

Neg:
  RSB   R4, R4, #0              //change the data from negative to positive
  MOV   R0, R4
  MOV   R6, #1                  //change the sign
  B     While

While:
  CMP   R4, #0
  BEQ   EndWh                   //check each position of the data is zero or one
  MOV   R9, R4, LSR #1          //MUL  R9, R4, R11
  MOV   R10, R9, LSL #1         //UDIV  R10, R9, R11
  SUB   R10, R4, R10
  MOV   R4, R9
  ADD   R7, R7, #1
  B     While
EndWh:

  MOV   R4, R0
  MOV   R0, #0                 //CLZ    R12, R4
  LDR   R12, =-1               //CMP    R12, #8
  CMP   R7, R12                //BEQ    notChanged
  BEQ   notChanged             //BLT    logicalShiftRight
  BNE   Changed                //BGT    logicalShiftRight

Changed:                       //logicalShiftRight:
  SUB   R7, R7, #23            // RSB   R11, R12, #8                               
  CMP   R7, #0                 // MOV   R7, R7, LSL R11             //generate the exponent part                            
  BLT   logicalShiftLeft       // ADD   R7, R7, R11                                   
  BGE   logicalShiftRight                                           
                               //logicalShiftLeft:            
notChanged:                    // SUB   R11, R12, #8                       
  MOV   R5, R5, LSL #23        // MOV   R7, R7, LSL R11                                   
  MOV   R0, R5                 // ADD   R7, R7, R11                          
  B     EndIf                                           
                               //notChanged:             
logicalShiftRight:             //SUB    R0, R0, #0x00800000                            
  MOV   R9, #0                 //ADD    R7, R7, #127             
  While1:                      //MOV    R7, R7, LSL #23       
    CMP   R9, R7               //ADD    R0, R0, R7
    BGE   terminateShift       //MOV    R6, R6, LSL #31   
    MOV   R4, R4, LSR #1       //ADD    R0, R0, R6
    ADD   R9, R9, #1
    B     While1

logicalShiftLeft:
  MOV   R9, R7
  While2:
    CMP   R9, #0                   //from R9 to 0 shift exact the same number of the bits that the 0-R9 has
    BGE   terminateShift
    MOV   R4, R4, LSL #1
    ADD   R9, R9, #1
    B     While2

terminateShift:
  LDR   R10, =0x007FFFFF
  AND   R4, R4, R10                 //get the fraction part
  ADD   R0, R0, R4
  ADD   R7, R7, R5
  ADD   R7, R7, #127                //convert from 2's complement into binary 
  MOV   R7, R7, LSL #23             //generate the exponent part
  ADD   R0, R0, R7
  
EndIf:
  MOV   R6, R6, LSL #31
  ADD   R0, R0, R6                   //get the sign value part



  POP     {R4-R12, PC}                      @ add any registers R4...R12 that you use

@   and call them from fp_add above.
@


.end