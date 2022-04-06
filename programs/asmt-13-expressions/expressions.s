  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  @
  @ write your program here
  @

  @
  @ You can use either
  @
  @   The System stack (R13/SP) with PUSH and POP operations
  @
  @   or
  @
  @   A user stack (R12 has been initialised for this purpose)
  @
  MOV R4, #0
  MOV R5, #0
  MOV R6, #0
  MOV R7, #0
  MOV R9, #10
  MOV R10, #10
While:
  
  LDRB R0, [R1]
  CMP R0, #0
  BEQ EndWh                       //check whether the stack pointer reaches the end of the stack

  CMP R0, '+'
  BEQ append
  CMP R0, '-'
  BEQ subtract
  CMP R0, '*'
  BEQ multiply
  CMP R0, ' '
  BEQ skip

  SUB R0, R0, #0x30           //change all the numbers in the stack from ASCII into natural numbers
  PUSH {R0}                   //after changing the numbers, push them back to the stack
  ADD R1, #1                  //next address(byte size)
  MOV R0, #0
  ADD R11, #1                 //count ++

  B While
  skip:

WhileMultiple:
  CMP R11, #2
  BLO EndWhMul
  POP {R2}                        //get the first number
  POP {R3}                        //get the second number
  MUL R3, R3, R10                 //multiply by 10 and add the second number
  ADD R4, R3, R2
  MUL R10, R10, R9                //transform 10 into 100, 1000, 10000...
  SUB R11, #1                     //count--
  PUSH {R4}                       //put the register back in to the stack
  B WhileMultiple
EndWhMul:
  ADD R1, #1                      //next address(byte size)
  MOV R2, #0                      //reset
  MOV R3, #0                      //reset
  MOV R10, #10
  MOV R11, #0
  B While

append:
  POP {R2}  
  POP {R3}
  ADD R5, R2, R3                  //add the two numbers if the program detect '+' sign
  PUSH {R5}
  ADD R1, #1
  MOV R2, #0
  MOV R3, #0
  B While

subtract:
  POP {R2}
  POP {R3}
  SUB R6, R3, R2                //subtract the two numbers if the program detect '-' sign
  PUSH {R6}
  ADD R1, #1
  MOV R2, #0
  MOV R3, #0
  B While

multiply:
  POP {R2}
  POP {R3}
  MUL R7, R2, R3                //multiply the two numbers if the program detect '*' sign
  PUSH {R7}
  ADD R1, #1
  MOV R2, #0
  MOV R3, #0
  B While

EndWh:
  POP {R0}


  @ End of program ... check your result

End_Main:
  BX    lr

