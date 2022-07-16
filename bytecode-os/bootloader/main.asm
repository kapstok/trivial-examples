; Te compileren met NASM: nasm -f bin -o allersmaboot.bin main.asm
BITS 16

start:
	; Define Stack Space
	mov ax, 07C0h	; De initial location van deze bootloader (ax = 0x7C00 / BITS).
	add ax, 20h	; Einde bootloader data (ds).
	mov ss, ax	; ss = Stack Space Location. Hier begint de stack.
	mov sp, 4096	; Stack Pointer. Werkt achterstevoren; begint dus bij einde.

	; Define Data Space
	mov ax, 07C0h
	mov ds, ax	; ds = Data Space Location. Hier begint de data.

	; Print string
	mov si, message	; si = Source Index register.
	call print
	call read
	cli		; Disable External interrupts
	hlt		; Halt CPU.

data:
	message db 'Bootloader booted.',0

read:
	mov ah, 0h	; Get char
	int 16h		; puts(char)
	mov ah, 0Eh;call print	; display(char)
	int 10h		; echo char
	jmp read	; start over again.

print:
	mov ah, 0Eh

.printchar:
	lodsb		; Load byte from Source Index & increment it.
	cmp al, 0	; Compare al with NULL.
	je .done	; if(cmp al, 0) { .done; }
	int 10h		; puts(loaded_byte);
	jmp .printchar

.done:
	ret

times 510-($-$$) db 0	; Fill 510 bytes with this bootloader.
dw 0xAA55		; Bootloader signature: EOF & Geeft aan dat dit een bootloader is.
