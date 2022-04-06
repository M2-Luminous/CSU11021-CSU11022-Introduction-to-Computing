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
  @hints
  @ (1) use a boolean variable to remember whether the next alphabetic character you see should be UPPER CASE
  @      You can implement a boolean variable as a register that you set to either 0(FALSE) or 1(TRUE)
  @ (2) An outer while loop to process each chracter into sequence
  @ (3) An inner if statement :
  @ if ('A'...'Z')
  @ {
  @    statement
  @ }
  @ else if ('a'...'z')
  @ {
  @    statement
  @ }
  @ else
  @ {
  @    statement
  @ }

  @ isCap = 1
  @ LDRB   R2, [R1]
  @ while (R2 != 0){

  @ if(R2 > 'a' && R2 < 'z'){
  @  if (isCap == 1){
  @   change into upper case
  @   isCap = 0
  @    }
  @}                                  目的:如果你是小写,然后你又理应大写(1),那你就转成大写,同时让后面的字母不能大写(0)     过河拆桥!!!

  @ else if (R2 > 'A' && R2 < 'Z'){ 
  @  if (isCap != 1){
  @   change into lower case                       目的:如果你是大写,然后你又理应小写(0),那你就转成小写
  @   }
  @  else {
  @   isCap = 0                    目的:如果你是大写,而且你也理应是大写(1),那你就不用动,但是要让后面的字母不能大写(0)
  @     }
  @ }                                 

  @ else {                             
  @  isCap = 1                      目的:如果你什么都不是(空格,逗号,句号.....),那就证明下一个字母要大写(0-->1)
  @  }

  @  R1 = R1 + 1                             把目标从第一个字母转向第二个第三个.....
  @  LDRB   R2, [R1]
  @}   



  MOV   R3, #1              @   Capitalise = 1
  LDRB  R2, [R1]            @   R2 stands for the single character in String
While:        
  CMP   R2, #0        
  BEQ   EndWh               @  while (R2 != '0'){
        
  CMP   R2, #'a'            @   if (ch >= 'a' && ch <= 'z')
  BLO   ElseIf1             @   {
  CMP   R2, #'z'            @
  BHI   ElseIf1             @

  CMP   R3, #1              @      if (isCap == 1) {
  BNE   EndIf0
  SUB   R2, R2, #0x20       @      change it into upper case
  STRB  R2, [R1]            @     byte[address] = ch;
  MOV   R3, #0              @      isCap = 0
EndIf0:
  B     EndIf2
ElseIf1:


  CMP   R2, #'A'            @   if (ch >= 'A' && ch <= 'Z')
  BLO   ElseIf2             @   {
  CMP   R2, #'Z'            @
  BHI   ElseIf2             @

  CMP   R3, #0              @      if (isCap == 0) {
  BNE   EndIf1
  ADD   R2, R2, #0x20       @      change it into lower case
  STRB  R2, [R1]            @     byte[address] = ch;
EndIf1:
  MOV   R3, #0
  B     EndIf2              @        isCap = 0

ElseIf2:
  MOV   R3, #1              @    else {  isCap = 1
EndIf2:
  ADD   R1, R1, #1          @   R1 += 1
  LDRB  R2, [R1]            @   LDRB    R2, [R1]

  B      While
EndWh:

  @ End of program ... check your result

End_Main:
  BX    lr

