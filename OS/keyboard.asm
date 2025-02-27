[BITS 64]

global keyboard_handler
extern keyboard_callback  ; Defined in kernel.c

section .text

keyboard_handler:
    push rax
    push rbx
    push rcx
    push rdx

    call keyboard_callback   ; Call the external function

    pop rdx
    pop rcx
    pop rbx
    pop rax
    iretq  ; Return from interrupt (64-bit)
