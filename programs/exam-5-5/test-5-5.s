  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global Main


  .section  .text

  .type     Main, %function
Main:
  STMFD   SP!, {LR}

  LDR     R0, =grid     @ start address of grid
  LDR     R1, =0        @ row number
  LDR     R2, =0        @ column number
  BL      solveSudoku

End_Main:
  LDMFD   SP!, {PC}


  .section  .data

@ Sudoku grid
grid:
    .byte 5,3,0,0,7,0,0,0,0
    .byte 6,0,0,1,9,5,0,0,0
    .byte 0,9,8,0,0,0,0,6,0
    .byte 8,0,0,0,6,0,0,0,3
    .byte 4,0,0,8,0,3,0,0,1
    .byte 7,0,0,0,2,0,0,0,6
    .byte 0,6,0,0,0,0,2,8,0
    .byte 0,0,0,4,1,9,0,0,5
    .byte 0,0,0,0,8,0,0,7,9

@ Almost complete Sudoku grid
@ Row 8, col 6 is the only remaining cell to be filled
@ Hint: use this grid for initial testing, instead of the one above!!
@ grid:
    @ .byte 5,3,4,6,7,8,9,1,2
    @ .byte 6,7,2,1,9,5,3,4,8
    @ .byte 1,9,8,3,4,2,5,6,7
    @ .byte 8,5,9,7,6,1,4,2,3
    @ .byte 4,2,6,8,5,3,7,9,1
    @ .byte 7,1,3,9,2,4,8,5,6
    @ .byte 9,6,1,5,3,7,2,8,4
    @ .byte 2,8,7,4,1,9,6,3,5
    @ .byte 3,4,5,2,8,6,0,7,9
.end
