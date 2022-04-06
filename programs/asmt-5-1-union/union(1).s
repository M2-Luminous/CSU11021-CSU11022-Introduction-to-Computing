  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:
  
  @
  @ write your program here
  @

  @ *********** sudo-code declaration **************
  @
  @ we can defin sequence A as setA
  @ and sequence B as setB
  @ The result sequence is setC
  @
  @ ****************** sudo-code ********************
  @
  @ int countA = setA[0];
  @ int countB = setB[0];
  @ if (countA == 0)               # if setA is null, the result is setB
  @   move all elements in B to C 
  @   end the program 
  @ if (countB == 0)               # if setA is null, the result is setA
  @   move all elements in A to C   
  @   end the program
  @ for (int i, setA){              # copy setA to the result sequence setC
  @   setC.add(i);
  @ }
  @ int count = setA[0];
  @ int indexOfB = 1;
  @ int countOfAddedElement =0;
  @
  @ while (indexOfB（R5） != countB （R4）){
  @     int indexOfC（R7）= 0;
  @     while (indexOfC（R7） != countA （R3）){
  @         if (setB[indexOfB] （R9） == setC[indexOfC]（R10）)
  @         indexOfB（R5, R9） ++;
  @         continue the outerWhile
  @         #endif3:
  @         indexOfC （R7, R10）++;
  @         continue the innerWhile
  @      }
  @      setC.add(setB[indexOfB]);
  @      countOfAddedElement ++;
  @      indexOfB （R5, R9） ++;
  @      continue the outerWhile
  @ }
  @ lengthOfResult = count + countOfAddedElement;
  @ seqC[0] = lengthOfResult
  @ *************** END of sudo-code *****************

  LDR   R3, [R1]             @ int countA = setA[0];
  LDR   R4, [R2]             @ int countB = setB[0];
  CMP   R3, #0               @ if A is null
  BEQ   initialCase1         @ setC_address = setB_address
  CMP   R4, #0               @ if B is null
  BEQ   initialCase2 
  B     endif                @ setC_address = setA_address

initialCase1:                @ if A is null, copy B into C
  MOV   R5, #0               @ traverse each element of B in while1 loop,
  MOV   R9, R4               @ put them on by one into C
  ADD   R6, R2, #4
  ADD   R8, R0, #4
  STR   R4, [R0]
  B     while1
initialCase2:                @ if B is null, copy A inot C
  MOV   R5, #0               @ traverse each element of A in while1 loop,
  MOV   R9, R3               @ put them on by one into C
  ADD   R6, R1, #4
  ADD   R8, R0, #4
  STR   R3, [R0]
while1:
  CMP   R5, R9
  BEQ   endWhile1
  LDR   R7, [R6]
  STR   R7, [R8]
  ADD   R5, #1
  ADD   R6, #4
  ADD   R8, #4
  B     while1
endWhile1:
  B     end
endif:
  MOV   R5, #0              @ initialize address that stores the real set elemrnts
  ADD   R6, R1, #4          @ (each address plus 4)
  ADD   R8, R0, #4
  ADD   R9, R2, #4
while2:
  CMP   R5, R3              @ copy set A into set C
  BEQ   endWhile2           @ using while2 loop to traverse each elemrnt in set A 
  LDR   R7, [R6]            @ put each elemrnt in setC
  STR   R7, [R8]
  ADD   R5, #1
  ADD   R6, #4
  ADD   R8, #4
  B     while2
endWhile2:

  MOV   R5, #0
  MOV   R6, #0
outerWhile:
  CMP   R5, R4              @ while (setB[indexOfB] != 0){
  BEQ   endOuter
  MOV   R7, #0              @ int indexOfC (R7) = 0;
  ADD   R10, R0, #4         @ # initialize indexOfC (R7) before each innerloop
innerWhile:
  CMP   R7, R3
  BEQ   endInner
  LDR   R11, [R9]
  LDR   R12, [R10]
  CMP   R11, R12
  BEQ   if3                 @ if (setB[indexOfB] （R9） == setC[indexOfC]（R10）)
  B     endif3
  if3:                      @ indexOfB（R5, R9） ++;
  B     newOuter            @ continue the outerWhile
  endif3:
  ADD   R7, R7, #1          @ indexOfC ++;
  ADD   R10, R10, #4        @ addressC += 4;
  B     innerWhile          @ continue innerWhile
  endInner:
  STR   R11, [R8]           @ if the current element in B doesn't appear in A,
  ADD   R8, R8, #4          @ append it to C
  ADD   R6, R6, #1          @ countOfAddedElement ++;
  newOuter:                 @ start a new outerWhile loop after one elemnet is added from B
  ADD   R5, R5, #1
  ADD   R9, R9, #4
  B     outerWhile
endOuter:
  ADD   R3, R3, R6          @ lengthOfResult = count + countOfAddedElement;
  STR   R3, [R0]            @ store lengthOfResult into R0(where C begins in memory)

end:


  @ End of program ... check your result

End_Main:
  BX    lr

