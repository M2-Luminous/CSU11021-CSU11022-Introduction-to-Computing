  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  //      iA = 0;
  //      while(iA < sizeA)
  //      {
  //          elementA = word[addressA];            LDR
  //      
  //          addressTemp = addressB;
  //          iB = 0;
  //          while(iB < sizeB)
  //          {
  //              elementB = word[addressTemp];
  //      
  //              if(elementA == elementB)
  //              {
  //                  word[addressC] = elementA;    STR
  //                  addressC = addressC + 4;
  //              }
  //      
  //              addressTemp = addressTemp + 4;
  //              iB = iB + 1;
  //          }
  //          
  //          addressA = addressA + 4;
  //          iA = iA + 1;
  //      }
  @ write your program here
  @

  @ Debugging tip:
  @ Use the watch expression ...
  @
  @   (signed int [64]) setC
  @
  @ ... to view your intersection set as your program creates it
  @ in memory.

  @ End of program ... check your result

End_Main:
  BX    lr

