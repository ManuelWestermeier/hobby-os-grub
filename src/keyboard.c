#pragma once

char get_key(void); // blocking read: returns ASCII if mapped

#include "keyboard.h"
#include "config.h"
#include <stdint.h>

static uint8_t scancode_to_ascii[256] = {/* fill with mapping */};

static inline uint8_t inb(uint16_t port)
{
    uint8_t ret;
    __asm__ volatile("inb %1, %0" : "=a"(ret) : "Nd"(port));
    return ret;
}

char get_key(void)
{
    uint8_t sc;
    do
    {
        sc = inb(PORT_KEYBOARD_STATUS);
    } while (!(sc & 1));
    sc = inb(PORT_KEYBOARD_DATA);
    return scancode_to_ascii[sc];
}