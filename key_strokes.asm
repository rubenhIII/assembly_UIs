GLOBAL main

section .text

    main:
        
        ;Termios
        mov eax, 0x36
        mov ebx, 0
        mov ecx, 0x5401
        mov edx, termios
        int 0x80

        mov eax, [c_lflag]
        mov [lflag], eax
        and byte [c_lflag], 0xFD
        and byte [c_lflag], 0xF7

        
    ext:

        mov eax, [lflag]
        mov [c_lflag], eax
        mov eax, 0x36
        mov ebx, 0
        mov ecx, 0x5402
        mov edx, termios
        int 0x80

        mov eax, 1
        mov ebx, 0
        int 0x80

section .data
    msg db 'La tecla fue ', 0x0D, 0x0A
    len equ $-msg

section .bss

    key resb 1
    lflag resd 1

    termios:
        c_iflag resd 1 ;Input Mode Flags
        c_oflag resd 1 ;Output Mode Flags
        c_cflag resd 1 ;Control Mode Flags
        c_lflag resd 1 ;Local Mode Flags
        c_line  resb 1 ;Line Discipline
        c_cc    resb 19 ;Control Characters

    file_stat:
        dev_t   resd 1     ;         /* ID of device containing file */
        ino_t   resq 1     ;         /* Inode number */
        mode_t  resw 1    ;        /* File type and mode */
        nlink_t resd 1   ;       /* Number of hard links */
        uid_t   resd 1     ;         /* User ID of owner */
        gid_t   resd 1     ;         /* Group ID of owner */
        rdev_t   resd 1     ;        /* Device ID (if special file) */
        off_t   resq 1     ;        /* Total size, in bytes */
        blksize_t   resd 1 ;     /* Block size for filesystem I/O */
        blkcnt_t    resq 1  ;  

