  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Write an ARM Assembly Language Program that will compute
  @   the GCD (greatest common divisor) of two numbers in R2 and R3.
  
  @ *** your solution goes here *** 
  MOV R8, R2     
  CMP R8, #0     
  BGE EndIfNeg   
  RSB R8, R8, #0
  MOV R2, R8 
EndIfNeg:        
  MOV R9, R3     
  CMP R9, #0     
  BGE EndIfNegative   
  RSB R9, R9, #0
  MOV R3, R9      
EndIfNegative:        

WhileGCD:
  CMP R2, R3
  BEQ EndWhGCD
  MOV R0, R2
  CMP R2, R3    
  BLE ElseWhGCD      
  SUB R2, R2, R3
  MOV R0, R2  
  B   WhileGCD    
ElseWhGCD:          
  SUB R3, R3, R2
  B   WhileGCD 
EndWhGCD:
  MOV R0, R2     
           
  
  @ End of program ... check your result

End_Main:
  BX    lr

.end
