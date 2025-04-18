section .multiboot
    align 4
    dd 0x1BADB002
    dd 0x00010003
    dd -(0x1BADB002 + 0x00010003)

section .text
global _start
_start:
    cli
    lgdt [gdt_descriptor]

    mov eax, cr0
    or eax, 1
    mov cr0, eax

    jmp 0x08:protected_mode_entry

gdt_start:
    dq 0x0000000000000000
    dq 0x00CF9A000000FFFF
    dq 0x00CF92000000FFFF
gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

protected_mode_entry:
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov esp, 0x90000

    extern kmain
    call kmain

.hang:
    cli
    hlt
    jmp .hang
