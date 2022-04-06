  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  MOV   R0, #0        @ sum = 0;

  MOV   R2, #0        @ i = 0;
While:
  CMP   R2, #10       @ while (i < 10)
  BHS   EndWhile      @ {
                      @
  LDR   R3, [R1]      @   value = word[address];
  ADD   R0, R0, R3    @   sum = sum + value;
  ADD   R1, R1, #4    @   address = address + 4;
  ADD   R2, R2, #1    @   i = i + 1;
                      @
  B     While         @ }
EndWhile:

  @ End of program ... check your result

End_Main:
  BX    lr
@ MOV R4, #4

@ MOV R0, #0             sum = 0  
@ MOV R2, #0             i   = 0  
@While:               
@ CMP R2, #10            while( i < 10)   
@ BEQ EndWh              { 
@ MUL R3, R2, R4         valueAdress = startAddress + (i * 4)         
@ ADD R3, R3, #1                  
@ LDR R5, [R3]                  
@ ADD R0, R0, R5         sum = sum + word[valueAddress]         
@ ADD R2, R2, #1         i = i + 1         
@ B   While              }    
@EndWh:                  