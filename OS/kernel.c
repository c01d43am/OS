#include "interrupts.h"

void print_string(const char* str) {
    char* video_memory = (char*) 0xB8000;
    while (*str) {
        *video_memory++ = *str++;
        *video_memory++ = 0x07; // Attribute byte: light grey on black background
    }
}

void kernel_main() {
    setup_idt(); // Set up the IDT for handling keyboard input
    
    print_string("Welcome to my OS!");

    while (1);
}