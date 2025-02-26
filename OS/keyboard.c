#include <stdint.h>

#define KEYBOARD_DATA_PORT 0x60
#define KEYBOARD_STATUS_PORT 0x64

uint8_t inb(uint16_t port) {
    uint8_t result;
    __asm__("inb %1, %0" : "=a"(result) : "Nd"(port));
    return result;
}

void keyboard_handler() {
    uint8_t keycode = inb(KEYBOARD_DATA_PORT);
    
    if (keycode == 0x1C) { // Enter key
        char *video_memory = (char*) 0xB8000;
        video_memory[160] = 'E'; // Display 'E' on Enter press
    }
}