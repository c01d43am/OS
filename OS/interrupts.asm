[BITS 64]
[GLOBAL load_idt]
[EXTERN idt_descriptor]  ; Fix: Ensure we reference the IDT descriptor from C

load_idt:
    lidt [idt_descriptor]  ; Load the new IDT
    sti                    ; Enable interrupts
    ret
