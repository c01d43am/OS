[BITS 64]

global load_idt
global set_idt_entry

section .bss
align 16
idt: resb 4096  ; Reserve space for IDT (256 entries * 16 bytes each)

section .text

load_idt:
    mov rax, idt_end - idt - 1  ; Compute IDT size
    mov word [idt_descriptor], ax  ; Store limit

    lea rax, [idt]                 ; Load base address of IDT
    mov qword [idt_descriptor + 2], rax  

    lidt [idt_descriptor]           ; Load the new IDT
    ret

set_idt_entry:
    ; Arguments: rdi = entry number, rsi = handler, rdx = selector, rcx = flags
    lea rax, [idt]           ; Get base address of IDT
    mov rbx, rdi             ; Get entry index
    shl rbx, 4               ; Multiply index by 16 (each entry is 16 bytes)
    add rax, rbx             ; Get address of the entry

    mov qword [rax], rsi     ; Store handler address
    mov word  [rax + 8], dx  ; Store segment selector
    mov byte  [rax + 10], 0  ; Reserved
    mov byte  [rax + 11], cl ; Store flags
    ret

section .data
idt_descriptor:
    dw 0          ; IDT limit (size - 1)
    dq 0          ; Base address

idt_end:
