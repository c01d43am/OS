[BITS 64]
[GLOBAL keyboard_handler]
[EXTERN keyboard_callback]  ; Reference a function in C

keyboard_handler:
    push rax
    push rbx
    push rcx
    push rdx

    call keyboard_callback  ; Call C function to handle input

    pop rdx
    pop rcx
    pop rbx
    pop rax
    iretq  ; Return from interrupt