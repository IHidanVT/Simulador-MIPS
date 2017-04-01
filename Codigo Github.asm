;macros para lectura de archivo.
%macro ASCIIaENTERO 1
	and %1, 11111111b ;Guardar los ultimos 8 bits
	cmp %1, 96

	ja %%elseL1
	sub %1, 48
	jmp %%end

	%%elseL1:
	sub %1, 87
	%%end:
	
%endmacro

%macro HexMemoria 3
	shl %1, 4
	add %1, %2
	mov [trama + %3], %1
%endmacro

;declaración de constantes.
OPCODER equ 0 ; 0 H
OC_ADDI equ 8 ; 8 H
OC_ANDI equ 12 ;C H
OC_ORI equ 13 ;D H
OC_SLTI equ 10 ;A H
OC_SLTIU equ 11 ;B H
OC_BEQ equ 4 ;4 H
OC_BNE equ 5 ;5 H
OC_LW equ 35 ;23 H
OC_J equ 2 ;2 H
OC_JAL equ 3 ;3 H
f_add equ 32 ;20 H
f_addu equ 33 ;21 H
f_and equ 36 ;24 H
f_jr equ 8 ;8 H
f_nor equ 39 ;27 H
f_or equ 37 ;2 H
f_slt equ 42 ;2A H
f_sltu equ 43 ;2B H
f_sll equ 0 ;0 H
f_srl equ 2 ;2 H
f_sub equ 34 ;22 H
f_subu equ 35; 23 H

section .data

	file db "./ROM.txt", 0
	len equ 2048

section .bss 
;reserva de memoria para lectura de archivo y pc, memoria de instrucciones.
	buffer: resb 1048
	trama: resb 1
	restadir: resb 4
	pc: resb 4
	inst_inicial: resb 4
;reserva de memoria para señales de control y registros MIPS.
	reg_zero: resb 4
	reg_one: resb 4
	reg_two: resb 4
	reg_three: resb 4
	reg_four: resb 4
	reg_five: resb 4
	reg_six: resb 4
	reg_seven: resb 4
	reg_eight: resb 4
	reg_nine: resb 4
	reg_ten: resb 4
	reg_eleven: resb 4
	reg_twelve: resb 4
	reg_thirteen: resb 4
	reg_fourteen: resb 4
	reg_fifteen: resb 4
	reg_sixteen: resb 4
	reg_seventeen: resb 4
	reg_eighteen: resb 4
	reg_nineteen: resb 4
	reg_twenty: resb 4
	reg_twentyone: resb 4
	reg_twentytwo: resb 4
	reg_twentythree: resb 4
	reg_twentyfour: resb 4
	reg_twentyfive: resb 4
	reg_twentysix: resb 4
	reg_twentyseven: resb 4
	reg_twentyeight: resb 4
	reg_twentynine: resb 4
	reg_thirty: resb 4
	reg_thirtyone: resb 4

	reg_dst: resb 1
	jump: resb 1
	branch: resb 1
	memread: resb 1 ;equal to mem to reg
	alu_src: resb 1
	reg_write: resb 1
	alu_op: resb 1

section .text

global _start

_start:

;----------------ABRIR ARCHIVO---------------------

	mov ebx, file ; name of the file  
    	mov eax, 5  
    	mov ecx, 0  
    	int 80h     

    	mov eax, 3  
    	mov ebx, eax
    	mov ecx, buffer 
    	mov edx, len    
    	int 80h     

;-------Pasar de ascii a Entero
   
	mov r8, [buffer]
	mov rax, 0
	mov rbx, 0



loop1:

	add rax, 11 ; moverme los 11 lados

	mov r8, [buffer+rax]
    	ASCIIaENTERO r8
    	inc rax

	mov r9, [buffer+rax]
    	ASCIIaENTERO r9
    	inc rax

	mov r10, [buffer+rax]
    	ASCIIaENTERO r10
    	inc rax

	mov r11, [buffer+rax]
    	ASCIIaENTERO r11
    	inc rax

	mov r12, [buffer+rax]
    	ASCIIaENTERO r12
    	inc rax

	mov r13, [buffer+rax]
    	ASCIIaENTERO r13
    	inc rax

	mov r14, [buffer+rax]
    	ASCIIaENTERO r14
    	inc rax

	mov r15, [buffer+rax]
    	ASCIIaENTERO r15
    	inc rax


;------Guardar en Memoria------
	
	HexMemoria r14,r15,rbx
	inc rbx
	HexMemoria r12,r13,rbx
	inc rbx
	HexMemoria r10,r11,rbx
	inc rbx
	HexMemoria r8,r9,rbx
	inc rbx

loop2:

	mov r8, [buffer+rax]
	and r8, 11111111b

	cmp r8, 0
	je end

	cmp r8, 10
	je esEnter
	inc rax
	jmp loop2

	esEnter: ;nose si aqui van dos puntos
	inc rax
	mov r8, [buffer+rax]
	and r8, 11111111b
	cmp r8, 0
	je end
	cmp r8, 10
	je esEnter
	jmp loop1

end:

	mov eax, [trama]
	mov ebx, [trama+1]	

;PC
PC: 
	cmp r14, f_jr
	je jr_pccalc
	mov inst_inicial, trama + %3
	cmp inst_inicial, pc
	je reset
	cmp inst_inicial, pc
	jne jb_cuatro

jr_pccalc:
	mov pc, r10
	mov r8, [pc]

reset:
	mov r8, [trama + %3]
	mov pc, trama + % 3

jb_cuatro:
	mov r9, branch
	add r9, jump
	cmp r9, 0 
	je PC_cuatro
	cmp jump, 1
	je PCJ
	cmp branch, 1 
	je PCB
	
PC_cuatro:
	mov r15, [pc]
	add r15, 4
	mov pc, r15
	mov r8, [pc]
	jmp memint

PCJ:
	mov r15, [pc]
	shr r15, 28
	shl r15, 28
	movzx r10, r10
	shl r10, 2
	and r15, r10
	mov pc, r15
	mov r15, trama + %3
	sub r15, 0x00400000
	add pc, r15
	mov r8, [pc]

PCB:
	movsx r12, r12
	shl r12, 2
	mov r15, [pc]
	add r15, 4
	mov pc, r15
	add r15, r12
	mov pc r15
	mov r15, trama + %3
	sub r15, 0x00400000
	add pc, r15
	mov r8, [pc]
	jmp memint

memint:
	mov r9, r8
	shr r9, 26 ;1A H
	cmp r9, OPCODER
	je tipor
	cmp r9, OC_ADDI
	je tipoi
	cmp r9, OC_ANDI
	je tipoi
	cmp r9, OC_ORI
	je tipoi

tipor:
;rs
	mov r10, r8
	and r10, 65011712 ;03E00000 H
	shr r10, 21

;rt
	mov r11, r8
	and r11, 2031616 ;001F0000 H
	shr r11, 16

;rd
	mov r12, r8
	and r12, 63488 ;0000F800 H
	shr r12, 11

;shamt
	mov r13, r8
	and r13, 1984 ;000007C0 H
	shr r13, 6

;funct
	mov r14, r8
	and r14, 63 ;0000003F H	

	jmp regmemr
	jmp contsignr
	jmp alu_tipor

tipoi:
;rs
	mov r10, r8
	and r10, 65011712 ;03E00000 H
	shr r10, 21
;rt
	mov r11, r8
	and r11, 2031616 ;001F0000 H
	shr r11, 16

;imm
	mov r12, r8
	and r12, 65535 ;0000FFFF H
	
	jmp regmemi
	jmp contsignij
	jmp alu_tipoij
	jmp wb
	
tipoj:
;jumpaddr
	mov r10, r8
	and r10, 67108863 ;03FFFFFF H
	
	jmp contsignij
	jmp alu_tipoij
	jmp wb

contsignr:
	cmp r14, 32
	je add
	cmp r14, 33
	je addu
	cmp r14, 36
	je and
	cmp r14, 8
	je jr
	cmp r14, 39
	je nor
	cmp r14, 37
	je or
	cmp r14, 42
	je slt
	cmp r14, 43
	je sltu
	cmp r14, 0
	je sll
	cmp r14, 2
	je srl
	cmp r14, 22
	je sub
	cmp r14, 23
	je subu

contsignij:
	cmp r9, 8
	je addi
	cmp r9, 12
	je andi
	cmp r9, 13
	je ori
	cmp r9, 10
	je slti
	cmp r9, 11
	je sltiu
	cmp r9, 4
	je beq
	cmp r9, 5
	je bne
	cmp r9, 35
	je lw
	cmp r9, 2
	je j
	cmp r9, 3
	je jal

regmemr:	
	cmp r10, 0
	je zero

	cmp r10, 1
	je one

	cmp r10, 2
	je two

	cmp r10, 3
	je three

	cmp r10, 4
	je four

	cmp r10, 5
	je five

	cmp r10, 6
	je six

	cmp r10, 7
	je seven

	cmp r10, 8
	je eight

	cmp r10, 9
	je nine

	cmp r10, 10
	je ten

	cmp r10, 11
	je eleven

	cmp r10, 12
	je twelve

	cmp r10, 13
	je thirteen

	cmp r10, 14
	je fourteen

	cmp r10, 15
	je fifteen

	cmp r10, 16
	je sixteen

	cmp r10, 17
	je seventeen

	cmp r10, 18
	je eighteen

	cmp r10, 19
	je nineteen

	cmp r10, 20
	je twenty

	cmp r10, 21
	je twentyone

	cmp r10, 22
	je twentytwo

	cmp r10, 23
	je twentythree

	cmp r10, 24
	je twentyfour

	cmp r10, 25
	je twentyfive

	cmp r10, 26
	je twentysix

	cmp r10, 27
	je twentyseven

	cmp r10, 28
	je twentyeight

	cmp r10, 29
	je twentynine

	cmp r10, 30
	je thirty

	cmp r10, 31
	je thirtyone

	cmp r11, 0
	je zerot

	cmp r11, 1
	je onet

	cmp r11, 2
	je twot

	cmp r11, 3
	je threet

	cmp r11, 4
	je fourt

	cmp r11, 5
	je fivet

	cmp r11, 6
	je sixt

	cmp r11, 7
	je sevent

	cmp r11, 8
	je eightt

	cmp r11, 9
	je ninet

	cmp r11, 10
	je tent

	cmp r11, 11
	je elevent

	cmp r11, 12
	je twelvet

	cmp r11, 13
	je thirteent

	cmp r11, 14
	je fourteent

	cmp r11, 15
	je fifteent

	cmp r11, 16
	je sixteent

	cmp r11, 17
	je seventeent

	cmp r11, 18
	je eighteent

	cmp r11, 19
	je nineteent

	cmp r11, 20
	je twentyt

	cmp r11, 21
	je twentyonet

	cmp r11, 22
	je twentytwot

	cmp r11, 23
	je twentythreet

	cmp r11, 24
	je twentyfourt

	cmp r11, 25
	je twentyfivet

	cmp r11, 26
	je twentysixt

	cmp r11, 27
	je twentysevent

	cmp r11, 28
	je twentyeightt

	cmp r11, 29
	je twentyninet

	cmp r11, 30
	je thirtyt

	cmp r11, 31
	je thirtyonet

regmemi:
	cmp r10, 0
	je zero

	cmp r10, 1
	je one

	cmp r10, 2
	je two

	cmp r10, 3
	je three

	cmp r10, 4
	je four

	cmp r10, 5
	je five

	cmp r10, 6
	je six

	cmp r10, 7
	je seven

	cmp r10, 8
	je eight

	cmp r10, 9
	je nine

	cmp r10, 10
	je ten

	cmp r10, 11
	je eleven

	cmp r10, 12
	je twelve

	cmp r10, 13
	je thirteen

	cmp r10, 14
	je fourteen

	cmp r10, 15
	je fifteen

	cmp r10, 16
	je sixteen

	cmp r10, 17
	je seventeen

	cmp r10, 18
	je eighteen

	cmp r10, 19
	je nineteen

	cmp r10, 20
	je twenty

	cmp r10, 21
	je twentyone

	cmp r10, 22
	je twentytwo

	cmp r10, 23
	je twentythree

	cmp r10, 24
	je twentyfour

	cmp r10, 25
	je twentyfive

	cmp r10, 26
	je twentysix

	cmp r10, 27
	je twentyseven

	cmp r10, 28
	je twentyeight

	cmp r10, 29
	je twentynine

	cmp r10, 30
	je thirty

	cmp r10, 31
	je thirtyone

zero:
	mov r10, [reg_zero]

one:
	mov r10, [reg_one]

two:
	mov r10, [reg_two]

three:
	mov r10, [reg_three]

four:
	mov r10, [reg_four]

five:
	mov r10, [reg_five]

six:
	mov r10, [reg_six]

seven:
	mov r10, [reg_seven]

eight:
	mov r10, [reg_eight]

nine:
	mov r10, [reg_nine]

ten:
	mov r10, [reg_ten]

eleven:
	mov r10, [reg_eleven]

twelve:
	mov r10, [reg_twelve]

thirteen:
	mov r10, [reg_thirteen]

fourteen:
	mov r10, [reg_fourteen]

fifteen:
	mov r10, [reg_fifteen]

sixteen:
	mov r10, [reg_zero]

seventeen:
	mov r10, [reg_one]

eighteen:
	mov r10, [reg_two]

nineteen:
	mov r10, [reg_three]

twenty:
	mov r10, [reg_four]

twentyone:
	mov r10, [reg_five]

twentytwo:
	mov r10, [reg_six]

twentythree:
	mov r10, [reg_seven]

twentyfour:
	mov r10, [reg_eight]

twentyfive:
	mov r10, [reg_nine]

twentysix:
	mov r10, [reg_ten]

twentyseven:
	mov r10, [reg_eleven]

twentyeight:
	mov r10, [reg_twelve]

twentynine:
	mov r10, [reg_thirteen]

thirty:
	mov r10, [reg_fourteen]

thirtyone:
	mov r10, [reg_fifteen]

zerot:
	mov r11, [reg_zero]

onet:
	mov r11, [reg_one]

twot:
	mov r11, [reg_two]

threet:
	mov r11, [reg_three]

fourt:
	mov r11, [reg_four]

fivet:
	mov r11, [reg_five]

sixt:
	mov r11, [reg_six]

sevent:
	mov r11, [reg_seven]

eightt:
	mov r11, [reg_eight]

ninet:
	mov r11, [reg_nine]

tent:
	mov r11, [reg_ten]

elevent:
	mov r11, [reg_eleven]

twelvet:
	mov r11, [reg_twelve]

thirteent:
	mov r11, [reg_thirteen]

fourteent:
	mov r11, [reg_fourteen]

fifteent:
	mov r11, [reg_fifteen]

sixteent:
	mov r11, [reg_zero]

seventeent:
	mov r11, [reg_one]

eighteent:
	mov r11, [reg_two]

nineteent:
	mov r11, [reg_three]

twentyt:
	mov r11, [reg_four]

twentyonet:
	mov r11, [reg_five]

twentytwot:
	mov r11, [reg_six]

twentythreet:
	mov r11, [reg_seven]

twentyfourt:
	mov r11, [reg_eight]

twentyfivet:
	mov r11, [reg_nine]

twentysixt:
	mov r11, [reg_ten]

twentysevent:
	mov r11, [reg_eleven]

twentyeightt:
	mov r11, [reg_twelve]

twentyninet:
	mov r11, [reg_thirteen]

thirtyt:
	mov r11, [reg_fourteen]

thirtyonet:
	mov r11, [reg_fifteen]

addi:
	mov reg_dst, 0
	mov jump, 0
	mov branch, 0
	mov memread, 0
	mov alu_src, 1
	mov reg_write, 1
	mov alu_op, 2

andi:
	mov reg_dst, 0
	mov jump, 0
	mov branch, 0
	mov memread, 0
	mov alu_src, 1
	mov reg_write, 1
	mov alu_op, 2

ori:
	mov reg_dst, 0
	mov jump, 0
	mov branch, 0
	mov memread, 0
	mov alu_src, 1
	mov reg_write, 1
	mov alu_op, 2

slti:
	mov reg_dst, 0
	mov jump, 0
	mov branch, 0
	mov memread, 0
	mov alu_src, 1
	mov reg_write, 1
	mov alu_op, 2

sltiu:
	mov reg_dst, 0
	mov jump, 0
	mov branch, 0
	mov memread, 0
	mov alu_src, 1
	mov reg_write, 1
	mov alu_op, 2

beq:
	mov reg_dst, 1
	mov jump, 0
	mov branch, 1
	mov memread, 0
	mov alu_src, 0
	mov reg_write, 0
	mov alu_op, 1

bne:
	mov reg_dst, 1
	mov jump, 0
	mov branch, 1
	mov memread, 0
	mov alu_src, 0
	mov reg_write, 0
	mov alu_op, 1

lw:
	mov reg_dst, 0
	mov jump, 0
	mov branch, 0
	mov memread, 1
	mov alu_src, 0
	mov reg_write, 0
	mov alu_op, 0

j:
	mov reg_dst, 1
	mov jump, 1
	mov branch, 0
	mov memread, 0
	mov alu_src, 0
	mov reg_write, 0
	mov alu_op, 3

jal:
	mov reg_dst, 0
	mov jump, 1
	mov branch, 0
	mov memread, 0
	mov alu_src, 0
	mov reg_write, 1
	mov alu_op, 2

add:
	mov reg_dst, 1
	mov jump, 0
	mov branch, 0
	mov memread, 0
	mov alu_src, 0
	mov reg_write, 1
	mov alu_op, 2

addu:
	mov reg_dst, 1
	mov jump, 0
	mov branch, 0
	mov memread, 0
	mov alu_src, 0
	mov reg_write, 1
	mov alu_op, 2

and:
	mov reg_dst, 1
	mov jump, 0
	mov branch, 0
	mov memread, 0
	mov alu_src, 0
	mov reg_write, 1
	mov alu_op, 2

jr:
	mov reg_dst, 0
	mov jump, 1
	mov branch, 0
	mov memread, 0
	mov alu_src, 0
	mov reg_write, 0
	mov alu_op, 3

nor:
	mov reg_dst, 1
	mov jump, 0
	mov branch, 0
	mov memread, 0
	mov alu_src, 0
	mov reg_write, 1
	mov alu_op, 2

or:
	mov reg_dst, 1
	mov jump, 0
	mov branch, 0
	mov memread, 0
	mov alu_src, 0
	mov reg_write, 1
	mov alu_op, 2

slt:
	mov reg_dst, 1
	mov jump, 0
	mov branch, 0
	mov memread, 0
	mov alu_src, 0
	mov reg_write,  1
	mov alu_op, 2

sltu:
	mov reg_dst, 1
	mov jump, 0
	mov branch, 0
	mov memread, 0
	mov alu_src, 0
	mov reg_write, 1
	mov alu_op, 2

sll:
	mov reg_dst, 1
	mov jump, 0
	mov branch, 0
	mov memread, 0
	mov alu_src, 0
	mov reg_write, 1
	mov alu_op, 2

srl:
	mov reg_dst, 1
	mov jump, 0
	mov branch, 0
	mov memread, 0
	mov alu_src, 0
	mov reg_write, 1
	mov alu_op, 2

sub:
	mov reg_dst, 1
	mov jump, 0
	mov branch, 0
	mov memread, 0
	mov alu_src, 0
	mov reg_write, 1
	mov alu_op, 2

subu:
	mov reg_dst, 1
	mov jump, 0
	mov branch, 0
	mov memread, 0
	mov alu_src, 0
	mov reg_write, 1
	mov alu_op, 2

;ALU

alu_tipoij:                   
	cmp r9, OC_ADDI		; addi
	je addi_alu

	cmp r9, OC_ANDI 	; andi
	je andi_alu

	cmp r9, OC_ORI		; ori
	je ori_alu

	cmp r9, OC_SLTI		; slti
	je slti_alu

	cmp r9, OC_SLTIU	; sltiu
	je sltiu_alu

	cmp r9, OC_BEQ 		; beq
	je beq_alu

	cmp r9, OC_BNE 		; bne
	je bne_alu

	cmp r9, OC_LW		; lw
	je lw_alu

	cmp r9, OC_J		; j
	je j_alu

	cmp r9, OC_JAL 		; jal
	je jal_alu

;TIPO I o J

addi_alu:
	movsx r12, r12
	mov r11, r10
	add r11, r12

andi_alu:
	movzx r12, r12
	mov r11, r10
	and r11, r12

ori:
	movzx r12, r12
	mov r11, r10
	or r11, r12

slti_alu:
	movsx r12, r12
	cmp r10, r12
	jl save_one
	cmp r10, r12
	jnl save_zero

sltiu_alu:
	movsx r12, r12
	cmp r10, r12
	jb save_one
	cmp r10, r12
	jnb save_zero

save_one:
	mov r11, 1

save_zero:
	mov r11, 0	

beq_alu:
	cmp r10, r11
	je PC

bne_alu:
	cmp r10, r11
	jne PC

lw_alu:
	movsx r12, r12
	mov r11, r10
	add r11, r12
	jmp read_memory	

j_alu:
	jmp PC
	
jal_alu:
	mov reg_thirtyone, [pc]
	mov rax, reg_thirtyone
	add rax, 8
	mov reg_thirtyone, rax
	jmp PC		

alu_tipor:

	cmp r14, f_add ; add
	je add_alu

	cmp r14, f_addu ; addu
	je addu_alu

	cmp r14, f_and ; and
	je and_alu

	cmp r14, f_jr ; jr
	je jr_alu
	
	cmp r14, f_nor ; nor
	je nor_alu

	cmp r14, f_or ;or
	je or_alu

	cmp r14, f_slt ;slt
	je slt_alu

	cmp r14, f_sltu ;sltu
	je sltu_alu

	cmp r14, f_sll ;sll
	je sll_alu

	cmp r14, f_srl ;srl
	je srl_alu

	cmp r14, f_sub ;sub
	je sub_alu

	cmp r14, f_subu ;subu
	je subu_alu

add_alu:
	mov r12, r10
	add r12, r11

addu_alu: 
	mov r12, r10
	add r12, r11

and_alu:
	mov r12, r10
	and r12, r11

jr_alu:
	jmp PC

nor_alu:
	mov r12, r10
	or r12, r11
	not r12

or_alu:
	mov r12, r10
	or r12, r11

slt_alu: 
	cmp r10, r11
	jl save_one_r
	cmp r10, r11
	jnl save_zero_r

sltu_alu:
	cmp r10, r11
	jb save_one_r
	cmp r10, r11
	jnb save_zero_r

save_one_r:
	mov r12, 0

save_zero:r
	mov r12, 0

sll_alu:
	mov r12, r11
	shl r12, r13

srl_alu:
	mov r12, r11
	shr r12, r13

sub_alu:
	mov r12, r10
	sub r12, r11
    
subu_alu:
	mov r12, r10
	sub r12, r11

read_memory: ;lectura en memoria
        mov rax, r11 ;se carga la dirección de memoria
	mov r11, memory
	sub r11, 0x10000000
	mov mem_firstdir, r11
	mov r11, [mem_firstdir]

wb:
	lb rax, memread ;bandera
	lb rbx, r11 ;memoria
	cmp r9, OPCODER
	je r
	jne rt
	jmp guardadowb

rd:
	lb rcx, r12

rt:
	lb rcx, r11


#verificar memtoreg
guardadowb:
	cmp rax, 0
	je escriturareaddata
	jne escrituraalu


escrituraalu:
lb rcx, rbx      
b pc

escriturareaddata:
lb rcx, rax
b pc

_exit:
	mov eax, 1
	mov ebx, 0
	int 80h