SECTION .data		; initial vars

msg:	db "Dit is een test",10
len:	equ $-msg

SECTION .text		; code

global main
main:
	mov	edx, len
	mov	ecx, msg
	mov	ebx, 1
	mov	eax, 4

	int	0x80
	mov	ebx, 0
	mov	eax, 1
	int	0x80
