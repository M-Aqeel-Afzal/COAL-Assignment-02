.model small
.data
.data
string1 db "Enter a number : $"
temp dw 1
var1 byte 5
.stack 100h
.code




delay proc


push ax
push bx
push cx
push dx

mov cx,1000
mydelay:
mov bx,2000      ;; increase this number if you want to add more delay, and decrease this number if you want to reduce delay.
mydelay1:
dec bx
jnz mydelay1
loop mydelay


pop dx
pop cx
pop bx
pop ax

ret

delay endp






Start PROC

mov ax,@data
mov ds,ax

mov ax,03h ;; clear screen
int 10h ;; and sets cursor to the top
mov al,'2'

mov ah,0
mov cx,ax
sub cx,48				; ASCII conversion


mov bl,9


L7:

mov al,'4'
mov bl,9

mov ah,0
mov cx,ax
sub cx,48				; ASCII conversion
mov ah,02				; printing nest line
mov dl,10
int 21h

mov bx,1
L1 :                          ;poshing a space in stack 
		push cx

		mov dx,"  "
		mov ah,02
					
L2 :	                          ;poshing a number in stack 
		int 21h
	loop L2
		mov cx,bx
		mov dx,temp
		mov dx,2Ah
		inc temp
		
L3:		                              ;;printing
		int 21h	
	loop L3
		mov ah,02
		mov dx,10
		mov ah,02
		int 21h
		
		inc bx 
		inc bx
		
		pop cx  
		loop L1	
		
call delay
dec var1
cmp var1,0
jne L7

mov ah,4ch
int 21h

Start endp
end Start






