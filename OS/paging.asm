[BITS 64]
[GLOBAL setup_paging]
[EXTERN load_page_directory]

setup_paging:
    ; Allocate memory for page tables
    mov rax, page_directory
    mov cr3, rax      ; Set CR3 register to our page directory

    ; Enable paging
    mov rax, cr0
    or rax, 0x80000000 ; Set PG bit (bit 31) in CR0
    mov cr0, rax

    ret

section .bss
align 4096
page_directory: resb 4096
