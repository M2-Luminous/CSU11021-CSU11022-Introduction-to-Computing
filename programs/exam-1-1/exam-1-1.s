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
  //indexA=1
  //indexB=1
  //indexC=1
  //count = 0
  //outerwhile(indexA < lengthA)               
  //{              
  //   innerwhile(indexB < lengthB)            
  //   {
  //       value1 = wordA[indexA]
  //       value2 = wordB[indexB];
  //       if(value1 == value2)
  //        {
  //           indexA++
  //           branch to outer while 
  //           indexB++
  //           branch to inner while
  //        }     
  //   }
  //   STR value1 into R0 
  //   count1++ 
  //   indexA++
  //   branch to outerwhile



  //}
  //outerwhile(indexB < lengthB)               
  //{              
  //   innerwhile(indexA < lengthA)            
  //   {
  //       value3 = wordB[indexB]
  //       value4 = wordA[indexA];
  //       if(value3 == value4)
  //        {
  //           indexB++
  //           branch to outer while 
  //           indexA++
  //           branch to inner while
  //        }     
  //   }
  //   STR value3 into R0 
  //   count2++ 
  //   indexB++
  //   branch to outerwhile
  //} 
  //total = count1 + count2                                                 
  @ End of program ... check your result
// this program's idea is base from the union assignment
  MOV   R5, #0
  LDR   R3, [R1]             // int countA = arrayA[0];This represent the length of set A    
  LDR   R4, [R2]             // int countB = arrayB[0];This represent the length of set B
  CMP   R3, #0               // if (countA == 0)           
  BEQ   WhilearrayBCopy      //   arrayC = arrayB   
  CMP   R4, #0               // if (countB == 0)           
  BEQ   WhilearrayACopy      //   arrayC = arrayA 
  B     EndIf                

WhilearrayBCopy:                           
  MOV   R9, R4               
  ADD   R6, R2, #4           //   indexB = indexB + 1
  ADD   R7, R0, #4           //   indexC = indexC + 1
  STR   R4, [R0]
  B     WhileCopy
WhilearrayACopy:                             
  MOV   R9, R3               
  ADD   R6, R1, #4           //   indexA = indexA + 1
  ADD   R7, R0, #4           //   indexC = indexC + 1
  STR   R3, [R0]
  B     WhileCopy


WhileCopy:
  CMP   R5, R9
  BEQ   EndWhCopy
  LDR   R8, [R6]
  STR   R8, [R7]
  ADD   R5, #1                //   Addedtimes count
  ADD   R6, #4                //   move to next R0 index
  ADD   R7, #4                //   move to nexr R incex
  B     WhileCopy               
EndWhCopy:
  B     End 
EndIf: 
//another copy version
//WhilearrayACopy:
//MOV  R5, #1
//CMP  R5, R3
//BGT  EndACopy  
//ADD  R6, R1, #4
//ADD  R7, R0, #4
//LDR  R8, [R6]
//STR  R8, [R7]
//ADD  R5, R5, #1
//B    WhilearrayACopy
//EndACopy:
//WhilearrayBCopy:
//MOV  R5, #1
//CMP  R5, R4
//BGT  EndACopy  
//ADD  R9, R2, #4
//ADD  R10, R0, #4
//LDR  R8, [R9]
//STR  R8, [R10]
//ADD  R5, R5, #1
//B    WhilearrayACopy
//EndACopy:
                                           //  previous version, havn't been debug tet
                                           //  MOV   R5, #0
                                           //  MOV   R6, #0
                                           //  MOV   R7, #0
                                           //  MOV   R8, #0
                                           //  MOV   R9, #0       
                                           //  
                                           //  
                                           //  MOV   R5, R1
                                           //  ADD   R5, R5, #4   
                                           //  MOV   R6, R2
                                           //  ADD   R6, R6, #4   
                                           //  MOV   R7, R0
                                           //  ADD   R7, R7, #4   
                                           //  MOV   R8, #0       
                                           //
                                           //While1:
                                           //  CMP  R5, R3
                                           //  BGE  EndWh1
                                           //
                                           //While2:
                                           //  CMP  R6, R4
                                           //  BGE  EndWh2
                                           //  LDR  R9, [R5]      
                                           //  LDR  R10, [R6]     
                                           //
                                           //  CMP  R9, R10
                                           //  BNE  EndIf1
                                           //  ADD  R5, R5, #1
                                           //  B    While1
                                           //  ADD  R6, R6, #1
                                           //  B    While2
                                           //EndIf1:
                                           //  B    While2
                                           //EndWh2:
                                           //
                                           //  STR  R5, [R7]
                                           //  ADD  R7, R7, #4
                                           //  ADD  R8, R8, #1
                                           //  ADD  R5, R5, #1
                                           //  B    While1
                                           //EndWh1:
                                           //
                                           //  ADD  R11, R11, R8  
                                           //
                                           //  MOV  R8, #0
                                           //  MOV  R9, #0
                                           //  MOV  R10, #0
                                           //  MOV  R5, R1
                                           //  ADD  R5, R5, #4    
                                           //  MOV  R6, R2
                                           //  ADD  R6, R6, #4    
                                           //
                                           //
                                           //While3:
                                           //  CMP  R6, R4
                                           //  BGE  EndWh3
                                           //  
                                           //While4:
                                           //  CMP  R5, R3
                                           //  BGE  EndWh4
                                           //  LDR  R10, [R5]     
                                           //  LDR  R9, [R6]      
                                           //
                                           //  CMP  R9, R10
                                           //  BNE  EndIf2
                                           //  ADD  R6, R6, #1
                                           //  B    While3
                                           //  ADD  R5, R5, #1
                                           //  B    While4
                                           //EndIf2:
                                           //  B    While4
                                           //EndWh4:
                                           //
                                           //  STR  R6, [R7]
                                           //  ADD  R7, R7, #4
                                           //  ADD  R8, R8, #1
                                           //  ADD  R6, R6, #1
                                           //  B    While3
                                           //EndWh3:
                                           //
                                           //  ADD  R11, R11, R9
                                           //  LDR  R11, [R0]


  MOV   R5, #0
  MOV   R6, #0
  MOV   R8, #0
  MOV   R7, #0
  MOV   R9, #0                     //clear all the registers
  MOV   R10, #0                    //initialize all the rigisters for the coming command
  
  
  ADD   R5, R1, #4                 
  ADD   R8, R0, #4
  

While1:
  CMP  R9, R3                      //outerwhile(indexA < lengthA) 
  BGE  EndWh1
  MOV  R10, #0
  ADD  R6, R2, #4

While2:
  CMP  R10, R4                     //   innerwhile(indexB < lengthB) 
  BGE  EndWh2
  LDR  R11, [R5]                   //   value1 = wordA[indexA]
  LDR  R12, [R6]                   //   value2 = wordB[indexB]

  CMP  R11, R12                    //   if(value1 == value2)
  BEQ  IfEqual1
  B    EndIfE1
IfEqual1:
  B    branchToWhile1
EndIfE1:
  ADD  R10, R10, #1                //   indexB++
  ADD  R6, R6, #4                  //   branch to inner while
  B    While2
EndWh2:

  STR  R11, [R8]                   //   STR value1 into R0 
  ADD  R8, R8, #4                  //   indexA++
  ADD  R7, R7, #1                  //   count1++ or we can say:total count
branchToWhile1:
  ADD  R9, R9, #1                  //   indexA++
  ADD  R5, R5, #4   
  B    While1                      //   branch to outer while 
EndWh1:
//While 1 and While 2 is design for setA looking for same element from setB

  ADD   R5, R2, #4
  MOV   R9, #0 
  MOV   R11, #0
  MOV   R12, #0 


While3:
  CMP  R9, R4                      //outerwhile(indexB < lengthB) 
  BGE  EndWh3
  MOV  R10, #0
  ADD  R6, R1, #4

While4:
  CMP  R10, R3                     //   innerwhile(indexA < lengthA) 
  BGE  EndWh4
  LDR  R11, [R5]                   //   value3 = wordB[indexB]
  LDR  R12, [R6]                   //   value4 = wordA[indexA]

  CMP  R11, R12                    //   if(value3 == value4)
  BEQ  IfEqual2
  B    EndIfE2
IfEqual2:
  B    branchToWhile3
EndIfE2:
  ADD  R10, R10, #1                //   indexB++
  ADD  R6, R6, #4                  //   branch to inner while
  B    While4
EndWh4:

  STR  R11, [R8]                   //   STR value3 into R0 
  ADD  R8, R8, #4                  //   indexA++
  ADD  R7, R7, #1                  //   count1++ or we can say:total count
branchToWhile3:
  ADD  R9, R9, #1                  
  ADD  R5, R5, #4                  //   indexB++
  B    While3                      //   branch to outer while 
EndWh3:
//While 3 and While 4 is design for setB looking for same element from setA
 STR   R7, [R0]                    //   store the numbner of total element into R0

End:
End_Main:
  BX    lr

