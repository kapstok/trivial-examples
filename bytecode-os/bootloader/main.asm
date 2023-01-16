; Te compileren met NASM: nasm -f bin -o allersmaboot.bin main.asm
; Gespiekt vanaf https://wiki.osdev.org/Babystep4
; TODO: na deze code gecombineerd te hebben met implementatie op master, https://wiki.osdev.org/Babystep5
; NOTE TO SELF: enter is eigenlijk (\r = 10 met \n = 13) 
BITS 16

start:
       ; Define Stack Space
       mov ax, 07C0h   ; De initial location van deze bootloader (ax = 0x7C00 / BITS).
       add ax, 20h     ; Einde bootloader data (ds).
       mov ss, ax      ; ss = Stack Space Location. Hier begint de stack.
       mov sp, 4096    ; Stack Pointer. Werkt achterstevoren; begint dus bij einde.

       ; Define Data Space
       mov ax, 07C0h
       mov ds, ax      ; ds = Data Space Location. Hier begint de data.

       cld

       mov ax, 0xb800
       mov es, ax

       ; Print string
       mov si, message ; si = Source Index register.
       call sprint
       cli             ; Disable External interrupts
       hlt             ; Halt CPU.

;start:
;[ORG 0x7c00]      ; add to offsets
;   	xor ax, ax    ; make it zero
;   	mov ds, ax   ; DS=0
;   	mov ss, ax   ; stack starts at 0
;   	mov sp, 0x9c00   ; 2000h past code start;
;
;   	cld
;
;   	mov ax, 0xb800   ; text video memory
;   	mov es, ax
;
;   	mov si, message   ; show text string
;	call sprint
;
;	mov ax, 0xb800   ; look at video mem
;   	mov gs, ax
;  	mov bx, 0x0000   ; 'W'=57 attrib=0F
;   	mov ax, [gs:bx]
;
;   	mov  word [reg16], ax ;look at register
;   	call printreg16
;
;hang:
;	jmp hang

data:
    message db 'Jootloader booted.',0
    nlmsg db 'Pressed ', 39, 'a', 39, '!',0
    xpos db 0
    ypos db 0

sprint:
   lodsb      ; string char to AL
   cmp al, 0
   jne cprint   ; else, we're done
   add byte [ypos], 1   ;down one row
   mov byte [xpos], 0   ;back to left
   ret

cprint:
   mov ah, 0x0F   ; attrib = white on black
   mov cx, ax    ; save char/attribute
   movzx ax, byte [ypos]
   mov dx, 160   ; 2 bytes (char/attrib)
   mul dx      ; for 80 columns
   movzx bx, byte [xpos]
   shl bx, 1    ; times 2 to skip attrib

   mov di, 0        ; start of video memory
   add di, ax      ; add y offset
   add di, bx      ; add x offset

   mov ax, cx        ; restore char/attribute
   stosw              ; write char/attribute
   add byte [xpos], 1  ; advance to right

   jmp sprint

;printreg16:
;   mov di, outstr16
;   mov ax, [reg16]
;   mov si, hexstr
;   mov cx, 4   ;four places
;hexloop:
;   rol ax, 4   ;leftmost will
;   mov bx, ax   ; become
;   and bx, 0x0f   ; rightmost
;   mov bl, [si + bx];index into hexstr
;   mov [di], bl
;   inc di
;   dec cx
;   jnz hexloop
;
;   mov si, outstr16
;   call sprint
;
;   ret
;
;hexstr   db '0123456789ABCDEF'
;outstr16   db '0000', 0  ;register value string
;reg16   dw    0  ; pass values to printreg16
;message db 'Jootloader booted.',0
;nlmsg db 'Pressed ', 39, 'a', 39, '!',0
;xpos db 0
;ypos db 0

times 510-($-$$) db 0	; Fill 510 bytes with this bootloader.
dw 0xAA55		; Bootloader signature: EOF & Geeft aan dat dit een bootloader is.
