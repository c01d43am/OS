BITS 16        ; Tell the assembler we're using 16-bit mode
ORG 0x7C00     ; BIOS loads bootloader here

start:
    mov si, welcome_msg  ; Load the address of the welcome message into SI

print_loop:
    lodsb                ; Load the next byte from SI into AL
    cmp al, 0            ; Check if the byte is 0 (end of string)
    je done              ; If it is, jump to done
    mov ah, 0x0E         ; BIOS function to print characters
    int 0x10             ; Call BIOS interrupt
    jmp print_loop       ; Repeat the loop

done:
    jmp $                ; Infinite loop to halt execution

welcome_msg db 'Welcome to my OS', 0  ; The welcome message string

times 510 - ($ - $$) db 0  ; Fill remaining space with zeros
dw 0xAA55         ; Boot signature (required)