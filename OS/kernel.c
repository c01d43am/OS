#include "interrupts.h"

void print_string(const char* str) {
    char* video_memory = (char*) 0xB8000;
    while (*str) {
        *video_memory++ = *str++;
        *video_memory++ = 0x07; // Attribute byte: light grey on black background
    }
}

// Declare the assembly function before use
extern void load_idt();

void setup_idt() {
    load_idt();
}

void kernel_main() {
    setup_idt(); // Set up the IDT for handling keyboard input

    char *video_memory = (char *)0xB8000;
    video_memory[0] = 'K';  // Display 'K' on screen
    video_memory[1] = 0x07; // White text on black background

    print_string("Kernel Loaded!");

    while (1);
}
