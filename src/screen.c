#pragma once
#include <stddef.h>
#include <stdint.h>

void clear_screen(void);
void print_char(char c);
void print_string(const char *s);

// Pixel mode functions (after mode set)
void set_pixel(int x, int y, uint8_t color);

#include "screen.h"
#include "config.h"

static uint16_t cursor_pos = 0;

void clear_screen(void)
{
    for (size_t i = 0; i < VGA_WIDTH * VGA_HEIGHT; i++)
    {
        VGA_TEXT_MODE_BUF[i * 2] = ' ';
        VGA_TEXT_MODE_BUF[i * 2 + 1] = 0x07;
    }
    cursor_pos = 0;
}

void print_char(char c)
{
    if (c == '\n')
        cursor_pos += VGA_WIDTH - (cursor_pos % VGA_WIDTH);
    else
    {
        VGA_TEXT_MODE_BUF[cursor_pos * 2] = c;
        VGA_TEXT_MODE_BUF[cursor_pos * 2 + 1] = 0x07;
        cursor_pos++;
    }
}

void print_string(const char *s)
{
    for (const char *p = s; *p; ++p)
        print_char(*p);
}

// Mode 0x13: 320x200x256 — VGA graphics mode
// Set mode with BIOS int 0x10 before calling
static uint8_t *const VGA_GRAPHICS = (uint8_t *)0xA0000;

void set_pixel(int x, int y, uint8_t color)
{
    VGA_GRAPHICS[y * 320 + x] = color;
}