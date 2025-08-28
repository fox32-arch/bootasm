    opton
    org 0x00000800

const ROM_MONITOR_USER_CMD_PTR: 0x00000008
const ROM_print_string_to_monitor: 0xF0040038
const ROM_print_character_to_monitor: 0xF004003C
const ROM_print_hex_byte_to_monitor: 0xF0040040
const ROM_print_hex_word_to_monitor: 0xF0040044
const ROM_string_to_int: 0xF0047000
const ROM_read_sector: 0xF0045000

entry:
    mov r1, r0
    mov r0, 1
    mov r2, 0x0A00
    call [ROM_read_sector]

    mov [ROM_MONITOR_USER_CMD_PTR], command_table
    brk
    rjmp.8 entry

    #include "assembler_1.asm"

    ; bootable magic bytes
    nop ; work around an assembler bug with org.pad coming after a non-32-bit instruction
    org.pad 0x000009FC
    data.32 0x523C334C

command_table:
    data.strz "CMD"
    data.32 command_a_str data.32 command_a data.32 command_a_help
    data.32 0 data.32 0

current_addr: data.32 0
current_size: data.8 2 ; current instr operation size, 0 = byte, 1 = half, 2 = word
current_condition: data.8 0 ; current instr condition
command_a_str: data.strz "a"
command_a_help: data.strz "a       | at address $0, assemble instruction '$1 $2[, $3]'"

    #include "assembler_2.asm"
    #include "instructions.asm"
