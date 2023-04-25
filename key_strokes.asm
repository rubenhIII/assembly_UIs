GLOBAL main

section .text

    main:
        
        ;Termios
        mov eax, 0x36
        mov ebx, 0
        mov ecx, 0x5401
        mov edx, termios
        int 0x80

        and byte [c_lflag], 0xFD
        and byte [c_lflag], 0xF7

        mov eax, 0x36
        mov ebx, 0
        mov ecx, 0x5402
        mov edx, termios
        int 0x80


        ;Read Key
        mov eax, 0x03
        mov edi, 0
        mov ecx, key
        mov edx, 1
        int 0x80

        ;Print Message
        mov eax, 0x04
        mov ebx, 1
        mov ecx, key
        mov edx, 1
        int 0x80

        ;Exit
    ext:
        mov eax, 1
        mov ebx, 0
        int 0x80

section .data
    msg db 'La tecla fue ', 0x0D, 0x0A
    len equ $-msg

section .bss

    key resb 1

    termios:
        c_iflag resd 1 ;Input Mode Flags
        c_oflag resd 1 ;Output Mode Flags
        c_cflag resd 1 ;Control Mode Flags
        c_lflag resd 1 ;Local Mode Flags
        c_line  resb 1 ;Line Discipline
        c_cc    resb 19 ; Control Characters

