#include <stdint.h>
#include "interrupts.h"
#define IDT_SIZE 256

struct IDTEntry {
    uint16_t offset_low;
    uint16_t selector;
    uint8_t zero;
    uint8_t type_attr;
    uint16_t offset_middle;
    uint32_t offset_high;
    uint32_t reserved;
} __attribute__((packed));

struct IDTDescriptor {
    uint16_t limit;
    uint64_t base;
} __attribute__((packed));

struct IDTEntry idt[IDT_SIZE];
struct IDTDescriptor idt_descriptor = { sizeof(idt) - 1, (uint64_t)idt };

void load_idt();
void keyboard_handler();

void setup_idt() {
    // Set up a basic IDT entry (e.g., for keyboard interrupt 0x21)
    idt[0x21].offset_low = (uint16_t)(uintptr_t)keyboard_handler;
    idt[0x21].selector = 0x08;  // Kernel code segment
    idt[0x21].zero = 0;
    idt[0x21].type_attr = 0x8E; // Interrupt Gate
    idt[0x21].offset_middle = (uint16_t)((uintptr_t)keyboard_handler >> 16);
    idt[0x21].offset_high = (uint32_t)((uintptr_t)keyboard_handler >> 32);
    idt[0x21].reserved = 0;

    load_idt();  // Load the new IDT
}