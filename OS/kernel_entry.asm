[BITS 64]
[GLOBAL _start]  ; Define the entry symbol

extern kernel_main   ; Tell assembler kernel_main() exists in C

section .text
_start:
    cli                 ; Disable interrupts
    mov esp, stack_top  ; Set up the stack
    call kernel_main    ; Call the main kernel function
    hlt                 ; Halt CPU if kernel_main returns

[BITS 32]
[GLOBAL multiboot_header]
[EXTERN kernel_main]

section .multiboot
align 4
multiboot_header:
    dd 0x1BADB002  ; Magic number
    dd 0x00        ; Flags
    dd -(0x1BADB002 + 0x00) ; Checksum (magic + flags + checksum = 0)

section .bss
align 16
resb 16384  ; Reserve 16 KB stack space
stack_top: