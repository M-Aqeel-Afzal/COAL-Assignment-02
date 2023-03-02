.model small
.stack 100h
.data
string1 db "aBc $"
string2 db "abc $"
string3 db "Given strings are equal $"
string4 db "Gviven strings are not equal $"
.code
START:
MOV AX, @DATA
MOV DS,AX
mov ax,offset string1
push ax
mov bx,offset string2
push bx
mov cx,lengthof string1
sub cx,1
push cx

mov cx,lengthof string2
sub cx,1
push cx
call equalsIgnoreCase
jmp exit

equalsIgnoreCase  proc
push bp
mov bp,sp
mov cl, byte ptr [bp+4]
mov ch, byte ptr [bp+6]
mov si, [bp+8]
mov di, [bp+10]
L1:
mov al,[si]
or al,00100000b
mov [si],al
inc si
dec cl
cmp cl,0
jne L1

L2:
mov al,[di]
or al,00100000b
mov [di],al
inc di
dec ch
cmp ch,0
jne L2

mov cl, byte ptr [bp+4]
mov ch, byte ptr [bp+6]
mov si, [bp+8]
mov di, [bp+10]
L3:
mov al,[si]
cmp al,[di]
je L4
jne not_equal

L4:
cmp cl,0
je   equal    
inc si
inc di
dec cl
jmp L3

equal:
mov dx,offset String3
mov ah,09h
int 21h
jmp L6
not_equal:
mov dx,offset String4
mov ah,09h
int 21h
L6:

pop bp
ret
equalsIgnoreCase endp

exit:
mov ah,04ch
int 21h
end START