; modify this for variants on the effect
pattern equ 10

bits 16
org 0x100
    mov al,0x13
    int 0x10
    les dx,[bx]
    mov ds,dx
odd:
    xor al,byte [di-1]
    or al,0x10
    stosw
main:
    cwd
    dec di
    jno noframe
    add cx,bx
    xor bx,1
    ;in al,60h
    ;dec ax
    ;jnz noframe
    ;ret
noframe:
    lea ax,[bx+di]
    mov bp,320
    div bp
    add ax,cx
    mov bp,dx
    sub dx,ax
    add ax,bp
    and ax,dx
    aam pattern
    add al,ch
    xor al,cl
    ror al,3
    and al,ah
    test bx,bx
    jnz odd
even:
    or al,byte [es:di+1]
    mov byte [di],al
    jmp main
