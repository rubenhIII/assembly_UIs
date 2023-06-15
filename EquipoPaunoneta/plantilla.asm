extern _setup
extern _draw
extern _drawString
extern _createRectangle
extern check_key

; Variables globales
section .data
    snake_x dd 20
    snake_y dd 20
    snake_weight dd 10
    snake_height dd 10
    snake_length dd 3
    direction dd 1
    fruit_x dd 20, 370, 70, 400, 220, 100, 250
    fruit_y dd 150, 140, 320, 180, 400, 200, 250
    

section .bss
    snake_bodyx resd 10 ;Reservar espacio para el cuerpo de la serpiente (10 segmentos)
    snake_bodyy resd 10 ;Reservar espacio para el cuerpo de la serpiente (10 segmentos)    


; Comprobar si la serpiente ha chocado consigo misma o con los límites de la pantalla

; Código principal
section .text
    global main
    main:
        mov esi, 0

        mov edi, 0
        mov dword [snake_bodyx + edi*4], 80
        mov dword [snake_bodyy + edi*4], 50
        inc edi
        mov dword [snake_bodyx + edi*4], 90
        mov dword [snake_bodyy + edi*4], 50
        inc edi
        mov dword [snake_bodyx + edi*4], 100
        mov dword [snake_bodyy + edi*4], 50
        inc edi


        ; Inicializar el juego 
        call _setup

        game_loop:    

            mov edi, 0
            ;Genera fruta
            call generate_fruit

            ; Actualizar la dirección de la serpiente
            call handle_input 

            mov eax, dword[snake_bodyx + edi*4]
            mov ebx, dword[snake_bodyy + edi*4]
            ;Actualizar la posición de la cabeza
            call update_head

            ;Actualizar la posición de la serpiente
            mov edi, [snake_length]
            call update_snake_position

            mov edi, 1
            mov dword[snake_bodyx + edi*4], eax
            mov dword[snake_bodyy + edi*4], ebx

            ; Comprobar si la serpiente ha comido una fruta
            call check_fruit_collision

            ;Comprobar si la serpiente murio
            mov edi, 0
            mov eax, dword[snake_bodyx + edi*4]
            mov ebx, dword[snake_bodyy + edi*4]
            call check_wall_collition

            ; Dibujar la serpiente y las frutas en la pantalla
            mov edi, 0
            call pintar_serpiente

            cmp dword [snake_length], 10
            je final
            ; Continuar el bucle del juego
            jmp game_loop

        ; Generar una nueva fruta
        generate_fruit:
            ; Aquí puedes agregar la lógica para generar una nueva fruta en una posición aleatoria
            push dword [fruit_y + esi*4]
            push dword [fruit_x + esi*4]
            push esi
            call _createRectangle
            add esp, 12
            ;call _drawString
            call _draw

            ret


        handle_input:
            ; Esperar a una entrada del usuario
            call check_key
            ; Verificar la tecla presionada
            cmp eax, 115  ; 'w'
            je arriba
            cmp eax, 100 ; 'd'
            je derecha
            cmp eax, 119  ; 's'
            je abajo
            cmp eax, 97   ; 'a'
            je izquierda
            ret

        arriba:
            cmp dword [direction], 3
            je handle_input ; Ignorar si la serpiente se está moviendo hacia abajo
            mov dword [direction], 1
            ret

        derecha:
            cmp dword [direction], 4
            je handle_input ; Ignorar si la serpiente se está moviendo hacia la izquierda
            mov dword [direction], 2
            ret

        abajo:
            cmp dword [direction], 1
            je handle_input ; Ignorar si la serpiente se está moviendo hacia arriba
            mov dword [direction], 3
            ret

        izquierda:
            cmp dword [direction], 2
            je handle_input ; Ignorar si la serpiente se está moviendo hacia la derecha
            mov dword [direction], 4
            ret
            

        update_snake_position:
            cmp edi, 1
            je break_loop

            dec edi

            mov ecx, [snake_bodyx + edi*4]
            mov edx, [snake_bodyy + edi*4]

            inc edi
            
            mov [snake_bodyx + edi*4], ecx
            mov [snake_bodyy + edi*4], edx

            dec edi
            
            jmp update_snake_position
        break_loop:
            ret


        update_head:
            cmp dword [direction], 1
            je mueve_arriba

            cmp dword [direction], 2
            je mueve_derecha

            cmp dword [direction], 3
            je mueve_abajo

            cmp dword [direction], 4
            je mueve_izquierda

            call pintar_serpiente
            ret


        mueve_arriba:
            add dword [snake_bodyy + edi*4], 10
            ret

        mueve_derecha:
            add dword [snake_bodyx + edi*4], 10
            ret

        mueve_abajo:
            sub dword [snake_bodyy + edi*4], 10
            ret

        mueve_izquierda:
            sub dword [snake_bodyx + edi*4], 10
            ret

        pintar_serpiente:
            cmp edi, [snake_length]
            jge break_loop
            push dword [snake_bodyy + edi*4]
            push dword [snake_bodyx + edi*4]
            push edi

            call _createRectangle
            add esp, 12
            call _draw

            inc edi

            jmp pintar_serpiente


        check_wall_collition:
            cmp eax, -10
            je final

            cmp eax, 510
            je final

            cmp ebx, -10
            je final

            cmp ebx, 510
            je final

            ret




        ; Comprobar si la serpiente ha comido una fruta
        check_fruit_collision:
            mov edi, 0
            mov eax, [snake_bodyx + edi*4]
            cmp eax, [fruit_x + esi*4]
            jne no_collision
            mov eax, [snake_bodyy + edi*4]
            cmp eax, [fruit_y + esi*4]
            jne no_collision

            ;La serpiente ha comido una fruta
            inc esi
            inc dword [snake_length]
            call add_snake
            call generate_fruit
            ;Agregar nuevo elemento

        no_collision:
            ret



        add_snake:
            mov edi, 0
            mov eax, [snake_bodyx + edi*4]
            mov ebx, [snake_bodyy + edi*4]
            

            cmp dword [direction], 1
            je add_up

            cmp dword [direction], 2
            je add_right

            cmp dword [direction], 3
            je add_down

            cmp dword [direction], 4
            je add_left

            ret


            add_up:
                cmp [snake_length], edi
                je addy

                mov ecx, [snake_bodyx + edi*4]
                mov edx, [snake_bodyy + edi*4]
                inc edi
                mov [snake_bodyx + edi*4], ecx
                mov [snake_bodyy + edi*4], edx

                jmp add_up
            
            addy:
                add ebx, 10
                mov edi, 0
                mov [snake_bodyx + edi*4], eax
                mov [snake_bodyy + edi*4], ebx
                ret

            add_down:
                cmp [snake_length], edi
                je suby

                mov ecx, [snake_bodyx + edi*4]
                mov edx, [snake_bodyy + edi*4]
                inc edi
                mov [snake_bodyx + edi*4], ecx
                mov [snake_bodyy + edi*4], edx

                jmp add_up
            
            suby:
                sub ebx, 10
                mov edi, 0
                mov [snake_bodyx + edi*4], eax
                mov [snake_bodyy + edi*4], ebx
                ret

            add_right:
                cmp [snake_length], edi
                je addx

                mov ecx, [snake_bodyx + edi*4]
                mov edx, [snake_bodyy + edi*4]
                inc edi
                mov [snake_bodyx + edi*4], ecx
                mov [snake_bodyy + edi*4], edx

                jmp add_up
            
            addx:
                add eax, 10
                mov edi, 0
                mov [snake_bodyx + edi*4], eax
                mov [snake_bodyy + edi*4], ebx
                ret

            add_left:
                cmp [snake_length], edi
                je subx

                mov ecx, [snake_bodyx + edi*4]
                mov edx, [snake_bodyy + edi*4]
                inc edi
                mov [snake_bodyx + edi*4], ecx
                mov [snake_bodyy + edi*4], edx

                jmp add_up
            
            subx:
                sub eax, 10
                mov edi, 0
                mov [snake_bodyx + edi*4], eax
                mov [snake_bodyy + edi*4], ebx
                ret



            final:
                mov eax, 1
                mov ebx, 0
                int 0x80
                
                jmp final


                

