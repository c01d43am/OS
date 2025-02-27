#include <stdint.h>
#include "interrupts.h"

void keyboard_callback() {
    uint8_t scancode = port_byte_in(0x60); // Read from keyboard port
    char ascii = scancode_to_ascii(scancode);
    
    if (ascii) {
        print_char(ascii);  // Function to display characters
    }
}

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

void print_char(char c) {
    char *video_memory = (char*) 0xB8000;
    video_memory[0] = c;  // Display character at the top-left of the screen
    video_memory[1] = 0x07; // Light gray color
}