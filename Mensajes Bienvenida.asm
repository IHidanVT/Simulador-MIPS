;---------------------------------------------
;Mensajes de bienvenida del emulador
;--------------------------------------------

;Se declaran los mensajes iniciales que se mostraran en la pantalla inicial y
;la longitud de cada mensaje
section .data 
	msj_ini: db 'Bienvenido al Emulador MIPS',0xa 
	len_msj_ini: equ $-msj_ini
	msj_curso: db 'EL-4313-Lab. Estructura de Microprocesadores', 0xa
	len_msj_curso: equ $-msj_curso
	msj_sem: db '1S-2017', 0xa
	len_msj_sem: equ $-msj_sem
	msj_archi: db 'Buscando archivo ROM.txt ...', 0xa
	len_msj_archi: equ $-msj_archi
	
	texto: db "./ROM.txt", 0
	len equ 1024

	msj_found: db 'Archivo ROM.txt encontrado'
	len_msj_found: equ $-msj_found
	msj_nofound: db 'Archivo ROM.txt no encontrado'
	len_msj_nofound: equ $-msj_nofound

	tecla: db '' ;se almacena tecla capturada
	termios: times 36 db 0 ;modo de operacion de la consola
	stdin: equ 0
	ICANON: equ 1<<1
	ECHO: equ 1<<3

	canonical_on:

	;Se llama a la funcion que lee el estado actual del TERMIOS en STDIN
	;TERMIOS son los parametros de configuracion que usa Linux para STDIN
        call read_stdin_termios

        ;Se escribe el nuevo valor de modo Canonico
        or dword [termios+12], ICANON

	;Se escribe la nueva configuracion de TERMIOS
        call write_stdin_termios
        ret
        ;Final de la funcion

read_stdin_termios:
        push rax
        push rbx
        push rcx
        push rdx

        mov eax, 36h
        mov ebx, stdin
        mov ecx, 5401h
        mov edx, termios
        int 80h

        pop rdx
        pop rcx
        pop rbx
        pop rax
        ret
        ;Final de la funcion
 write_stdin_termios:
        push rax
        push rbx
        push rcx
        push rdx

        mov eax, 36h
        mov ebx, stdin
        mov ecx, 5402h
        mov edx, termios
        int 80h

        pop rdx
        pop rcx
        pop rbx
        pop rax
        ret
        ;Final de la funcion
section .bss
	buffer: resb 1024

;Segmento de código para mostrar los mensajes en pantalla:
section .text 
	global _start

_start:
	mov rax, 1
	mov rdi, 1
	mov rsi, msj_ini
 	mov rdx, len_msj_ini
	syscall
	mov rax, 60
	mov rdi, 0

	mov rax, 1
	mov rdi, 1
    mov rsi, msj_curso
    mov rdx, len_msj_curso
    syscall
    mov rax, 60
    mov rdi, 0
	
	mov rax, 1
    mov rdi, 1
    mov rsi, msj_sem
    mov rdx, len_msj_sem
    syscall
    mov rax, 60
	mov rdi, 0
	
	mov rax, 1
    mov rdi, 1
    mov rsi, msj_archi
    mov rdx, len_msj_archi
    syscall
    mov rax, 60
    mov rdi, 0

	mov ebx, texto
	mov eax, 5
	mov ecx, 0
	int 80h
	test eax, eax
	jns si_txt
	js no_txt
	
	si_txt:
		mov ebx, texto
		mov eax, 5
		mov ecx, 0
		int 80h
		mov rax, 1
	    mov rdi, 1
	    mov rsi, msj_found
	    mov rdx, len_msj_found
	    syscall
	    mov rax, 60
	    mov rdi, 0
	    ;syscall
	    jmp captura_tecla

	no_txt:
		mov rax, 1
	    mov rdi, 1
	    mov rsi, msj_nofound
	    mov rdx, len_msj_nofound
	    syscall
	    mov rax, 60
	    mov rdi, 0
	    ;syscall
	    jmp captura_tecla 

	captura_tecla:
		mov rax,0							;rax = "sys_read"
		mov rdi,0							;rdi = 0 (standard input = teclado)
		mov rsi,tecla 					;rsi = direccion de memoria donde se almacena la tecla capturada
		mov rdx,1							;rdx=1 (cuantos eventos o teclazos capturar)
		syscall	

		call canonical_on
		mov rax,60				;se carga la llamada 60d (sys_exit) en rax
		mov rdi,0					;en rdi se carga un 0
		syscall						;se llama al sistema.