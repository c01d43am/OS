[BITS 16]        ; Real mode
[ORG 0x7C00]     ; BIOS loads bootloader here

start:
    ; Print "Loading Kernel..."
    mov si, loading_msg
    call print_string

    ; Load kernel (LBA mode, assuming kernel.bin is at sector 2+)
    mov ah, 0x02    ; BIOS read sectors function
    mov al, 10      ; Number of sectors to read
    mov ch, 0       ; Cylinder 0
    mov cl, 2       ; Start at sector 2
    mov dh, 0       ; Head 0
    mov dl, 0x80    ; First hard drive
    mov bx, 0x1000  ; Load kernel to 0x1000:0000
    int 0x13        ; BIOS disk interrupt

    jc disk_error   ; Jump if read error

    ; Switch to 32-bit mode
    cli
    lgdt [gdt_descriptor]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp CODE_SEG:init_32

disk_error:
    hlt

print_string:
    lodsb
    or al, al
    jz done
    mov ah, 0x0E
    int 0x10
    jmp print_string
done:
    ret

[BITS 32]
init_32:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov esp, 0x90000   ; Stack pointer
    call KERNEL_ENTRY  ; Jump to kernel

    hlt

loading_msg db "Loading Kernel...", 0
gdt_descriptor:
    dw 0xFFFF, 0, 0x9A, 0xCF  ; Code segment
    dw 0xFFFF, 0, 0x92, 0xCF  ; Data segment

CODE_SEG equ 0x08
DATA_SEG equ 0x10
KERNEL_ENTRY equ 0x1000

times 510 - ($-$$) db 0
dw 0xAA55