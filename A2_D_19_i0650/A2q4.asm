.model small
.stack 100h
.data
;-------------- carriage return         
   cr equ 0DH 
;--------------  line feed
   lf equ 0AH          
           
   string1 DB cr,lf,'enter your required Expression : ',cr,lf,'$'
   correct DB  cr,lf,'Expression is correct.$'
   left_bracket DB  cr,lf,'Too many lift brackets,please try again :) ',cr,lf,'$'
   right_bracket DB  cr,lf,'Too many right brackets,please try again :)',cr,lf,'$'
   _mismatch DB  cr,lf,'brackets are not matched ,lease try again :)',cr,lf,'$'
   continue DB  cr,lf,'Click on Y to continue or any other Alphabat to end the program:',cr,lf,'$'
 
 
 
.code       
 
main proc
     
   mov ax,@data  
   mov ds,ax    
 
 
start:
   lea dx,string1   ;;;massage for taking input from user                
   mov ah,9
   int 21h
 
 
   xor cx,cx                
   mov ah,1                
 
 
input:         ; taking input   
 
    int 21h                
     
    cmp al,0Dh       ;checking if the enter is pressed or not            
           JE end_input                     
     
 ;-----------------if left bracket,then push on stack
    cmp al, "["              
           JE pushing       
    cmp al, "{"              
           JE pushing         
    cmp al, "("            
           JE pushing
     
     
 ;----------------if right bracket,then pop stack
                   
    cmp al, ")"           
           JE small       
    cmp al, "}"           
           JE curly        
    cmp al, "]"            
           JE line_b     
    jmp input
 
 
 
pushing: 
    push ax                
    inc cx                  
    jmp input
        
     
     
                    
small:                       
           dec cx             
           cmp cx,0           
           JL many_right        
            
           pop dx
           cmp dl, "("              
           JNE mismatch             
           JMP input          
              
              
curly:                                           
        dec cx                  
        cmp cx,0                 
        JL many_right  
        pop dx       
        cmp dl, "{"           
        JNE mismatch            
        JMP input 
   
 
 
line_b:                 
        dec cx                
        cmp cx, 0                
        JL many_right
        pop dx           
        cmp dl, "["                
        JNE mismatch      
        JMP input 
      
                    
end_input: 
     cmp cx, 0                  
     JNE many_left           
      
     mov ah, 9               
     lea dx, correct              
     int 21h                      
      
     lea dx, continue             
     int 21h
                            
     mov ah,1                    
     int 21h                    
      
     cmp al, "y"              
     JNE L1              
     JMP start                  
       L1:  
        cmp al, "Y"              
     JNE exit              
     JMP start    
mismatch:  
     lea dx, _mismatch        
     mov ah,9                     
     int 21h
     JMP start                   
      
 
 
many_left: 
     lea dx, left_bracket   
     mov ah,9
     int 21h
     JMP start               
            
            
many_right: 
     lea dx, right_bracket     
     mov ah,9
     int 21h
     JMP start                   
 
 
 
exit: 
     mov ah,4ch               
     int 21h
 
 
MAIN ENDP
  END MAIN