/* filepath: /d:/Personal/OS/OS/linker.ld */
ENTRY(main)

SECTIONS
{
    . = 0x100000;

    .text :
    {
        *(.text)
    }

    .rodata :
    {
        *(.rodata)
    }

    .data :
    {
        *(.data)
    }

    .bss :
    {
        *(.bss)
    }
}