  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ An upper triangular matrix is a square matrix in which all
  @  entries below the main diagonal (top-left to bottom right)
  @  are zero

  @ result = TRUE;
  @ for (r = 1; r < N; r++)
  @ {
  @   for (c = 0; c < r; c++)
  @   {
  @     elem = matrix[r][c];
  @     if (elem != 0)
  @     {
  @       result = FALSE;
  @     }
  @   }
  @ }

  MOV     R0, #1                  @ result = TRUE;
                                  @
  MOV     R4, #1                  @ for (r = 1; r < N; r++)
whR:                              @ {
  CMP     R4, R2                  @
  BHS     ewhR                    @
                                  @
  MOV     R5, #0                  @   for (c = 0; c < r; c++)
whC:                              @   {
  CMP     R5, R4                  @
  BHS     ewhC                    @
                                  @
  MUL     R6, R4, R2              @     elem = matrix[r][c];
  ADD     R6, R6, R5              @
  LDR     R7, [R1, R6, LSL #2]    @
                                  @
  CMP     R7, #0                  @     if (elem != 0)
  BEQ     endifz                  @     {
  MOV     R0, #0                  @       result = false;
endifz:                           @     }
  ADD     R5, R5, #1              @   
  B       whC                     @   }
ewhC:                             @
  ADD     R4, R4, #1              @   
  B       whR                     @ }
ewhR:

  MOV R0, #1                  //result = TRUE

  MOV R4, #1                  //for (r = 1; r < N; r++)   //N is the largest index of the row number
whR:                          //{
  CMP R4, R2
  BHS ewhR

  MOV R5, #0                  //  for (c = 0; c < r; c++)
whC:
  CMP R5, R4
  BHS ewhC                    
                              //                        [r][c]   [r][c]   [r][c]   [r][c]   [r][c]   [r][c]
  MUL R6, R4, R2              //  elem = matrix[r][c]   [1][0]   [2][0]   [2][1]   [3][0]   [3][1]   [3][2]
  ADD R6, R6, R5
  LDR R7, [R1, R6, LSL #2]

  CMP R7, #0                  // if(elem != 0)
  BEQ endifz                  //{
  MOV R0, #0                  //    result = false
endifz:
  ADD R5, R5, #1              
  B   whC
ewhC:


  ADD R4, R4, #1
  B   whR
ewhR:
End_Main:
  BX      LR

  .end