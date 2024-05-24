[org 0x7c00]
xor ax, ax
mov ds, ax
mov es, ax
mov ax, 0x0201
mov cx, 0x0001
mov dh, 0
mov bx, 7c00h
int 13h
xor bx, bx
xor cx, cx
xor ax, ax
xor dx, dx
mov al, 0xa
call draw
mov al, 0x20
call draw
time:
call getTime
call calculate
mov ch, cl
mov al, ':'
call draw
call calculate
mov ch, dh
mov al, ':'
call draw
call calculate
jmp nextSecond
calculate:
mov al, ch
shr al, 4
add al, '0'
call draw
mov al, ch
shl al, 4
shr al, 4
add al, '0'
call draw
ret
nextSecond:
mov cx, dx
push cx
call getTime
pop cx
cmp dh, ch
je nextSecond
mov cl, 0
updateTime:
mov al, 0x8
call draw
mov al, 0x20
call draw
mov al, 0x8
call draw
inc cl
cmp cl, 7
jle updateTime
jmp time
draw:
mov ah, 0xe
int 10h
ret
getTime:
mov ah, 0x02
int 1ah
ret
times 510-($-$$) db 0
db 0x55, 0xaa
