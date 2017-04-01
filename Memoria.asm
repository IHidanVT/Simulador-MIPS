;-------------------------------------------------
;Código de la memoria de datos del procesador MIPS
;-------------------------------------------------


section .bss
         memory: resw 100 ; se reserva doble palabra (32 bits) en memoria

section .text
        global _start
_start:
        ;memory resb 16; se reserva 16 bytes en memoria
        mov r8,0 ;se agrega el valor de 0 al registro r8
        mov r9,1; se agrega el valor de 1 al registro r9
        cmp r8, bandera ;compara si se tiene un '0' de la bandera
        je rd_memory ;si es '0' se lee en memoria
        cmp r9, bandera ;compara si se tiene un '1' en la bandera
        je wr_memory ;si es '1' se escribe en memoria

wr_memory: ;escritura en memoria
        mov rax, $reg_alu; se carga la direccion de memoria a rax
        mov rbx,[$reg_read2] ;se carga el dato de la unidad de registro a rbx
        mov rax, rbx
        mov DWORD [memory], rax
        ;mov DWORD [memory], rbx; se carga el dato a memory

        ;mov $r1, [memory] ;se mueve al reg 1 el dato en memory, cumple la func$
                          ;de "read data" que es una entrada al mux

rd_memory: ;lectura en memoria
        mov rax, $reg_alu ;se carga la dirección de memoria
        mov rbx, [$reg_read2] ;se carga el dato en rbx
        mov DWORD [memory], rbx ;se carga el dato a memory
        mov rdx, [memory] ;se mueve a rdx el dato en memory, cumple la función de "read data" (entrada al mux)


