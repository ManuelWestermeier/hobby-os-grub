void kmain(void)
{
    const char *text = "Hello from C kernel!";
    char *video = (char *)0xb8000;
    for (int i = 0; text[i] != '\0'; i++)
    {
        video[i * 2] = text[i];
        video[i * 2 + 1] = 0x07;
    }

    while (1)
    {
        __asm__ __volatile__("hlt");
    }
}
