  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main



Main:

  @
  @ Write your program here
  @

  @
  @ REMEMBER: Tickets are stored in memory in the format ...
  @
  @   count, t0n0, t0n1, ..., t0n4, t1n0, t1n1, ...
  @     
  @   where tXnY is ticket X, number Y and count is the number of tickets
  @ 


  @
  @ Debugging tips:
  @
  @ If using the View Memory window
  @   - view tickets using address "&tickets" and size 24
  @   - view draw using address "&draw" and size 24
  @

  @ End of program ... check your result

End_Main:
  BX      LR

  .end