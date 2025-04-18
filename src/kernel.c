#include "screen.h"
#include "keyboard.h"

void kmain(void)
{
    clear_screen();
    print_string("Welcome to MyOS!\n");
    while (1)
    {
        char c = get_key(); // blocking read
        print_char(c);
    }
}