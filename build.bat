@echo off
setlocal

set BUILD=build
set ISO=%BUILD%\os.iso

REM Create build and ISO directories
if not exist %BUILD% mkdir %BUILD%
if not exist %BUILD%\isodir\boot\grub mkdir %BUILD%\isodir\boot\grub

REM 1. Assemble boot.asm
nasm -f elf -o %BUILD%\boot.o src\boot.asm

REM 2. Compile kernel.c
i686-elf-gcc -ffreestanding -m32 -c src\kernel.c -o %BUILD%\kernel.o

REM 3. Link with linker.ld
i686-elf-ld -T linker.ld -o %BUILD%\kernel.bin %BUILD%\boot.o %BUILD%\kernel.o

REM 4. Copy kernel and GRUB config
copy %BUILD%\kernel.bin %BUILD%\isodir\boot\kernel.bin >nul
copy boot\grub.cfg %BUILD%\isodir\boot\grub\grub.cfg >nul

REM 5. Create ISO using grub-mkrescue
grub-mkrescue -o %ISO% %BUILD%\isodir

echo.
echo Done! ISO image: %ISO%
pause
