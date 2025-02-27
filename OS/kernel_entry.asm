[BITS 32]         ; Switch to protected mode
[GLOBAL _start]   ; Ensure linker finds this

extern kernel_main   ; Tell assembler kernel_main() exists in C

section .text
_start:
    cli                 ; Disable interrupts
    mov esp, stack_top  ; Set up the stack
    call kernel_main    ; Call the main kernel function
    hlt                 ; Halt CPU if kernel_main returns

section .bss
resb 4096        ; 4KB stack
stack_top: