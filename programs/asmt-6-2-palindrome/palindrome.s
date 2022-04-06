  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  @
  @ write your program here
  @
  LDR   R2, =0x20000000           //creat a new memory that we can alter  order string
  LDR   R3, =0x20001000           //creat a new memory that we can alter  reverse order string
  MOV   R4, R1                    //read the memory in R1
  MOV   R6, R2                    //index (or address)
  

While1:
  LDRB  R5, [R4]
  CMP   R5, #0x00
  BEQ   EndWh1
  CMP   R5, 'A'
  BLO   EndIfUp
  CMP   R5, 'Z'
  BHI   EndIfUp
  STRB  R5, [R6]
  ADD   R6, R6, #1
  B     EndC                      //if the character is in upper case, then don't do anything on it
EndIfUp:
  CMP   R5, 'a'
  BLO   EndIfLow
  CMP   R5, 'z'
  BHI   EndIfLow
  SUB   R5, R5, #0x20
  STRB  R5, [R6]
  ADD   R6, R6, #1
  B     EndC                      //if the character is in lower case, then change it into upper case
EndIfLow:
EndC:
  ADD   R4, R4, #1                //read the next character
  B     While1
EndWh1:
  SUB   R4, R4, #1                //after ending the loop, the index of R1 memory will in the very last
                                  //empty memory, we need to subtract it in order to let it go 
                                  //back to the last character                  
  MOV   R6, R3                    //now go to the reverse order string's memory
While2:
  LDRB  R5, [R4]
  CMP   R5, #0x00
  BEQ   EndWh2
  CMP   R5, 'A'
  BLO   EndIfUpper
  CMP   R5, 'Z'
  BHI   EndIfUpper
  STRB  R5, [R6]
  ADD   R6, R6, #1
  B     EndCount                  //if the character is in upper case, then don't do anything on it
EndIfUpper:
  CMP   R5, 'a'
  BLO   EndIfLower
  CMP   R5, 'z'
  BHI   EndIfLower
  SUB   R5, R5, #0x20
  STRB  R5, [R6]
  ADD   R6, R6, #1
  B     EndCount                  //if the character is in lower case, then change it into upper case
EndIfLower:
EndCount:
  SUB   R4, R4, #1                //read the next charecter in a reverse order
  B     While2
EndWh2:

Compare:
  LDRB  R11, [R2]
  LDRB  R12, [R3]
  CMP   R11, #0x00                //if both R2 and R3 goes to the final empty digit and still
  BEQ   EndCompare                //can not find the not equal part, we can move 1 into result(R0)
  CMP   R12, #0x00
  BEQ   EndCompare
  CMP   R11, R12                  //start the compare
  BNE   NotEqual
  ADD   R2, R2, #1                //goes into next index(address)
  ADD   R3, R3, #1                //goes into next index(address)
  B     Compare
EndCompare:
  LDR   R0, =1                    //move 1 into result when finding the order string and reverse 
  B     EndProgram                //order string is completely the same
NotEqual:
  LDR   R0, =0                    //move 0 into result when finding the order string and reverse
  B     EndProgram                //order string have their differences
EndProgram:

  @ End of program ... check your result

End_Main:
  BX    lr

