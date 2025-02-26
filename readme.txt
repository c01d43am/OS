run in ubuntu
root@coldream:/mnt/d/Personal/OS/OS# grub-mkrescue -o myos.iso iso




in powershell
nasm -f elf64 keyboard.asm -o keyboard.o
nasm -f elf64 interrupts.asm -o interrupts_asm.o

x86_64-elf-gcc -ffreestanding -mno-red-zone -c keyboard.c -o keyboard_c.o
x86_64-elf-gcc -ffreestanding -mno-red-zone -c interrupts.c -o interrupts.o
x86_64-elf-gcc -ffreestanding -mno-red-zone -c kernel.c -o kernel.o

x86_64-elf-ld -n -T linker.ld -o kernel.bin kernel_entry.o kernel.o keyboard.o keyboard_c.o interrupts.o interrupts_asm.o


and compile 
qemu-system-x86_64 -cdrom myos.iso
