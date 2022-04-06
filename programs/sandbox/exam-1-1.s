  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:
  

  @
  @ Write your program here
  @

  @
  @ REMEMBER: Sets are stored in memory in the format ...
  @
  @   size, element1, element2, element3, etc.
  @
  @ where size is the number of elements in the set, element1 is
  @   the first element, element2 is the second element, etc.
  @ 


  @
  @ Debugging tips:
  @
  @ If using the View Memory window
  @   - view set A using address "&setA" and size 64
  @   - view set B using address "&setB" and size 64
  @   - view set C using address "&setC" and size 64
  @
  @ If using a Watch Expression
  @   view set A using expression "(int[16])setA"
  @   view set B using expression "(int[16])setB"
  @   view set C using expression "(int[16])setC"
  @
  @ BUT REMEMBER, the first value you see should be the size, 
  @  the second value will be the first element, etc. (see above!)

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


endif:                      @ dealing with the case that both sets are not null
  ADD   R5, R1, #4          @ initialize addresses of set A, B, and C that stores the real set elemrnts
  ADD   R7, R0, #4
  MOV   R8, #0              @ initialize  countOfAddedElement as 0



  ADD   R5, R1, #4          @ initialize address of A
  MOV   R9, #0              @ initialize indexOfA as 0
outerWhile:
  CMP   R9, R3              @ while (indexOfA != countA){
  BEQ   endOuter
  MOV   R10, #0             @ int indexOfB (R10) = 0;
  ADD   R6, R2, #4          @ initialize the address of B in the begining of each outerloop
innerWhile:
  CMP   R10, R4
  BEQ   endInner
  LDR   R11, [R5]
  LDR   R12, [R6]
  CMP   R11, R12
  BEQ   if3                 @ if (setB[indexOfA] （R11） == setC[indexOfC]（R12）)
  B     endif3
if3:                        @ indexOfA ++;
  B     continueOuter       @ continue the outerWhile
endif3:
  ADD   R10, R10, #1        @ indexOfB ++;
  ADD   R6, R6, #4          @ addressB += 4;
  B     innerWhile          @ continue innerWhile
endInner:
  STR   R11, [R7]           @ if the current element in A doesn't appear in B,
  ADD   R7, R7, #4          @ append it to C
  ADD   R8, R8, #1          @ countOfAddedElement ++;
continueOuter:              @ start a new outerWhile loop after one elemnet is added from A
  ADD   R9, R9, #1
  ADD   R5, R5, #4
  B     outerWhile
endOuter:



  ADD   R5, R2, #4          @ initialize address of B
  MOV   R9, #0              @ initialize indexOfB as 0
outerWhile2:
  CMP   R9, R4              @ while (indexOfB != countB) OUTER WHILE 2
  BEQ   endOuter2
  MOV   R10, #0             @ int indexOfA (R10) = 0;
  ADD   R6, R1, #4          @ initialize the address of A in the begining of each outerloop
innerWhile2:
  CMP   R10, R3             @     while (indexOfA != countA) INNER WHILE 2
  BEQ   endInner2 
  LDR   R11, [R5]
  LDR   R12, [R6]
  CMP   R11, R12
  BEQ   if4                 @ if (setA[indexOfA] （R12） == setB[indexOfC]（R11）)
  B     endif4
if4:                        @ indexOfB ++;
  B     continueOuter2      @ continue the outerWhile
endif4:
  ADD   R10, R10, #1        @ indexOfA ++;
  ADD   R6, R6, #4          @ addressA += 4;
  B     innerWhile2         @ continue innerWhile
endInner2:
  STR   R11, [R7]           @ if the current element in B doesn't appear in A,
  ADD   R7, R7, #4          @ append it to C
  ADD   R8, R8, #1          @ countOfAddedElement ++;
continueOuter2:             @ start a new outerWhile loop after one elemnet is added from B
  ADD   R9, R9, #1
  ADD   R5, R5, #4
  B     outerWhile2
endOuter2:
  STR   R8, [R0]
  @ End of program ... check your result
end:
End_Main:
  BX    lr

