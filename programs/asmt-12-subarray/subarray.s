  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  @
  @ write your program here
  @
//The start address of A will be in R0 
//Tthe size of A (number of rows and columns) will be in R1. 
//The start address of B will be in R2 
//The size of B (number of rows and columns) will be in R3. 
//Your program should store 1 in R0 if B is contained in A and 0 otherwise.

//aLim = NA - NB;
//isSub = False;
//for(ra = 0 && isSub == False;ra <= aLim;ra++){
//  for(ca = 0 && isSub == False;ca <= aLim;ca++){
//    isSub = True;
//    for(rb = 0 ; isSub == True && rb < NB; rb++){
//      for(cb = 0 ; isSub == True && cb < NB; cb++){
//        elemA = A[ra + rb][ca + cb];
//        elemB = B[rb][cb];
//        if(elemA != elemB){
//          isSub = False;
//        }
//       }
//     }
//   }
//}
//trick:LDR R8, [R0, R8, LSL #2]
//save(isSub(R11), aLim(R12))
//use
//restore(isSub(R11), aLim(R12))
//push{R11, R12}
//use
//pop{R11, R12}



//int limit (R8) = NA-NB
//boolean isSUb (R9) = false
//int ra (R4), ca (R5), rb (R6), cb (R7);
//
//ra (R4) = 0;
//while (ra (R4) < limit (R8) && !isSub (R9)){
//	ca (R5) = 0;
//	while (ca (R5) < limit (R8) && !isSUb (R9)){
//		isSUb (R9) = true;				
//		rb (R6) = 0;
//		while (rb (R6) < NB && isSUb (R9)){
//			cb (R7) = 0;
//			while (cb (R7) < NB && isSub (R9)){
//				eleA (R11) = A[ra+rb][ca+cb];
//				eleB (R12) = B[rb][cb];
//				if (eleA (R11) != eleB (R12) )
//					isSUb (R9) = false;
//				cb (R7)++;
//			}
//			rb (R6)++;
//		}
//		ca (R5)++;
//	}
//	ra (R4)++;
//}
//R4 = Row A
//R5 = Column A
//R6 = Row B
//R7 = Column B
//R8 = limit
//R9 = isSub(boolean)
//R11 = eleA
//R12 = eleB


  SUB R8, R1, R3
  MOV R9, #0
  //ra = R4
  //ca = R5
  //rb = R6
  //cb = R7
  MOV R4, #0
  
While1:
  CMP R4, R8
  BGT EndWh1
  CMP R9, #1
  BEQ EndWh1

  MOV R5, #0
While2:
  CMP R5, R8
  BGT EndWh2
  CMP R9, #1
  BEQ EndWh2  

  MOV R9, #1
  MOV R6, #0

While3:
  CMP R6, R3
  BGE EndWh3
  CMP R9, #0
  BEQ EndWh3

  MOV R7, #0

While4:
  CMP R7, R3
  BGE EndWh4
  CMP R9, #0
  BEQ EndWh4

  ADD   R11, R4, R6
  MUL   R11, R11, R1
  ADD   R11, R11, R5
  ADD   R11, R11, R7
  LDR   R11, [R0, R11, LSL #2]
      
  MUL   R12, R6, R3
  ADD   R12, R12, R7
  LDR   R12, [R2, R12, LSL #2]

  CMP R11, R12
  BEQ EndIf
  MOV R9, #0
EndIf:
  ADD R7, R7, #1
  B   While4
EndWh4:
  ADD R6, R6, #1
  B   While3
EndWh3: 
  ADD R5, R5, #1
  B   While2
EndWh2:
  ADD R4, R4, #1
  B   While1
EndWh1:
  MOV R0, R9



























  @ End of program ... check your result

End_Main:
  BX    lr

