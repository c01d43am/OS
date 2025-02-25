[BITS 64]
[GLOBAL _start]
[EXTERN kernel_main]

_start:
    cli                ; Disable interrupts
    call kernel_main   ; Call the main C function
    hlt                ; Halt the CPU
