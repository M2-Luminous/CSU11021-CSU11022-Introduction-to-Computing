  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:


  @ write your program here
  @  the length of the sequence stores in R2(N) which is = 8, and R1(address) is the sequence itself
  @ modeCount = 0;
  @ mode = 0;

  @ i1 = 0;
  @ while(i1 < R2)                  i1为外部count
  @{
  @   value1 = word[address1];      在sequence中取出第一个数,位置为address1, 并用value1代表

  @   count = 0;
  @   address2 = address1 + 4;      在sequence中取出第二个数,位置为address2, 并用value2代表
  @   i2 = i1 + 1;                  i2为内部count
  @   while(i2 < R2)
  @   {
  @       value2 = word[address2];
  @       if(value1 == value2)
  @        {
  @           count = count +1      众数判断的count
  @        }
  @        i2 = i2 + 1;
  @        address2 = address2 + 4  value2替代为下一个数
  @    }

  @    if(count > modeCount)
  @    {
  @     mode = value1;
  @     modeCount = count;          如果出现了比旧众数出现次数(count)还要多的新众数,就将这个新众数替换上去
  @    }                            ps:我愿称之为:一代新王换旧王

  @    i1 = i1 + 1;
  @    address1 = address1 + 4;     总结来看真的就是个握手问题,不过这个思路结构确实过于复杂,我修行不足,写不出来啊2333
  @}
  MOV   R0, #0          @ mode = 0;
  MOV   R3, #0          @ modeCount = 0;
  MOV   R9, #0

  MOV   R4, #0          @ i1 = 0;
While1:
  CMP   R4, R2          @ while(i1 < N)
  BGE   EndWh1  
  LDR   R5, [R1]        @   value1 = word[address1];

  MOV   R6, #0          @   count = 0;
  ADD   R9, R1, #4      @   address2 = address1 + 4;
  ADD   R7, R4, #1      @   i2 = i1 + 1;
While2:
  CMP   R7, R2          @   while(i2 < N)
  BGE   EndWh2
  LDR   R8, [R9]        @       value2 = word[address2];

  CMP   R5, R8          @       if(value1 == value2)
  BNE   EndIf1
  ADD   R6, R6, #1      @           count = count +1
EndIf1:
  ADD   R7, R7, #1      @        i2 = i2 + 1;
  ADD   R9, R9, #4      @        address2 = address2 + 4
  B     While2
EndWh2:                 @ }

  CMP   R6, R3          @    if(count > modeCount)
  BLE   EndIf2
  MOV   R0, R5          @     mode = value1;
  MOV   R3, R6          @     modeCount = count;
EndIf2:

  ADD   R4, R4, #1      @    i1 = i1 + 1;
  ADD   R1, R1, #4      @    address1 = address1 + 4;

  B       While1
EndWh1:                 @}
  @ End of program ... check your result

End_Main:
  BX    lr

  @  MOV   R11, #4

  @ LargeWhile:

  @ ADD   R8, R8, #1
  @ MUL   R9, R8, R11
  @ LDR   R3, [R1]
  @ CMP   R3, #0
  @ BEQ   End                   @ when there is no such a number
  @ CMP   R3, R7
  @ BEQ   EndWh

  @ LDR   R4, =1
  @ SUB   R1, R1, R9
  @ MOV   R5, #0

@ While:
  @ CMP   R4, #0
  @ BEQ   EndWh
  @ ADD   R1, R1, #4
  @ LDR   R4, [R1]
  @ CMP   R3, R4
  @ BEQ   Counter
  @ B     While
@ Counter:
  @ ADD   R5, R5, #1
  @ B     While
@ EndWh:
  @ MUL   R10, R2, R11
  @ SUB   R1, R1, R10
  @ ADD   R1, R1, R9


  @ CMP   R5, R6
  @ BGT   Current
  @ MOV   R0, R7
  @ B     LargeWhile
@ Current:
  @ MOV   R0, R3
  @ MOV   R6, R5
  @ MOV   R7, R3
  @ B     LargeWhile

@ End:                            @ this is a version that can not get full mark