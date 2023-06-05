GLOBAL main
EXTERN check_key

section .data

section .bss
    c   resb    1

section .text
    main:
        CALL check_key
        mov [c], eax
        cmp eax, 0
        je main

        mov eax, 4
        mov ebx, 1
        mov ecx, c
        mov edx, 1
        int 0x80
    
    ext:
        mov eax, 1
        int 0x80
