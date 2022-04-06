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
  @ Debugging tips:
  @
  @ If using the View Memory window
  @   - view originalString using address "&originalString" and size 32
  @   - view newString using address "&newString" and size 32
  @
  @ If using a Watch Expression (array with ASCII character codes)
  @   view originalString using expression "(char[32])originalString"
  @   view newString using expression "(char[32])newString"
  @
  @ If using a Watch Expression (just see the string)
  @   view originalString using expression "(char*)&originalString"
  @   view newString using expression "(char*)&newString"
  @

  MOV   R3, #1                  @ isCap = 1
  LDRB  R2, [R1]
  MOV   R12, R0
OuterWhile:                     @ while (R2 != '0'){
  CMP   R2, #0
  BEQ   EndOuterWhile                 
  CMP   R2, #'a'
  BLO   elif
  CMP   R2, #'z'
  BHI   elif
  CMP   R3, #0                  
  BEQ   Endif                   @ if (isCap == 1)
  SUB   R2, R2, #0x20           @ convert to upper case
  MOV   R3, #0                  @ after converting, isCap shoukd be set false
  B     Endif                   @ because only the first char should be of upper-case

elif:                           @else if (R2 >= 'A' && R2 =< 'Z') {
  CMP   R2, #'A'
  BLO   else
  CMP   R2, #'Z'
  BHI   else
  CMP   R3, #1                  @ if (isCap == 0) 
  BEQ   else2
  ADD   R2, R2, #0x20           @ convert to lower case
  B     Endif

else2:
  MOV   R3, #0                  @ update isCap to 0 after the first char is processed
  B     Endif

else:
  MOV   R3, #1                  @ if the current char is not a character, it means that a word ends.
  B     EndifNoAdding                              @ The next word should begin with a CAPITALIZED character.
Endif:                          @ int the end of each loop, load the next char in memory to register
  STRB  R2, [R0]
  ADD   R0, #1
EndifNoAdding:  
  ADD   R1, #1
  LDRB  R2, [R1]
  B     OuterWhile

EndOuterWhile:

  LDRB  R2, [R12]  
  CMP   R2, #'Z'
  BHI   end
  ADD   R2, R2, #0x20
  STRB  R2, [R12]

  @ End of program ... check your result
end:
End_Main:
  BX    lr

