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
  @   setC_address = setB_address  
  @   end the program 
  @ if (countB == 0)               # if setA is null, the result is setA
  @   setC_address = setA_address  
  @ end the program
  @ for (int i, setA){              # copy setA to the result sequence setC
  @   setC.add(i);
  @ }
  @ int count = setA[0];
  @ int indexOfB = 1;
  @ int countOfAddedElement =0;
  @
  @ while (setB[indexOfB] != 0){
  @ int indexOfC = 1
  @   while (indexOfC < count){
  @      if (setB[indexOfB] == setC[indexOfC])
  @         indexOfB ++;
  @         continue the outerWhile
  @      indexOfC ++;
  @      continue the innerWhile
  @   }
  @   setC.add(setB[indexOfB]);
  @   countOfAddedElement ++;
  @   indexOfB ++;
  @   continue the outerWhile
  @ }
  @ lengthOfResult = count + countOfAddedElement;
  @ seqC[0] = lengthOfResult
  @ *************** END of sudo-code *****************

  LDR   R3, [R1]             @ int countA = setA[0];
  LDR   R4, [R2]             @ int countB = setB[0];
  CMP   R3, #0               @ if (countA == 0)
  BEQ   initialCase1                  @ setC_address = setB_address
  CMP   R4, #0               @ if (countB == 0)
  BEQ   initialCase2 
  B     endif                 @ setC_address = setA_address

initialCase1:
  MOV   R5, #0
  MOV   R9, R4
  ADD   R6, R2, #4
  ADD   R8, R0, #4
  STR   R4, [R0]
  B     while1
initialCase2:
  MOV   R5, #0
  MOV   R9, R3
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
  MOV   R5, #0
  ADD   R6, R1, #4
  ADD   R8, R0, #4
  ADD   R9, R2, #4
while2:
  CMP   R5, R3
  BEQ   endWhile2
  LDR R7, [R6]
  STR  R7, [R8]
  ADD   R5, #1
  ADD   R6, #4
  ADD   R8, #4
  B     while2
endWhile2:

  MOV   R5, #0
  MOV   R6, #0
outerWhile:
  CMP   R5, R4
  BEQ   endOuter
  MOV   R7, #0
  ADD   R10, R0, #4
  innerWhile:
    CMP   R7, R3
    BEQ   endInner
    LDR R11, [R9]
    LDR R12, [R10]
    CMP   R11, R12
    BEQ   if3
    B     endif3
    if3: 
      B   newOuter
    endif3:
      ADD   R7, R7, #1
      ADD   R10, R10, #4
      B     innerWhile
  endInner:
  STR    R11, [R8]
  ADD     R8, R8, #4
  ADD     R6, R6, #1
  newOuter:
  ADD   R5, R5, #1
  ADD   R9, R9, #4
  B     outerWhile
endOuter:
  ADD   R3, R3, R6
  STR  R3, [R0]

end:


  @ End of program ... check your result

End_Main:
  BX    lr

