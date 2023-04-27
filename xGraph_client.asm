GLOBAL main

section .text

extern _setup
extern _createRectangle
extern _draw

    main:
    
        call _setup

        push dword [width]
        push dword [heigth]
        push dword [y]
        push dword [x]
        push dword [snk]
        
        call _createRectangle
        add esp, byte 20

        call _draw


    ext:
        mov eax, 1
        mov ebx, 0
        int 0x80

section .data

    msg db 'Hola Mundo!',10,0

    snk dw 1
    x   dw 100
    y   dw 100
    heigth dw 10
    width  dw 10
