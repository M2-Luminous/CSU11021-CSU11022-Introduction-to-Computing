  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
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
  @   - view originalString using address "&originalString" and size 32
  @   - view newString using address "&newString" and size 32
  @
  @ If using a Watch Expression (array with ASCII character codes)
  @   view originalString using expression "(char[32])originalString"
  @   view newString using expression "(char[32])newString"
  @
  @ If using a Watch Expression (just see the string)
  @   view originalString using expression "(char*)&originalString"
  @   view newString using expression "(char*)&newString"
  @
  @ if ('A'...'Z')
  @ {
  @    statement
  @ }
  @ Switchboolean2 if ('a'...'z')
  @ {
  @    statement
  @ }
  @ Switchboolean2
  @ {
  @    statement
  @ }

  @ isCap = 1
  @ LDRB   R2, [R1]
  @ while (R2 != 0){

  @ if(R2 > 'a' && R2 < 'z'){
  @  if (isCap == 1){
  @   change into upper case
  @   isCap = 0
  @    }
  @}                                  Purpose: If you are lowercase, and then you should be uppercase (1), 
  @                                   then you convert to uppercase, and at the same time make the following letters not uppercase (0)    

  @ Switchboolean2 if (R2 > 'A' && R2 < 'Z'){ 
  @  if (isCap != 1){
  @   change into lower case           Purpose: If you are uppercase, and then you should be lowercase (0), then you turn to lowercase
  @   }
  @  Switchboolean2 {
  @   isCap = 0                    Purpose: If you are capitalized, and you should be capitalized (1), then you don't need to move,
  @                                           but you must make the following letters not capitalized (0)
  @     }
  @ }                                 

  @ Switchboolean2 {                             
  @  isCap = 1                      Purpose: If you are nothing (space, comma, period...), then prove that the next letter should be capitalized (0-->1)
  @  }

  @  R1 = R1 + 1                             Shift the target from the first letter to the second and third...
  @  LDRB   R2, [R1]
  @}   
  //this program is base from the proper assignment
//  MOV   R3, #1        
//  LDRB  R2, [R1]      
//While:        
//  CMP   R2, #0        
//  BEQ   EndWh         
//        
//  CMP   R2, #'a'      
//  BLO   ElseIf1       
//  CMP   R2, #'z'      
//  BHI   ElseIf1       
//
//  CMP   R3, #1        
//  BNE   EndIf0
//  SUB   R2, R2, #0x20 
//  STRB  R2, [R1]      
//  MOV   R3, #0        
//EndIf0:
//  B     EndIf2
//ElseIf1:
//
//
//  CMP   R2, #'A'      
//  BLO   ElseIf2       
//  CMP   R2, #'Z'      
//  BHI   ElseIf2       
//
//  CMP   R3, #0        
//  BNE   EndIf1
//  ADD   R2, R2, #0x20 
//  STRB  R2, [R1]      
//EndIf1:
//  MOV   R3, #0
//  B     EndIf2        
//
//ElseIf2:
//  MOV   R3, #1        
//EndIf2:
//  ADD   R1, R1, #1    
//  LDRB  R2, [R1]      
//
//  B      While
//EndWh:





  MOV   R3, #1                         //R3 is a boolean register to judge whether a register need to become upper case or not                   
  LDRB  R2, [R1]                       //load character from memory         
  MOV   R4, R0                                
While1:                                                   
  CMP   R2, #0                                
  BEQ   EndWh1                                            
  CMP   R2, #'a'                                
  BLO   Condition1                                
  CMP   R2, #'z'                                
  BHI   Condition1                                
  CMP   R3, #0                                            
  BEQ   NeedToStore                    //if this character's boolean character is 0, then we can store the character directly into R0 because it is
                                       //lower case already                  
  SUB   R2, R2, #0x20                                     
  MOV   R3, #0                         //if this character is in lower case and boolean character is 1, we need to change it into upper case                   
  B     NeedToStore                    //and then store the character into R0                   
                                
Condition1:                                               
  CMP   R2, #'A'                                
  BLO   Switchboolean2                                
  CMP   R2, #'Z'                                
  BHI   Switchboolean2                                
  CMP   R3, #1                         //if this character's boolean character is 1, then we can store the character directly into R0 because it is 
                                       //upper case already                 
  BEQ   Switchboolean1                                
  ADD   R2, R2, #0x20                  //if this character is in upper case and boolean character is 0, we need to change it into lower case                   
  B     NeedToStore                                
                                
Switchboolean1:                         //after storing the upper case, we need to change the boolean from 1 to 0    
  MOV   R3, #0                                            
  B     NeedToStore                                
                                
Switchboolean2:                          //after storing the lower case, we need to change the boolean from 0 to 1 but no need to store      
  MOV   R3, #1                                            
  B     NoNeedToStore                                     
NeedToStore:                                              
  STRB  R2, [R0]                                
  ADD   R0, #1                                
NoNeedToStore:                            //go to the next character      
  ADD   R1, #1                                
  LDRB  R2, [R1]                                
  B     While1                                
                   //all the program beyond this line is to change the set into a proper case              
EndWh1:            //and then in this line, we will change the first characte into lower case to form the lowerCamelCase                    
                                
  LDRB  R2, [R4]
  //to locate the first position of the set, we can also use MOV R4, #0x20000000                                 
  CMP   R2, #'A'                                
  BLT   EndProgram                                 
  CMP   R2, #'Z'                                
  BHI   EndProgram                                
  ADD   R2, R2, #0x20       //change the first character into lower case                         
  STRB  R2, [R4]                                
EndProgram:                                
                                
                                



End_Main:
  BX    lr

