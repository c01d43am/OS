ENTRY(main)
SECTIONS {
    . = 1M;
    .text : { *(.text) }
    .data : { *(.data) }
    .bss : { *(.bss) }
}
