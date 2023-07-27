ENTRY(Reset_Handler)

MEMORY {
    flash(rx) : ORIGIN = 0x08000000, LENGTH = 64K
    ccram(rw) : ORIGIN = 0x10000000, LENGTH = 4K
    ram(rwx) : ORIGIN = 0x20000000, LENGTH = 12K
}

SECTIONS {
    .isr_vector : {
        KEEP(*(.isr_vector))
    } > flash
    .text : ALIGN(4) {
        *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.text*)))
        . = ALIGN(4);
    } > flash
    .rodata : ALIGN(4) {
        *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*)))
        . = ALIGN(4);
    } > flash
    .data : ALIGN(4) {
        _sdata = .;
        *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.data*)))
        . = ALIGN(4);
        _edata = .;
    } > ram AT > flash
    .bss : ALIGN(4) {
        _sbss = .;
        *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.bss*)))
        . = ALIGN(4);
        _ebss = .;
    } > ram
    .heap : ALIGN(4) {
        PROVIDE(_end = .);
    } > ram
}

_estack = ORIGIN(ccram) + LENGTH(ccram);
_sidata = LOADADDR(.data);
