OUTPUT = firmware
SOURCES = init.c main.c cmsis_device_f3/Source/Templates/gcc/startup_stm32f303x8.s
CC = arm-none-eabi-gcc
OFLAGS = -Os
GFLAGS = -g3
WFLAGS = -Wall -Wextra -Werror -Wconversion -Wdouble-promotion -Wshadow -Wundef
IFLAGS = -ICMSIS_5/CMSIS/Core/Include -Icmsis_device_f3/Include
FFLAGS = -fdata-sections -ffunction-sections
MFLAGS = -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16 -mthumb
CFLAGS = $(OFLAGS) $(GFLAGS) $(WFLAGS) $(IFLAGS) $(FFLAGS) $(MFLAGS)
LDFLAGS = -Tlink.ld --specs=nano.specs -Wl,--gc-sections
ELF = $(OUTPUT).elf
BIN = $(OUTPUT).bin

$(BIN): $(ELF)
	arm-none-eabi-objcopy -O binary $(ELF) $(BIN)

$(ELF): link.ld Makefile $(SOURCES)
	$(CC) -o $(ELF) $(SOURCES) $(CFLAGS) $(LDFLAGS)

flash: $(BIN)
	st-flash --reset write $(BIN) 0x8000000

clean:
	rm $(OUTPUT).*
