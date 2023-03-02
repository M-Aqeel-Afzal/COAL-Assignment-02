.model small
.stack 100H
.data
string1 db "input $"
string3 db "Perfect $"
string4 db "not perfect $"
.code
main proc   
mov ax,@data
mov ds,ax
 mov ah,09h
	mov dx,offset string1                  ;;seting dx value
		int 21h

mov dl, 10  
mov bl, 0         

scanNum:

      mov ah, 01h
      int 21h

      cmp al, 13   ; Check if user pressed ENTER KEY
      je  stop 

      mov ah, 0  
      sub al, 48   ; ASCII to DECIMAL

      mov cl, al
      mov al, bl   ; Store the previous value in AL

      mul dl       ; multiply the previous value with 10

      add al, cl   ; previous value + new value ( after previous value is multiplyed with 10 )
      mov bl, al

      jmp scanNum    









	
      
      stop:
			
        mov dl,bl 	
      
        mov bx,0  	
        mov [bx],dl 
        mov bx,1	
        mov cl,0
        mov [bx],cl	
        
        
        mov cl,1	
        check:		
        mov bx,0	
        mov dl,[bx] 
        cmp cl,dl	
        je  perfect 
        mov ah,0	
        mov al,0	
        mov al,[bx] 
        mov dl,cl 	
        div dl		
        cmp ah,0	
        je sum		
        level:		
        inc cl		
        jmp check	
        
        
        perfect:	
        mov bx,1	
        mov dl,[bx]	
        mov bx,0	
        mov al,[bx] 
        cmp dl,al	
        je Yes		
        jmp No		
        
        
        
        sum:		
        mov bx,1	
        add [bx],cl 
        jmp level	
        
        
        Yes:
           mov dx,offset String3
           mov ah,09h
           int 21h
           
            mov ah,04ch
        int 21h
        No:
           mov dx,offset String4
           mov ah,09h
           int 21h
           jmp finish
         mov ah,04ch
        int 21h

        finish:
        
        mov ah,04ch
        int 21h 

    
main endp

end main