
.MODEL SMALL
 .STACK 100H

 .DATA
    string1  db  'Rundom matrix is: ','$'
    string2  db  'set is: ','$'

    matrix  word 0,3,4,7
            word 0,3,13,14
            word 19,20,13,0
            word 14,0,19,7
             
  n_row  byte 4
	   row_size byte 4
       var1 byte 0
 .CODE
   MAIN PROC
     MOV AX, @DATA           
     MOV DS, AX

     LEA DX, string1         ;desplaying masseage for rundom matrix
     MOV AH, 09h
     INT 21H

      mov dl,10                 ; moving control to next line 
      mov ah,02
      int 21h

     LEA SI, offset matrix          ;setting the offset matrix
 
     mov var1,15
      mov dl,10                                    ; printing the next line 
      mov ah,02
      int 21h
      MOV AH, 00h                                  ;  getting system time        
      INT 1AH         



       mov  ax, dx
       xor  dx, dx
       mov  cx, 2  
       div  cx       ; here dx contains the remainder of the division - from 0 to 9
 
       add  dl, 'A'  ; to ascii from '0' to '9'
       mov var1,dl
       mov bl,dl

  
     mov var1,dl


     CALL display_matrix    ;Calling the display matrix



      mov dl,10                 ; printing the next line 
      mov ah,02
      int 21h

       LEA DX, string2        ;desplaying masseage for set 
     MOV AH, 09h
     INT 21H

      mov dl,10                 ; printing the next line 
      mov ah,02
      int 21h
   call set_function                      ;calling set function to print the set
    
    
     
     MOV AH, 4CH            ;;ending of program        
     INT 21H
     MAIN ENDP

;;;;;;;;;;;;;;;;;Display matric function;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  display_matrix PROC   
   

   PUSH AX                        
   PUSH CX                      
   PUSH DX                      
   PUSH SI                       
   
   MOV Ch,n_row                   

   L2:                  ;;loop is itrating on ch
     MOV CL, row_size                 ;mov bl in cl

     call display_row
                           
     
     
      mov dl,10                 ; printing the next line 
      mov ah,02
      int 21h
    

     DEC ch                       
     CMP ch,0
     JNE L2               


   POP SI                         ; pop a value from STACK into the registers 
   POP DX                         
   POP CX                        
   POP AX                        

   RET
 display_matrix ENDP                       ;;ending of display matrix




 ;;;;;;;;;;;;;;;;;;display row function ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
display_row proc	

L1:                 ;;loop is itrating on cl
   
       MOV AH, 2                 ;output the space
       MOV DL, ' '               
       INT 21H                    

       MOV AX, [SI]               ;moving the si in axws
                
            MOV AH, 2  
            

       mov dl,[si]

         
      add dl,bl
    
      
       int 21h

       ADD SI, 2                  
       DEC CL 
       CMP cl,0
       JNE L1             

       ret
       display_row endp                         ;;;;ending display row

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; set function ::::::::::::::::::::::::::::::::::::

       set_function proc
       mov cl,4
       mov ch,4
       MOV AH, 2                 
       MOV DL, '{'                         ;prining opening braket of set
       INT 21H  
        LEA SI, offset matrix          ;setting the offset of matrix
        L6:



            L5:    
               MOV AX, [SI]                         ;moving the si in ax
               MOV AH, 2  
               mov dl,[si] 
               add dl,bl
               int 21h
               ADD SI, 2 
               dec cl
               cmp cl,0
               jne L5




           mov cl,4
           MOV AH, 2                 ;output the comma
           MOV DL, ','               
           INT 21H  
           dec ch
           cmp ch,0
           jne L6




       MOV AH, 2                 ;output the the closing braket
       MOV DL, '}'               
       INT 21H  
       ret 
       set_function endp




 END MAIN
































