@echo off
REM Set up cross-compiler prefix
set PREFIX=i686-elf-
set BUILD=build
set SRC=src

REM Clean
if exist %BUILD% rd /s /q %BUILD%
mkdir %BUILD%

REM 1) Assemble bootloader stub
%PREFIX%gcc -m32 -ffreestanding -c %SRC%\boot.s -o %BUILD%\boot.o

REM 2) Compile kernel
%PREFIX%gcc -m32 -ffreestanding -O2 -c %SRC%\kernel.c -o %BUILD%\kernel.o

REM 3) Link into flat binary
%PREFIX%ld -m elf_i386 -Ttext 0x1000 --oformat binary %BUILD%\boot.o %BUILD%\kernel.o -o %BUILD%\kernel.bin

REM 4) Copy files for ISO
if exist iso rd /s /q iso
mkdir iso
mkdir iso\boot
mkdir iso\boot\grub
copy %BUILD%\kernel.bin iso\boot\kernel.bin >nul
copy boot\grub.cfg    iso\boot\grub\grub.cfg

REM 5) Create ISO with GRUB
grub-mkrescue -o os.iso iso

echo Done. Generated os.iso