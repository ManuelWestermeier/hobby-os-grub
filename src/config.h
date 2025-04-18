#pragma once

// VGA text buffer
#define VGA_TEXT_MODE_BUF ((volatile uint8_t *)0xB8000)
#define VGA_WIDTH 80
#define VGA_HEIGHT 25

// Ports
#define PORT_KEYBOARD_DATA 0x60
#define PORT_KEYBOARD_STATUS 0x64