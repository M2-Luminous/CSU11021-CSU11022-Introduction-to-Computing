  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  
  // count = 0
  // result = 0
  // while (R1 != 0）
  // {
  //   dividedNumber = R1 // 2
  //   multiplyedNumber = dividedNumber * 2
  //   binaryCheck = R1 - multiplyedNumber
  //   if (binaryCheck == 1)
  //   {
  //     count = count + 1
  //     if (count > result)
  //     {
  //       result = count
  //     }
  //   }
  //   if (binaryCheck != 1)
  //   {
  //     count = 0
  //   }
  //   R1 = dividedNumber
  // }
  // MOV result into R0
  @ write your program here
  @
  MOV   R2, #0             // count = 0
  MOV   R3, #0             // result = 0
  MOV   R12, #2
While:                     // while (R1 != 0）
  CMP   R1, #0             // {
  BEQ   EndWh             
  UDIV  R4, R1, R12        //   dividedNumber = R1 // 2
  MUL   R5, R4, R12        //   multiplyedNumber = dividedNumber * 2
  SUB   R6, R1, R5         //   binaryCheck = R1 - multiplyedNumber
  CMP   R6, #1             //   if (binaryCheck == 1)
  BNE   ElseIf             //   {
  ADD   R2, R2, #1         //     count = count + 1    遇到是1的情况时,就使count + 1
  CMP   R2, R3             //     if (count > result)
  BLE   EndIf              //     {
  MOV   R3, R2             //       result = count     如果遇到有更大的连续count,那就把count赋值给result
  B     EndIf              //     }
                           //   }
ElseIf:                    //   if (binaryCheck != 1)
                           //   {
  MOV   R2, #0             //     count = 0            遇到是0的情况时,就把count清0
EndIf:                     //   }
  MOV   R1, R4             //   R1 = dividedNumber     做完所有判断操作后,将原来数字替换为当前已经被减了一位的数字,并继续当前循环
  B     While              // }
EndWh:  
  MOV   R0, R3             // MOV result into R0
@ write your program here

  @ End of program ... check your result

End_Main:
  BX    lr

.end
