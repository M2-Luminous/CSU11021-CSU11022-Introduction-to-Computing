  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:
  MOV   R0, #0                 @length = 0 
  LDRB  R2, [R1]               @ch = byte[address]   
While:                         @while( ch != NULL)
  CMP   R2, #0                 @{ 
  BEQ   EndWh                  
  ADD   R0, R0, #1             @length = length + 1      
  ADD   R1, R1, #1             @address = address + 1      
  LDRB  R2, [R1]                   
  B     While                  @} 
EndWh:


  @ End of program ... check your result

End_Main:
  BX    lr

