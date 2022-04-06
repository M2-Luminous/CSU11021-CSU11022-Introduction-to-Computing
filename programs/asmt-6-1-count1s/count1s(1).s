  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  
  LDR   R2, =0                    @ count = 0
  LDR   R3, =0                    @ result = 0
While: 
  CMP   R1, #0                    @ while (R1 != 0）
  BEQ   EndWh                     @ {
  LDR   R5, =2
  UDIV  R4, R1, R5                @   quotient = R1 // 2
  MUL   R5, R4, R5                @   temp = quotient * 2
  SUB   R6, R1, R5                @   bit = R1 - temp
  CMP   R6, #1                    @   if (bit == 1)
  BNE   Else0                     @   {
  ADD   R2, R2, #1                @     count += 1
  CMP   R2, R3                    @     if (count > result)
  BLE   EndIfNewRes               @     {
  MOV   R3, R2                    @       result = count
EndIfNewRes:
  B     EndIf                     @     }
Else0:
  @   }
  @   else
  @   {
  LDR   R2, =0                    @     count = 0
  @   }
EndIf:
  MOV   R1, R4                    @   R1 = quotient
  B     While                     @ }
EndWh:
  MOV   R0, R3
  @ End of program ... check your result

End_Main:
  BX    lr

.end
