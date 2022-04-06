  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @
  @ Write an ARM Assembly Language Program that will determine
  @   whether the unsigned number in R1 is a prime number
  @
  @ Output:
  @   R0: 1 if the number in R1 is prime
  @       0 if the number in R1 is not prime
  @
                
  CMP  R1, #0
  BEQ  EndNotPrime
  CMP  R1, #1
  BEQ  EndNotPrime                  @ design for 0 and 1

  MOV   R8, #2
While:
  CMP   R8, R1
  BGE   EndPrime                    @ return back after R8 +1 and end the loop when all the numbers are tested
                      
  UDIV  R4, R1, R8                   
  MUL   R5, R4, R8
  CMP   R1, R5                      @ origin numbers compare to the numbers after UDIV and multiply back
  BEQ   EndNotPrime
                                    
  ADD   R8, R8, #1                  
  B     While                       @ ADD loop

EndPrime:
  MOV   R0, #1
  B     End

EndNotPrime:
  MOV   R0, #0
  B     End
End:
  
  @ *** your solution goes here ***


  @ End of program ... check your result

End_Main:
  BX    lr

.end
