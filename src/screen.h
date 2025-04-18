#pragma once
#include <stddef.h>
#include <stdint.h>

void clear_screen(void);
void print_char(char c);
void print_string(const char *s);

// Pixel mode functions (after mode set)
void set_pixel(int x, int y, uint8_t color);