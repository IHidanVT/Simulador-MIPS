
; pop ebx ;extrae "argc"
; pop ebx ;extrae argv[0]
; pop ebx ;extrae arg1
; mov eax, 5
; mov ecx, 0
; int 0x80

; test eax,eax ;comprobar si devuelve error o el descriptor
; jns leer_del_fichero

; hubo_error:
; 	mov ebx,eax ;salir al SO devolviendo el código de error
; 	mov eax,1
; 	int 0x80
; leer_del_fichero:
; 	mov ebx,eax ;no hubo error=>devuelve el descriptor de fich
; 	mov eax,3 ;función para sys_read()
; 	mov ecx,buffer ;variable donde guardaremos lo leido del fich
; 	mov edx,tamano ;tamaño de lectura
; 	int 0x80
; 	js hubo_error

; mostrar_por_pantalla:
; 	mov edx,eax 	;longitud de la cadena a escribir
; 	mov eax,4 ;función sys_write()
; 	mov ebx,1 ;descriptor de STDOUT
; 	int 0x80

section .text
	global _start

_start:
	pop eax ;se extrae el contador de argumentos
	pop ebx ;extrae el nombre del programa
	pop ecx ;se extraen los argumetos
	mov $a0, ecx
	pop ecx
	mov $a1, ecx
	pop ecx
	mov $a2, ecx
	pop ecx
	mov $a3, ecx
	test ecx, ecx ;se comprueba si se llegó a NULL