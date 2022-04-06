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
  @   - view stringC using address "&stringC" and size 64
  @
  @ If using a Watch Expression (just see the string)
  @   view stringC using expression "(char*)&stringC"
  @

  @ End of program ... check your result

End_Main:
  BX      LR


  .section  .rodata

@ Optionally, you may use the string below when redacting (overwriting) test
strStop:
  .asciz  "XXXXX"

  .end