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
  LDR     R1, =1        @ column number
  LDR     R2, =9        @ value to count
  BL      countInCol

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

.end
