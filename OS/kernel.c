#include "interrupts.h"

void print_string(const char* str) {
    char* video_memory = (char*) 0xB8000;
    while (*str) {
        *video_memory++ = *str++;
        *video_memory++ = 0x07; // Attribute byte: light grey on black background
    }
}

extern void setup_idt();  // Declare it before calling

void kernel_main() {
    setup_idt(); // Set up the IDT for handling keyboard input
    
    char *video_memory = (char *)0xB8000;
    video_memory[0] = 'K';  // Display 'K' on screen
    video_memory[1] = 0x07; // White text on black background

    while (1);
}