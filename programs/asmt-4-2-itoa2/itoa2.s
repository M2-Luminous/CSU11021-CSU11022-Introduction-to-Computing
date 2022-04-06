  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  @
  @ write your program here
  @

  @
  @ TIP: To view memory when debugging your program you can ...
  @
  @   Add the following watch expression: (unsigned char [64]) strA
  @
  @   OR
  @
  @   Open a Memory View specifying the address 0x20000000 and length at least 11
  @   You can open a Memory View with ctrl-shift-p type view memory (cmd-shift-p on a Mac)
  @



  CMP   R1, #0
  BGT   EndIfPos
  BLT   EndIfNeg
  BEQ   EndIfZero

EndIfZero:
  MOV   R11, #'0'
  STR  R11, [R0]
  B   End                   

EndIfPos:
  MOV  R10,  #'+'
  STR  R10, [R0]
  B   End1                   

EndIfNeg:
  MOV   R9, #'-'
  RSB   R1, #0
  STR   R9,  [R0]
  B   End1
End:

End1:

  MOV   R2, R1       @ number1 = number(origin number)  
  MOV   R3, #0       @ count = 0
  MOV   R12, #10

While: 
  CMP   R2, #0       @ while (number1 > 0)
  BLE   EndWh
  UDIV  R2, R2, R12  @ number1 = number1 / 10
  ADD   R3, R3, #1   @ count = count + 1
  B   While
EndWh:               @ 此处的目的是计算出来这个数字有多少位数,从而进行下一步UDIV计算

  MOV   R6, R1       @ number2 = number(origin number)
While1:
  CMP   R3, #0       @ while (count > 0)
  BLE   EndWh1
  MOV   R4, #1       @ i = 1
  MOV   R5, #1       @ j = 1

Whlie2:
  CMP   R4, R3       @    while (i < count)
  BGE   EndWh2
  UDIV  R6, R6, R12  @     number2 = number2 / 10
  ADD   R4, R4, #1   @      i = i + 1
  B     Whlie2       @     把数字的第一个位数(365中的3)计算出来,并将该数字放入sequence中
EndWh2:
  ADD   R7, R6, 0x30 @ transform decimal into hexidecimal
  ADD   R0, #1       @ value = byte[address];
  STRB  R7, [R0]     @ place the singe number into R0

While3:
  CMP   R5, R3
  BGE   EndWh3       @     while (j < count)
  MUL   R6, R6, R12  @       number2 = numner2 * 10
  ADD   R5, R5, #1   @       j = j + 1
  B     While3       @     把被10整除为个位数的number2给乘回来(365-->3-->300)
EndWh3:
  SUB   R6, R1, R6   @ number2 = number - number2
  MOV   R1, R6       @ number = number2
  SUB   R3, R3, #1   @ count = count - 1
  B     While1       @    让365 - 300 从而获得新的数字65,并进行下一步计算,并让count减去1 来代表此时65的位数(3 - 1 = 2)
EndWh1:



  @ End of program ... check your result

End_Main:
  BX    lr


@ 苏适的做法,我觉着好像差不多

@   CMP   R1, #0                @ if (R1 < 0)
@   BGE   Else                  @ {
@   MOV   R2, #'-'              @   byte[address] = '-';
@   STRB  R2, [R0], #1          @   address += 1;
@   RSB   R1, R1, #0            @   R1 = abs(R1);
@   B     EndIf                 @ }
  
@Else:
  
@   CMP   R1, #0                @ else if (R1 == 0)
@   BNE   NotZero
@   BEQ   Zero
  
@Zero:
  
@   MOV   R2, #'0'              @   byte[address] = '0';
@   STRB  R2, [R0]
@   B     End_Main
  
@NotZero:
                               @ else {
@   MOV   R2, #'+'              @   byte[address] = '+';
@   STRB  R2, [R0], #1          @   address += 1;
  
@EndIf:
  
@   LDR   R4, =0                @ count = 0;
@   MOV   R5, R1                @ temp = R1;
@   MOV   R3, #10               @ TEN = 10;  // set constant
  
@WhileGetLength:
  
@   CMP   R5, #10               @ while (temp >= 10)
@   BLO   EndWhGetLength        @ {
@   UDIV  R5, R5, R3            @   temp = temp / 10;
@   ADD   R4, R4, #1            @   count += 1;
@   B     WhileGetLength        @ }
  
@EndWhGetLength:
  
@While:
  
@   CMP   R4, #0                @ while (count > 0)
@   BLS   EndWh                 @ {
@   LDR   R5, =1                @   temp = 1;
@   LDR   R6, =0                
  
@For:
  
@   CMP   R6, R4                @   for (i = 0; i < count; i++)
@   BHS   EndFor                @   {
@   MUL   R5, R5, R3            @     temp *= 10;
@   ADD   R6, R6, #1
@   B     For                   @   }
  
@EndFor:
  
@   UDIV  R7, R1, R5            @   ch = R1 / temp;
@   ADD   R9, R7, #48           @   memory[address++] = ch + 48;  // translate to ASCII code
@   STRB  R9, [R0], #1
@   MUL   R8, R5, R7 
@   SUB   R1, R1, R8            @   R1 -= ch * temp;
@   SUB   R4, R4, #1            @   count--;
@   B     While                 @ }
  
@EndWh:
  
@   ADD   R3, R1, #48           @ byte[address] = 48 + temp
@   STRB  R3, [R0]