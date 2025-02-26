[BITS 16]         ; We are in real mode
[ORG 0x7C00]      ; BIOS loads us at 0x7C00

start:
    ; Print "Loading Kernel..."
    mov si, loading_msg
    call print_string

    ; Load kernel from disk
    mov ah, 0x02        ; BIOS read function
    mov al, 10          ; Read 10 sectors
    mov ch, 0           ; Cylinder 0
    mov cl, 2           ; Start at sector 2
    mov dh, 0           ; Head 0
    mov dl, 0x80        ; First hard drive
    mov bx, 0x1000      ; Load kernel at 0x1000:0000
    int 0x13            ; BIOS interrupt to read disk
    jc disk_error       ; Jump if read failed

    ; Switch to 32-bit Protected Mode
    cli                 ; Disable interrupts
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

[BITS 32]         ; Now in 32-bit mode
init_32:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov esp, 0x90000   ; Set up stack
    call KERNEL_ENTRY  ; Jump to kernel_main()

    hlt

loading_msg db "Loading Kernel...", 0

; GDT (Global Descriptor Table)
gdt_descriptor:
    dw 0xFFFF, 0, 0x9A, 0xCF  ; Code Segment
    dw 0xFFFF, 0, 0x92, 0xCF  ; Data Segment

CODE_SEG equ 0x08
DATA_SEG equ 0x10
KERNEL_ENTRY equ 0x1000   ; Address of kernel entry

times 510 - ($-$$) db 0   ; Fill to 512 bytes
dw 0xAA55                 ; Boot signature