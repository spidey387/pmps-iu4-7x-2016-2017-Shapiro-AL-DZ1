;Дан массив из 50 знаковых 8-разрядных чисел, расположенных в памяти, начиная с адреса 0x20000200. 
;Реализовать алгоритм сортировки массива по возрастанию методом сортировки выбором. 
STACK_TOP 	 EQU	 0x20000100
ARRAY_BEGIN	 EQU	 0x20000200
ARRAY_SIZE	 EQU	 50
	
	PRESERVE8							; 8-битное выравнивание стека
	THUMB								; Режим Thumb (AUL) инструкций ARM instructions are 32 bits wide. Thumb instructions are 16 or 32-bits wide. ARMv4T and later define a 16-bit instruction set called Thumb 
	
	GET	stm32f10x.s	
	
	AREA RESET, CODE, READONLY			; The AREA directive instructs the assembler to assemble a new code or data section 
	
	DCD STACK_TOP						; Указатель на вершину стека // Стек необходим для сохранения контекста при вызове функций, передачи параметров функций и так далее
	DCD Reset_Handler					; Вектор сброса

	ENTRY								; Точка входа в программу
Reset_Handler	PROC					; Вектор сброса //The FUNCTION directive marks the start of a function. PROC is a synonym for FUNCTION
	EXPORT  Reset_Handler				; Делаем Reset_Handler видимым вне этого файла
main
	MOV32	R1, #ARRAY_BEGIN
	MOV		R2, #ARRAY_SIZE
sortirivka
	MOV		R3, R2
	LDR		R4, [R1]
	MOV		R6, #0
	ADD		R6, R1
obmen
	ADDS	R1, #1
	LDR		R5, [R1]
	CMP		R4, R5
	IT		GT	
	BLGT		min
	SUBS	R3, #1
	IT		NE
	BNE		obmen
	SUBS	R1, R2
	LDR		R5, [R1]
	STR		R5, [R6]
	STR		R4, [R1]
	ADDS	R1, #1
	SUBS	R2, #1
	IT		NE
	BNE		sortirivka
	
	ENDP
	
min			PROC
	MOV		R6, #0
	ADD		R6, R1
	MOV		R4, R5
	BX		LR
	ENDP

	END
