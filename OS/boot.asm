[BITS 16]
[ORG 0x7C00]   ; Boot sector memory location

mov ah, 0x0E  ; BIOS teletype output
mov al, 'H'
int 0x10      ; Print 'H'
mov al, 'i'
int 0x10      ; Print 'i'

jmp $         ; Infinite loop to stop execution

times 510-($-$$) db 0  ; Fill with zeroes until 510 bytes
dw 0xAA55      ; Boot signature
