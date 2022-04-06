  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  
  .global   quicksort
  .global   partition
  .global   swap

@ quicksort subroutine
@ Sort an array of words using Hoare's quicksort algorithm
@ https://en.wikipedia.org/wiki/Quicksort 
@
@ Parameters:
@   R0: Array start address
@   R1: lo index of portion of array to sort
@   R2: hi index of portion of array to sort
@
@ Return:
@   none
quicksort:
  PUSH    {R4-R7, LR}                      @ add any registers R4...R12 that you use

  @ *** PSEUDOCODE ***
  @ if (lo < hi) { // !!! You must use signed comparison (e.g. BGE) here !!!
  @   p = partition(array, lo, hi);
  @   quicksort(array, lo, p - 1);
  @   quicksort(array, p + 1, hi);
  @ }

  @
  @ your implementation goes here
  @
  MOV   R4, R1    //R4 = lo
  MOV   R5, R2    //R5 = hi
  MOV   R6, R0    //R6 = array

  CMP   R4, R5
  BGE   EndIf

  MOV   R0, R6
  MOV   R1, R4
  MOV   R2, R5
  BL    partition
  MOV   R7, R0    //R7 = p

  MOV   R0, R6
  MOV   R1, R4
  MOV   R2, R7
  SUB   R2, R2, #1
  BL    quicksort

  MOV   R0, R6
  MOV   R1, R7
  ADD   R1, R1, #1
  MOV   R2, R5
  BL    quicksort

EndIf:

  POP     {R4-R7, PC}                      @ add any registers R4...R12 that you use


@ partition subroutine
@ Partition an array of words into two parts such that all elements before some
@   element in the array that is chosen as a 'pivot' are less than the pivot
@   and all elements after the pivot are greater than the pivot.
@
@ Based on Lomuto's partition scheme (https://en.wikipedia.org/wiki/Quicksort)
@
@ Parameters:
@   R0: array start address
@   R1: lo index of partition to sort
@   R2: hi index of partition to sort
@
@ Return:
@   R0: pivot - the index of the chosen pivot value
partition:
  PUSH    {R4-R8, LR}                      @ add any registers R4...R12 that you use

  @ *** PSEUDOCODE ***
  @ pivot = array[hi];
  @ i = lo;
  @ for (j = lo; j <= hi; j++) {
  @   if (array[j] < pivot) {
  @     swap (array, i, j);
  @     i = i + 1;
  @   }
  @ }
  @ swap(array, i, hi);
  @ return i;
  LDR   R4, [R0, R2, LSL #2]      //piviot = R4
  MOV   R5, R1                    //R5 = i = lo
  MOV   R6, R2                    //R6 = hi

  MOV   R7, R1                    //R7 = j = lo
For:
  CMP   R7, R6
  BGT   EndFor

  LDR   R8, [R0, R7, LSL #2]      //R8 = array[j]
  CMP   R8, R4
  BGE   EndIf1
  MOV   R1, R5
  MOV   R2, R7
  BL    swap                      //swap (array, i, j);
  ADD   R5, R5, #1                //i = i + 1
EndIf1:

  ADD   R7, R7, #1                //j = j + 1
  B     For
EndFor:

  MOV   R1, R5
  MOV   R2, R6
  BL    swap                      //swap(array, i, hi);

  MOV   R0, R5

  @
  @ your implementation goes here
  @

  POP     {R4-R8, PC}                      @ add any registers R4...R12 that you use



@ swap subroutine
@ Swap the elements at two specified indices in an array of words.
@
@ Parameters:
@   R0: array - start address of an array of words
@   R1: a - index of first element to be swapped
@   R2: b - index of second element to be swapped
@
@ Return:
@   none
swap:
  PUSH    {R4, R5, LR}

  @
  @ your implementation goes here
  @
  LDR   R4, [R0, R1, LSL #2]
  LDR   R5, [R0, R2, LSL #2]

  STR   R4, [R0, R2, LSL #2]
  STR   R5, [R0, R1, LSL #2]

  POP     {R4, R5, PC}


.end