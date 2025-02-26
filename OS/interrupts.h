#ifndef INTERRUPTS_H
#define INTERRUPTS_H

#include <stdint.h>

extern void setup_idt();        // Defined in interrupts.c
extern void load_idt();         // Defined in interrupts.asm
extern void keyboard_handler(); // Defined in interrupts.asm

#endif