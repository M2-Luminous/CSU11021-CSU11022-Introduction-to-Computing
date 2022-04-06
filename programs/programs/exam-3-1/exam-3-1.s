  .syntax unified
  .cpu cortex-m4
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
  @   - view origStr using address "&origStr" and size 32
  @   - view newStr using address "&newStr" and size 32
  @
  @ If using a Watch Expression (array with ASCII character codes)
  @   view origStr using expression "(char[32])origStr"
  @   view newStr using expression "(char[32])newStr"
  @
  @ If using a Watch Expression (just see the string)
  @   view origStr using expression "(char*)&origStr"
  @   view newStr using expression "(char*)&newStr"
  @


  @ End of program ... check your result

End_Main:
  BX      LR

  .end