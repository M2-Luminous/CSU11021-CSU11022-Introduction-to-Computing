  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  // int length1 = 0;
  // int length2 = 0;
  // int address1 = 0;
  // int address2 = 0;
  //while1(STRBing1[address1] != 0)
  //    if(STRBing1[address1] > 'a' && STRBing1[address1] < 'z')
  //      {
  //        STRBing1[address1] = STRBing1[address1] + 0x20;
  //       } 
  //      length1++;
  //endwhile1
  //while2(STRBing2[address1] != 0)
  //    if(STRBing2[address1] > 'a' && STRBing2[address1] < 'z'
  //      {
  //        STRBing2[address1] = STRBing2[address1] + 0x20;
  //       } 
  //      length2++;
  //endwhile2
  //
  //if (length1 != length2)
  //  R0 = 0;
  //endif
  //
  //int address1 = 0
  //int address2 = 0
  //OUT (STRBing1[address1] !=0) 
  //{ 
  //    IN (STRBing2[address2] !=0)
  //     {
  //      if(STRBing1[address1] == STRBing2[address2])
  //          {
  //            STRBing2[address2] = '*'
  //            address1 ++
  //            OUT continue 
  //          }
  //        address2 ++
  //     }
  //    R0 = 0;
  //    end;
  //}
  //R0 = 1
  //end

  //write your program here
  


  MOV   R3, #0            // int length1 = 0;
  MOV   R4, #0            // int length2 = 0;
  MOV   R5, R1            // int address1 = 0;
  MOV   R6, R2            // int address2 = 0;

  
While1:                   //while1(STRing1[address1] != 0)
  LDRB   R7, [R5]
  CMP   R7,  #0
  BEQ   EndWh1       
  CMP   R7,  'a'          //    if(STRing1[address1] >= 'a' && STRBing1[address1] <= 'z')
  BLT   End1              //      {
  CMP   R7,  'z'
  BGT   End1
EndIf1:
  ADD   R3, #1            //      length1++;
  ADD   R5, #1            //   character + 1
  B     While1
End1:  
  ADD   R7, R7, 0x20      //        STRing1[address1] = STRing1[address1] - 0x20;
  STRB   R7, [R5]
  B     EndIf1            //       }  
EndWh1:                   //endwhile1

While2:             
  LDRB   R8, [R6]          //while2(STRing2[address1] != 0)
  CMP   R8,  #0
  BEQ   EndWh2      
  CMP   R8,  'a'          //    if(STRing2[address1] >= 'a' && STRing2[address1] <= 'z')
  BLT   End2              //      {
  CMP   R8,  'z'
  BGT   End2
EndIf2:
  ADD   R4, #1            //    length2++;
  ADD   R6, #1            //    character + 1
  B     While2
End2:  
  ADD   R8, R8, 0x20      //    STRing2[address1] = STRing2[address1] - 0x20;
  STRB   R8, [R6]
  B     EndIf2      
EndWh2:             


  CMP   R3, R4            //if (length1 != length2)
  BEQ   LengthEqual            
  MOV   R0, #0            //R0 = 0;
  B     End               //end

LengthEqual:
  MOV   R5, R1            //int address1 = 0
  MOV   R6, R2            //int address2 = 0
OUT:                      //OUT (STRing1[address1] !=0) 
  LDRB   R7, [R5]          //{
  CMP   R7, #0
  BEQ   EndOut
  MOV   R6, R2            // iniitialize address2 every time when it finish one loop
IN:                       //    IN (STRing2[address2] !=0)
  LDRB   R8, [R6]         //     {
  CMP   R8, #0  
  BEQ   EndIn
  CMP   R7, R8            //      if(STRing1[address1] == STRing2[address2])
  BNE   EndIf3            //          {
  MOV   R9, '.'           //            STRing2[address2] = '*'
  STRB   R9, [R6]
  ADD   R5, R5, #1        //            address1 ++
  B     OUT               //            OUT continue
                          //          }
EndIf3:
  ADD   R6, R6, #1        //        address2 ++
  B     IN        //     }
EndIn:
  MOV   R0, #0            //    R0 = 0;
  B     End               //    end;
                          //}
EndOut:                 
  MOV   R0, #1            //R0 = 1
End:                      //end
  // End of program ... check your result

End_Main:
  BX    lr
  
  
  
  
  
   
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
