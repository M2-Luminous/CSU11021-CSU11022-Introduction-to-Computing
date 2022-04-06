  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:
  MUL  R0, R1, R1
  LDR  R2, =4
  MUL  R0, R2, R0

  LDR  R2, =3
  MUL  R2, R1, R2

  ADD  R0, R0, R2

End_Main:
  BX    lr
