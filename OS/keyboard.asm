[BITS 64]

global keyboard_handler
extern keyboard_callback  ; Define in C or another file

section .text

keyboard_handler:
    push rax
    push rbx
    push rcx
    push rdx

    call keyboard_callback   ; Call external function

    pop rdx
    pop rcx
    pop rbx
    pop rax
    iretq  ; Return from interrupt (64-bit)
