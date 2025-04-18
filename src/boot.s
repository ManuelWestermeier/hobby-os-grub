; boot.s — Multiboot header + switch to protected mode
.section .multiboot
.align 4
.long 0x1BADB002        # magic
.long 0x00               # flags
.long -(0x1BADB002)      # checksum

.section .text
.global start
start:
    cli
    lgdt [gdt_descriptor]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp CODE_SEG:init_pm

[bits 16]
GDT:
    dq 0
    dq 0x00CF9A000000FFFF  ; code segment
    dq 0x00CF92000000FFFF  ; data segment
GDT_end:
GDT_desc:
    dw GDT_end - GDT - 1
    dd GDT
CODE_SEG equ 0x08

[bits 32]
init_pm:
    mov ax, DATA_SEG
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov esp, 0x90000
    call kmain
    hlt
DATA_SEG equ 0x10