%define SYS_READ 0
%define SYS_OPEN 2
%define SYS_WRITE 1
%define SYS_CLOSE 3
%define STDOUT 1

;//////////////////////////////////////////////////////////////


section .bss
  resultado resb 32
  modelo           resd  32  ; reservar bytes




### despues de cada tipo de instruccion hay que llamar a la macro:
## add(ejemplo):
## impr_texto cons_Add,tamano_Add
## call imprimir_registros 



section	.data

resultadostxt: db 'resultados.txt',0


cons_add: db 'Ejecutando instruccion Add '
tamano_add: equ $-cons_add

cons_addi: db 'Ejecutando instruccion Addi '
tamano_addi: equ $-cons_addi

cons_addu: db 'Ejecutando instruccion Addu '
tamano_addu: equ $-cons_addu

cons_and: db 'Ejecutando instruccion And '
tamano_and: equ $-cons_and

cons_andi: db 'Ejecutando instruccion Andi '
tamano_andi: equ $-cons_andi

cons_beq: db 'Ejecutando instruccion Beq '
tamano_beq: equ $-cons_beq

cons_bne: db 'Ejecutando instruccion Bne '
tamano_bne: equ $-cons_bne

cons_j: db 'Ejecutando instruccion J '
tamano_j: equ $-cons_j

cons_jal: db 'Ejecutando instruccion Jal '
tamano_jal: equ $-cons_jal

cons_jr: db 'Ejecutando instruccion Jr '
tamano_jr: equ $-cons_jr

cons_lw: db 'Ejecutando instruccion Lw '
tamano_lw: equ $-cons_lw

cons_nor: db 'Ejecutando instruccion Nor '
tamano_nor: equ $-cons_nor

cons_or: db 'Ejecutando instruccion Or '
tamano_or: equ $-cons_or

cons_ori: db 'Ejecutando instruccion Ori '
tamano_ori: equ $-cons_ori

cons_slt: db 'Ejecutando instruccion Slt '
tamano_slt: equ $-cons_slt

cons_slti: db 'Ejecutando instruccion Slti '
tamano_slti: equ $-cons_slti

cons_sltiu: db 'Ejecutando instruccion Sltiu '
tamano_sltiu: equ $-cons_sltiu

cons_sltu: db 'Ejecutando instruccion Sltu '
tamano_sltu: equ $-cons_sltu

cons_sll: db 'Ejecutando instruccion Sll '
tamano_sll: equ $-cons_sll

cons_srl: db 'Ejecutando instruccion Srl '
tamano_srl: equ $-cons_srl

cons_sub: db 'Ejecutando instruccion Sub '
tamano_sub: equ $-cons_sub

cons_subu: db 'Ejecutando instruccion Subu '
tamano_subu: equ $-cons_subu

cons_mult: db 'Ejecutando instruccion Mult '
tamano_mult: equ $-cons_mult



;///registros

cons_s0: db '$s0 '
tamano_s0: equ $-cons_s0

cons_s1: db '$s1 '
tamano_s1: equ $-cons_s1

cons_s2: db '$s2 '
tamano_s2: equ $-cons_s2

cons_s3: db '$s3 '
tamano_s3: equ $-cons_s3

cons_s4: db '$s4 '
tamano_s4: equ $-cons_s4

cons_s5: db '$s5 '
tamano_s5: equ $-cons_s5

cons_s6: db '$s6 '
tamano_s6: equ $-cons_s6

cons_s7: db '$s7 '
tamano_s7: equ $-cons_s7

cons_sp: db '$sp '
tamano_sp: equ $-cons_sp

cons_a0: db '$a0 '
tamano_a0: equ $-cons_a0

cons_a1: db '$a1 '
tamano_a1: equ $-cons_a1

cons_a2: db '$a2 '
tamano_a2: equ $-cons_a2

cons_a3: db '$a3 '
tamano_a3: equ $-cons_a3

cons_v0: db '$v0 '
tamano_v0: equ $-cons_v0

cons_v1: db '$v1 '
tamano_v1: equ $-cons_v1

cons_espacio: db '   ',0xa
tamano_espacio: equ $-cons_espacio



///////////////////////////////////////////// Macros


%macro impr_texto 2 	;recibe 2 parametros
	mov rax,1	;sys_write
	mov rdi,1	;std_out
	mov rsi,%1	;primer parametro: Texto
	mov rdx,%2	;segundo parametro: Tamano texto
	syscall
	

/////////////////////////////////  para pasar al .txt   (misma forma de impr texto)
	mov rax,1	;sys_write
	mov rdi,[resultado]	;std_out
	mov rsi,%1	;primer parametro: Texto
	mov rdx,%2	;segundo parametro: Tamano texto
	syscall

%endmacro

%macro limpiar_pantalla 2 	;recibe 2 parametros
	mov rax,1	;sys_write
	mov rdi,1	;std_out
	mov rsi,%1	;primer parametro: caracteres especiales para limpiar la pantalla
	mov rdx,%2	;segundo parametro: Tamano 
	syscall
%endmacro





;;///////////////////////////////////Comparar
;;////////////////////////////////  Rd


impr_rd:
	;; ocupamos comparar Rd a ver a que registro iria el dato

	cmp r#,#
	je s0_rd
	cmp r#,#
	je s1_rd
	cmp r#,#
	je s2_rd
	cmp r#,#
	je s3_rd
	cmp r#,#
	je s4_rd
	cmp r#,#
	je s5_rd
	cmp r#,#
	je s6_rd
	cmp r#,#
	je s7_rd
	cmp r#,#
	je sp_rd
	cmp r#,#
	je a0_rd
	cmp r#,#
	je a1_rd
	cmp r#,#
	je a2_rd
	cmp r#,#
	je a3_rd
	cmp r#,#
	je v0_rd
	cmp r#,#
	je v1_rd
	jmp _finalizar ###### hay que hacer el modulo de salir, no se si ya hay uno 




s0_rd:
	impr_texto cons_s0,tamano_s0
	jmp impr_rs
s1_rd:
	impr_texto cons_s1,tamano_s1
	jmp impr_rs
s2_rd:
	impr_texto cons_s2,tamano_s2
	jmp impr_rs
s3_rd:
	impr_texto cons_s3,tamano_s3
	jmp impr_rs
s4_rd:
	impr_texto cons_s4,tamano_s4
	jmp impr_rs
s5_rd:
	impr_texto cons_s5,tamano_s5
	jmp impr_rs
s6_rd:
	impr_texto cons_s6,tamano_s6
	jmp impr_rs
s7_rd:
	impr_texto cons_s7,tamano_s7
	jmp impr_rs
sp_rd:
	impr_texto cons_sp,tamano_sp
	jmp impr_rs	
a0_rd:
	impr_texto cons_a0,tamano_a0
	jmp impr_rs
a1_rd:
	impr_texto cons_a1,tamano_a1
	jmp impr_rs
a2_rd:
	impr_texto cons_a2,tamano_a2
	jmp impr_rs
a3_rd:
	impr_texto cons_a3,tamano_a3
	jmp impr_rs	
v0_rd:
	impr_texto cons_v0,tamano_v0
	jmp impr_rs
v1_rd:
	impr_texto cons_v1,tamano_v1
	jmp impr_rs




	;;////////////////////////////////// Rs



impr_rs:
	;; ocupamos comparar Rd a ver a que registro iria el dato

	cmp r#,#
	je s0_rs
	cmp r#,#
	je s1_rs
	cmp r#,#
	je s2_rs
	cmp r#,#
	je s3_rs
	cmp r#,#
	je s4_rs
	cmp r#,#
	je s5_rs
	cmp r#,#
	je s6_rs
	cmp r#,#
	je s7_rs
	cmp r#,#
	je sp_rs
	cmp r#,#
	je a0_rs
	cmp r#,#
	je a1_rs
	cmp r#,#
	je a2_rs
	cmp r#,#
	je a3_rs
	cmp r#,#
	je v0_rs
	cmp r#,#
	je v1_rs
	jmp _finalizar ###### hay que hacer el modulo de salir, no se si ya hay uno 




s0_rs:
	impr_texto cons_s0,tamano_s0
	jmp impr_rt
s1_rs:
	impr_texto cons_s1,tamano_s1
	jmp impr_rt
s2_rs:
	impr_texto cons_s2,tamano_s2
	jmp impr_rt
s3_rs:
	impr_texto cons_s3,tamano_s3
	jmp impr_rt
s4_rs:
	impr_texto cons_s4,tamano_s4
	jmp impr_rt
s5_rs:
	impr_texto cons_s5,tamano_s5
	jmp impr_rt
s6_rs:
	impr_texto cons_s6,tamano_s6
	jmp impr_rt
s7_rs:
	impr_texto cons_s7,tamano_s7
	jmp impr_rt
sp_rs:
	impr_texto cons_sp,tamano_sp
	jmp impr_rt	
a0_rs:
	impr_texto cons_a0,tamano_a0
	jmp impr_rt
a1_rs:
	impr_texto cons_a1,tamano_a1
	jmp impr_rt
a2_rs:
	impr_texto cons_a2,tamano_a2
	jmp impr_rt
a3_rs:
	impr_texto cons_a3,tamano_a3
	jmp impr_rt
v0_rs:
	impr_texto cons_v0,tamano_v0
	jmp impr_rt
v1_rs:
	impr_texto cons_v1,tamano_v1
	jmp impr_rt


	;; //////////////////////////////////// Rt


impr_rt:
	;; ocupamos comparar Rd a ver a que registro iria el dato

;###  aqui hay que meter los registros de comparacion, em impr_rt se compara para ver a cual registro se le tiene que hacer el print

	cmp r#,#
	je s0_rt
	cmp r#,#
	je s1_rt
	cmp r#,#
	je s2_rt
	cmp r#,#
	je s3_rt
	cmp r#,#
	je s4_rt
	cmp r#,#
	je s5_rt
	cmp r#,#
	je s6_rt
	cmp r#,#
	je s7_rt
	cmp r#,#
	je sp_rt
	cmp r#,#
	je a0_rt
	cmp r#,#
	je a1_rt
	cmp r#,#
	je a2_rt
	cmp r#,#
	je a3_rt
	cmp r#,#
	je v0_rt
	cmp r#,#
	je v1_rt
	jmp _finalizar ###### hay que hacer el modulo de salir, no se si ya hay uno 



s0_rt:
	impr_texto cons_s0,tamano_s0
	jmp espacio
s1_rt:
	impr_texto cons_s1,tamano_s1
	jmp espacio
s2_rt:
	impr_texto cons_s2,tamano_s2
	jmp espacio
s3_rt:
	impr_texto cons_s3,tamano_s3
	jmp espacio
s4_rt:
	impr_texto cons_s4,tamano_s4
	jmp espacio
s5_rt:
	impr_texto cons_s5,tamano_s5
	jmp espacio
s6_rt:
	impr_texto cons_s6,tamano_s6
	jmp espacio
s7_rt:
	impr_texto cons_s7,tamano_s7
	jmp espacio
sp_rt:
	impr_texto cons_sp,tamano_sp
	jmp espacio
a0_rt:
	impr_texto cons_a0,tamano_a0
	jmp espacio
a1_rt:
	impr_texto cons_a1,tamano_a1
	jmp espacio
a2_rt:
	impr_texto cons_a2,tamano_a2
	jmp espacio
a3_rt:
	impr_texto cons_a3,tamano_a3
	jmp espacio
v0_rt:
	impr_texto cons_v0,tamano_v0
	jmp espacio
v1_rt:
	impr_texto cons_v1,tamano_v1
	jmp espacio


;;//////// variable
imprimir_registros:
	cmp r#,#
	je impr_rd
	cmp r#,#
	je impr_rs
	cmp r#,#
	je impr_rt


espacio:
	impr_texto cons_espacio,tamano_espacio
	ret
	
  
;;///////////////////////////////////////////////// para imprimir 
;;/////////////////  .txt resultados


section	.text
   global _start        

  

_start:

	; abrir el archivo
    mov rax, 2
    mov rdi, resultadostxt
    mov rsi,1
    mov rdx,0777
    syscall	
    mov [resultado] ,rax


	;Cerrar el archivo
    mov rax, 3
    mov rdi, [resultado]
    syscall
	
        ;puntero
    mov rax, SYS_CLOSE
    mov rdi, puntero
    syscall



        




