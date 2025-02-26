Comment out or remove this section
[GLOBAL keyboard_handler]
keyboard_handler:
   push rax
   push rbx
   push rcx
   push rdx

   ; Your keyboard logic here

   pop rdx
   pop rcx
   pop rbx
   pop rax
   iretq
