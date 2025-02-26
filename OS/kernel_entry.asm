[BITS 64]
[GLOBAL _start]  ; Define the entry symbol

extern kernel_main   ; Tell assembler kernel_main() exists in C

section .text
_start:
    call kernel_main  ; Call the kernel main function
    hlt               ; Halt the CPU

[BITS 32]
[GLOBAL multiboot_header]
[EXTERN kernel_main]

SECTION .multiboot
align 4
multiboot_header:
    dd 0x1BADB002  ; Magic number
    dd 0x00        ; Flags
    dd -(0x1BADB002 + 0x00) ; Checksum (magic + flags + checksum = 0)

SECTION .text
global _start32
_start32:
    ; Load stack
    mov esp, stack_top
    call kernel_main  ; Jump to kernel_main in C

    hlt   ; Halt CPU if kernel_main returns

SECTION .bss
resb 8192  ; 8 KB stack
stack_top: