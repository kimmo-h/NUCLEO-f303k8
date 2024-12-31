# NUCLEO-f303k8
Template for programming NUCLEO-f303k8 using GCC and CMSIS libraries without libc.

## Prerequisites
### Tools
Install following tools from links below or use package manager:
- Arm GNU Toolchain (https://developer.arm.com/Tools%20and%20Software/GNU%20Toolchain) or 
- Stlink (https://github.com/stlink-org/stlink)
- Make
### Dependencies
Clone following Github repos:
- Arm CMSIS 5 (https://github.com/ARM-software/CMSIS_5)
- STM32CubeF3 CMSIS Device MCU Component (https://github.com/STMicroelectronics/cmsis_device_f3)

Comment out or remove function call "bl __libc_init_array" at line 99 of cmsis_device_f3/Source/Templates/gcc/startup_stm32f303x8.s startup file.
