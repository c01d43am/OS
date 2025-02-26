[BITS 64]

[GLOBAL keyboard_handler]
[GLOBAL load_idt]

section .text

keyboard_handler:
    push rax
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15

    mov al, 0x20       ; Send End Of Interrupt (EOI) signal
    out 0x20, al

    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rax

    iretq              ; 64-bit interrupt return

load_idt:
    lidt [idt_descriptor]  ; Load the IDT
    ret

idt_descriptor:
    dw 0         ; Limit (size of IDT - 1)
    dq 0         ; Base address of IDT