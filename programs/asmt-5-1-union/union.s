  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:
  
  @
  @ write your program here
  //求两个arrays的并集
  LDR   R3, [R1]             // int countA = arrayA[0];    
  LDR   R4, [R2]             // int countB = arrayB[0];    
  CMP   R3, #0               // if (countA == 0)           
  BEQ   WhilearrayACopy         //   arrayC = arrayB   
  CMP   R4, #0               // if (countB == 0)           
  BEQ   WhilearrayBCopy         //   arrayC = arrayA 
  B     EndIf                

WhilearrayACopy:                
  MOV   R5, #0               
  MOV   R9, R4               
  ADD   R6, R2, #4           //   indexA = indexA + 1
  ADD   R8, R0, #4           //   indexC = indexC + 1
  STR   R4, [R0]
  B     While1
WhilearrayBCopy:                
  MOV   R5, #0               
  MOV   R9, R3               
  ADD   R6, R1, #4           //   indexB = indexB + 1
  ADD   R8, R0, #4           //   indexC = indexC + 1
  STR   R3, [R0]



While1:
  CMP   R5, R9
  BEQ   EndWh1
  LDR   R7, [R6]
  STR   R7, [R8]
  ADD   R5, #1
  ADD   R6, #4
  ADD   R8, #4
  B     While1               // copy all the arrayA into arrayC
EndWh1:
  B     End 
EndIf:




  MOV   R5, #0               // int Addedtimes =0;
  ADD   R6, R1, #4           // int indexB = 1;
  ADD   R8, R0, #4           // int indexC = 1
  ADD   R9, R2, #4
While2:
  CMP   R5, R3               //       if (arrayB[indexB] != arrayC[indexC])
  BEQ   EndWh2               
  LDR   R7, [R6]             
  STR   R7, [R8]             
  ADD   R5, #1               //       Addedtimes ++
  ADD   R6, #4               
  ADD   R8, #4               //       add arrayB in this index into arrayC
  B     While2               //       end while2
EndWh2:

  MOV   R5, #0               //       Addedtimes ++
  MOV   R6, #0
While3:
  CMP   R5, R4               // while (indexB != 0){  
  BEQ   EndWh3           
  MOV   R7, #0               // int indexC (R7) = 0;
  ADD   R10, R0, #4          // we need to initialise indexC (R7) before every while4
While4:
  CMP   R7, R3
  BEQ   EndWh4
  LDR   R11, [R9]
  LDR   R12, [R10]
  CMP   R11, R12
  BEQ   IfArray              // if (indexB （R9）= indexC（R10）)
  B     EndIfArray
  IfArray:                   // indexB++;  
  B     NewWh                // continue While3
  EndIfArray:
  ADD   R7, #1           
  ADD   R10, #4              // indexC = indexC + 4;
  B     While4               // continue While     
  EndWh4:
  STR   R11, [R8]            // add the arrayB number that did not appear
  ADD   R8, #4               // in arrayC
  ADD   R6, #1               // Addedtimes ++;
  NewWh:                     // start a new While statment after storing one register into arrayC
  ADD   R5, #1
  ADD   R9, #4
  B     While3
EndWh3:
  ADD   R3, R3, R6           // length= count + Addedtimes;
  STR   R3, [R0]             // store the length into the start of R0 

End:
 //  kevin's version, he's a genius
 //  MOV R12, #4
 //  MOV R11, #1
 //  MOV R10, #1
 //
 //  @ get string lenth from each 
 //  LDR R3, [R1]
 //  ADD R8, R3, #0
 //  LDR R4, [R2]
 //  ADD R7, R4, #1
 //  @ now get first part of sets 
 //  ADD R1, R1, #4
 //  LDR R5, [R1]
 //  ADD R2, R2, #4
 //  LDR R6, [R2]
 //  @move set a to set C
 //CountR0andstoreR1:
 //  ADD R0, R0, #4
 //  While:
 //  STR R5, [R0]
 //  ADD R11, R11, #1  @countall
 //  ADD R0, R0, #4
 //  ADD R1, R1, #4
 //  LDR R5, [R1]
 //  ADD R9, R9, #1    @count set a 
 //  CMP R9, R3
 //  BNE While
 //  B   AddinNonIntersect
 //
 //AddinNonIntersect:
 //  @ return to start of R1
 //  MUL R3, R3, R12
 //  SUB R1, R1, R3
 //  LDR R5, [R1]
 //  MOV R12, #4
 //  MOV R9, #0
 //
 //
 //Check:
 //  CMP R5, R6
 //  BEQ ChangesetB
 //  ADD R1, R1, #4
 //  LDR R5, [R1]
 //  ADD R9, R9, #1
 //  CMP R9, R8
 //  BEQ  AddtosetC
 //  B   Check
 //
 //  ChangesetB:
 //  ADD R10, R10, #1
 //  CMP R10, R7
 //  BEQ over
 //  ADD R2, R2, #4
 //  LDR R6, [R2]
 //  MUL R9, R9, R12
 //  SUB R9, R9, R12
 //  SUB R1, R1, R9
 //  SUB R1, R1, #4
 //  LDR R5, [R1]
 //  MOV R12, #4
 //  MOV R9, #0
 //  B   Check
 //
 //  AddtosetC:
 //  ADD R11, R11, #1
 //  STR R6, [R0]
 //  ADD R0, R0, #4
 //  B   ChangesetB
 //
 //  over:
 //  MOV R7, #1
 //  ADD R7, R11, #0
 //  SUB R7, R7, #1
 //  MUL R11, R11, R12
 //  SUB R0, R0, R11
 //  STR R7, [R0]




















//another version 
//int countA = arrayA[0];      
//int countB = arrayB[0];         
//if (countA == 0)             
//   arrayC = arrayB 
// if (countB == 0)               
//   arrayC = arrayA
//
// copy all the arrayA into arrayC
//
// int indexB = 1;               
// int Addedtimes =0;
// int indexC = 1
// while1 (indexB < countB)   
// {
//	indexC = 0;
//    while2 (indexC < countA)
//    {
//       if (arrayB[indexB] == arrayC[indexC]){
//		indexB ++;
//		continue while1
//	   }
//	   indexC++;
//	   continue while2
//    }
//	indexB ++;
//	continue while1
//	put current B char into C;
//	Addedtimes++;
// }
// total length = countA + Addedtimes;
// arrayC[0] = total length
 
// LDR   R3, [R1]                // int countA = arrayA[0]; 
// LDR   R4, [R2]                // int countB = arrayB[0]; 
// 
// MOV   R7, R0 
// MOV   R8, #0
// MOV   R6, #0
// MOV   R5, #0
// CMP   R3, #0                  // if (countA == 0)            
// BEQ   WhilearrayBCopy         //   arrayC = arrayB 
// CMP   R4, #0                  // if (countB == 0)  
// BEQ   WhilearrayACopy         //   arrayC = arrayA
// B     WhilearrayCopy 
//
//WhilearrayBCopy:               //   arrayC = arrayB 
// CMP   R8, R4 
// BGT   end
// LDR   R5, [R2]
// STR   R5, [R0] 
// ADD   R2, R2, #4              //   indexB = indexB + 1
// ADD   R0, R0, #4              //   indexC = indexC + 1
//
// ADD   R8, #1
// B     WhilearrayBCopy
//
//WhilearrayACopy:               //   arrayC = arrayA
// CMP   R6, R3 
// BGT   end 
// LDR   R5, [R1] 
// STR   R5, [R0]
// ADD   R1, R1, #4              //   indexA = indexA + 1
// ADD   R0, R0, #4              //   indexC = indexC + 1 
// ADD   R6, #1
// B     WhilearrayACopy
//
// MOV   R6, #0
//WhilearrayCopy:                // copy all the arrayA into arrayC
// CMP   R6, R3 
// BEQ   EndWhCopy
// ADD   R1, R1, #4              //   indexA = indexA + 1
// ADD   R7, R7, #4              //   indexC = indexC + 1 
// LDR   R5, [R1] 
// STR   R5, [R7]
// ADD   R6, #1
// B     WhilearrayCopy 
//EndWhCopy: 
//
//MOV    R11, R2                 // int indexB = 1;    
//MOV    R7, #0                  // int Addedtimes =0;
//ADD    R11, R11, #4            //  int indexC = 1
//                 
//         
//
//
//  MOV  R8, #0
//While1:                         // while1 (indexB < countB) 
//  CMP  R8, R4                   // {
//  BEQ  EndWh1
// MOV    R12, R0
// ADD    R12, R12, #4   
// MOV    R6, #0
//
//While2:    
//  LDR  R9,  [R11]
//  LDR  R10, [R12]              
//  CMP  R6, R3                   //    while2 (indexC < countA)
//  BEQ  EndWh2                   //    {
//
//
//  CMP  R9,  R10                 //       if (arrayB[indexB] == arrayC[indexC])  
//  BNE  EndIf                   
//  ADD  R11, R11, #4             //       indexB ++;
//  ADD  R8, R8, #1
//  B    While1                   //       continue while1
//EndIf:
//  ADD  R12, R12, #4             //indexC++;
//  ADD  R6, R6, #1
//  B    While2                   //continue while2
//                                //    }
//EndWh2:
//  STR  R9, [R12]                //put current B char into C <-- R0 POINTS TO A CONSTANT POINT IN MEMORY SO YOU ALWAYS
//                                              //OVERWRITE THE VALUE YOU TRY TO ADD
//                                              //SOLUTION: MAKE A NEW VARIABLE WHICH POINTS TO THE END OF SET C
//                                              //          EVERYTIME YOU WRITE A NEW VALUE TO SET C, ADD 4 TO THIS
//                                              //          VARIABLE SO THAT IT POINTS TO THE NEXT WORD IN MEMORY
//  ADD  R7, R7, #1               //Addedtimes++;
//  ADD  R11, R11, #4             //indexB ++;
//  ADD  R8, R8, #1
//  B    While1                   //continue while1
//
//EndWh1:
//  MOV   R8, #0
//  ADD   R8, R3, R7              // total length = countA + Addedtimes;
//  STR   R8, [R0]                // arrayC[0] = total length
//  
//@ End of program ... check your result
//end:

End_Main:
  BX    lr

