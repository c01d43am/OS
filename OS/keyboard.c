#include <stdint.h>
#include "ports.h"

#define KEYBOARD_DATA_PORT 0x60

// Read a byte from a given port
static inline uint8_t inb(uint16_t port) {
    uint8_t result;
    __asm__ __volatile__ ("inb %1, %0" : "=a"(result) : "Nd"(port));
    return result;
}

// Convert scancode to ASCII character
char scancode_to_ascii(uint8_t scancode) {
    const char scancode_map[128] = {
        0, 27, '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', '\b',
        '\t', 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']', '\n',
        0, 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', '\'', '`',
        0, '\\', 'z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.', '/',
        0, '*', 0, ' ', 0  // Spacebar and other keys
    };
    
    return scancode_map[scancode];
}

// Print character to screen (dummy implementation)
void print_char(char c) {
    char *video_memory = (char*) 0xB8000;
    video_memory[0] = c;  // Display character at the top-left of the screen
    video_memory[1] = 0x07; // Light gray color
}

// Keyboard callback function to be called from assembly
void keyboard_callback() {
    uint8_t scancode = inb(KEYBOARD_DATA_PORT); // Read from keyboard port
    char ascii = scancode_to_ascii(scancode);
    
    if (ascii) {
        print_char(ascii);  // Function to display characters
    }
}