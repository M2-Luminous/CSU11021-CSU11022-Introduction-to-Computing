  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @
  @ Write a program to swap the middle two bytes of the value in
  @   R4, leaving the outer two bytes unchanged
  @
  @ For example, if R4 initially contains 0x89ABCDEF, your program
  @   should change R4 to 0x89CDABEF
  @
  AND   R5, R4, #0x00FF0000
  MOV   R5, R5, LSR #8      //向右平移两格(8 bit)

  AND   R6, R4, #0x0000FF00
  MOV   R6, R6, LSL #8      //向左平移两个(8 bit)

  LDR   R7, =0x00FFFF00
  BIC   R4, R4, R7           //清除原函数中间位置的bit (bit clear)
  ORR   R4, R4, R5
  ORR   R4, R4, R6
  @ *** your solution goes here ***

  @ End of program ... check your result

End_Main:
  BX    lr

.end
//LDR R2, =0xAB12CD34
//
//LDR R3, =0x0000FFFF
//AND R1, R2, R3
//
//R1:0x0000CD34

//LDR R3, =0xFFFF0000
//AND R1, R2, R3
//
//R1:0xAB120000

//LDR R3, =0xFFFF0000
//AND R1, R2, R3
//MOV R1, R1, LSR #16
//R1:0x0000AB12            向右平移四个单位
