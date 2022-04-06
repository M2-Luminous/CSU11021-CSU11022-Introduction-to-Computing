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
  @ TIP: To view memory when debugging your program you can ...
  @
  @   Add the following watch expression: (unsigned char [64]) stringB
  @
  @   OR
  @
  @   Open a Memory View specifying the address 0x20000000 and length at least 11
  @   You can open a Memory View with ctrl-shift-p type view memory (cmd-shift-p on a Mac)
  @

  @ End of program ... check your result
  MOV   R3, R1

WhSrCh:
  LDRB  R2, [R3]
  CMP   R2, #0
  BEQ   EndWhSrCh
  ADD   R3, R3, #1    //find the end of the string
  ADD   R0, R0, #1    //count = count + 1
  B     WhSrCh
EndWhSrCh:
  MOV   R2, #0
  STRB  R2, [R0]      //Null Terminate

//reverse print out part
WhRev:
  LDRB  R2, [R1]
  CMP   R2, #0
  BEQ   EndWhRev

  SUB   R0, R0, #1    //must do this step if you want to reverse character
  STRB  R2, [R0]
  ADD   R1, R1, #1    //next character
  B     WhRev
EndWhRev:
End_Main:
  BX    lr

