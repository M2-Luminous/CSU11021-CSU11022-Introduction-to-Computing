  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  //    ch1 = byte[address1];
  //    ch2 = byte[address2];
  //    while(ch1 != 0 && ch1 == ch2 && ch2 != 0)
  //    {
  //      address1 = address1 + 1;
  //      address2 = address2 + 1;
  //      ch1 = byte[address1];
  //      ch2 = byte[address2];
  //    }
    
  //    if(ch1 == ch2)
  //    {
  //      result = 0;
  //    }
  //    else if (ch1 > ch2)
  //    {
  //      result = 1;
  //    }
  //    else if (ch1 < ch2)
  //      result = -1;
  //    }

  @ write your program here
  @

  @ End of program ... check your result

End_Main:
  BX    lr

