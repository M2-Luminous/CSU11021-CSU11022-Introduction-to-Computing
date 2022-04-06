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
While:                        
  LDRB  R2, [R1]        @while((ch = byte[address]) != 0 )                
  CMP   R2, #0          @             
  BEQ   EndWh           @

  STRB  R2, [R0]        @byte[addressB] = 0                
  ADD   R0, R0, #1      @addressB = addressB + 1

  ADD   R1, R1, #1      @addressA = addressA + 1                  
  B     While           @           
EndWh:                  
      
  MOV   R2, #0          @Null         
  STRB  R2, [R0]        @Treminate
              
End_Main:
  BX    lr

