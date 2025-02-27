[BITS 16]         ; We are in real mode
[ORG 0x7C00]      ; BIOS loads us at 0x7C00

start:
    mov ax, 0x07C0     ; Set segment registers
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    ; Print "Loading Kernel..."
    mov si, loading_msg
    call print_string

    ; Load kernel from disk
    call load_kernel
    jmp 0x1000:0       ; Jump to kernel at 0x1000:0000

loading_msg db "Loading Kernel...", 0

load_kernel:
    mov ax, 0x1000     ; Set kernel segment
    mov es, ax
    mov bx, 0x0000     ; Destination offset
    mov ah, 0x02       ; BIOS read sectors function
    mov al, 10         ; Number of sectors to read (adjust as needed)
    mov ch, 0x00       ; Cylinder 0
    mov dh, 0x00       ; Head 0
    mov cl, 0x02       ; Start at sector 2 (1st is bootloader)
    int 0x13           ; Call BIOS disk interrupt
    jc disk_error      ; If error, halt

    ret

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

; GDT (Global Descriptor Table)
gdt_descriptor:
    dw 0xFFFF, 0, 0x9A, 0xCF  ; Code Segment
    dw 0xFFFF, 0, 0x92, 0xCF  ; Data Segment

CODE_SEG equ 0x08
DATA_SEG equ 0x10
KERNEL_ENTRY equ 0x1000   ; Address of kernel entry

times 510 - ($-$$) db 0   ; Fill to 512 bytes
dw 0xAA55                 ; Boot signature