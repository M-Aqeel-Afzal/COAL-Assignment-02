
.MODEL SMALL
 .STACK 100H

 .DATA
    string1  db  'Rundom matrix are: ','$'

    ARRAY   word 3,2,3,4
            word 5,1,3,9
            word 1,2,3,6
            word 5,3,9,2
             
  n_row  byte 4
	   row_size byte 4
       var1 word 0
 .CODE
   MAIN PROC
     MOV AX, @DATA           
     MOV DS, AX

     LEA DX, string1         ;desplaying masseage
     MOV AH, 09h
     INT 21H

      mov dl,10                 ; moving control to next line 
      mov ah,02
      int 21h

     LEA SI, offset ARRAY           ;setting the offset array
   ;  MOV BH, n_row               ;moving total number of rows in bh
   ;  MOV BL, row_size               ;Moving size of row in bl

    mov bh,5
     mov var1,5
   L5:
    mov dl,10                 ; printing the next line 
      mov ah,02
      int 21h
MOV AH, 00h  ; interrupts to get system time        
   INT 1AH      ; CX:DX now hold number of clock ticks since midnight   
   MOV AH, 00h  ; interrupts to get system time        
   INT 1AH      ; CX:DX now hold number of clock ticks since midnight   

   mov  ax, dx
   xor  dx, dx
   mov  cx, var1   
   div  cx       ; here dx contains the remainder of the division - from 0 to 9

   add  dl, 'A'  ; to ascii from '0' to '9'
   mov bl,dl
  
     CALL display_matrix    ;Calling the display matrix
     dec bh
     add var1,2
     cmp bh,0
     jne L5
     
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
   ;   add dl,65
      add dl,bl
       int 21h

       ADD SI, 2                  
       DEC CL 
       CMP cl,0
       JNE L1             

       ret
       display_row endp                         ;;;;ending display row

 END MAIN
































