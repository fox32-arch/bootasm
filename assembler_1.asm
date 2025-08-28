command_a:
    push r1
    mov r1, 16
    call [ROM_string_to_int]
    mov [current_addr], r0
    pop r1

    mov r16, [ROM_print_hex_byte_to_monitor]
    mov r17, print_space
    mov r18, [ROM_print_character_to_monitor]
    mov r19, [ROM_print_hex_word_to_monitor]

    mov r0, [current_addr]
    call r19
    movz.8 r0, ':'
    call r18
    call r17

    mov.8 [current_condition], 0x00 ; default to "always"
    mov r31, NUM_CONDITIONS
    mov r5, condition_table
condition_loop:
    cmp [r5], [r1]
    ifz rjmp.16 condition_found
    add r5, 6
    rloop.16 condition_loop
    rjmp.8 instr_start
condition_found:
    mov.8 [current_condition], [r5+5]
    mov r1, r2
    mov r2, r3
    mov r3, r4
instr_start:
    mov r31, NUM_INSTRUCTIONS
    mov r5, instruction_table
    mov.8 [current_size], 2 ; default to word size
instr_loop:
    cmp.8 [r1+3], '.'
    ifz rjmp.8 instr_size_3
    cmp.8 [r1+4], '.'
    ifz rjmp.8 instr_size_4
instr_check:
    cmp [r5], [r1]
    ifz rjmp.16 instr_found
    add r5, 6
    rloop.16 instr_loop
instr_error:
    mov r0, instr_error_str
    call [ROM_print_string_to_monitor]
    ret
instr_size_3:
    mov.8 [r1+3], 0
    cmp.16 [r1+4], 0x3631 ; "16"
    ifz mov.8 [current_size], 1
    cmp.8 [r1+4], '8'
    ifz mov.8 [current_size], 0
    rjmp.16 instr_check
instr_size_4:
    mov.8 [r1+4], 0
    cmp.16 [r1+5], 0x3631 ; "16"
    ifz mov.8 [current_size], 1
    cmp.8 [r1+5], '8'
    ifz mov.8 [current_size], 0
    rjmp.16 instr_check
instr_found:
    mov r0, [current_addr]

    ; at this point, r0 points to the first byte of this opcode
    ; write the condition/operand type byte
    movz.8 r1, [current_condition]
    sla r1, 4
    mov.8 [r0], r1
set_target:
    movz.8 r20, 1 ; assume there is a target
    cmp r3, 0
    ifz mov r3, r2
    ifz movz.8 r20, 0 ; nevermind!
    ifz rjmp.8 set_source ; no target, skip right to source
    cmp.8 [r2], 'r'
    ifz rjmp.8 set_source ; register (bits already zero)
    cmp.8 [r2], '['
    ifz mov.8 [r0], 0b00001100 ; immediate pointer
    cmp.16 [r2], 0x725B ; "[r"
    ifz mov.8 [r0], 0b00000100 ; register pointer
set_source:
    cmp r3, 0
    ifz rjmp.8 write_opcode
    cmp.8 [r3], 'r'
    ifz rjmp.8 write_opcode ; register (bits already zero)
    cmp.8 [r3], '['
    ifz or.8 [r0], 0b00000011 ; immediate pointer
    cmp.8 [r3], '['
    ifnz or.8 [r0], 0b00000010 ; immediate
    cmp.16 [r3], 0x725B ; "[r"
    ifz and.8 [r0], 0b11111110 ; register pointer
write_opcode:
    push r0
    movz.8 r0, [r0]
    call r16
    call r17
    pop r0
    inc r0
    ; write the opcode byte
    mov.8 [r0], [r5+5] ; base opcode
    movz.8 r1, [current_size]
    sla r1, 6
    or.8 [r0], r1 ; size bits
    push r0
    movz.8 r0, [r0]
    call r16
    call r17
    call r17
    pop r0
    inc r0

    rcall.16 write_source_target ; write source
    call r17
    cmp.8 r20, 0 ; is there a target to write?
    ifz rjmp.8 no_target
    mov r3, r2
    rcall.16 write_source_target ; write target
no_target:
    ; continues in assembler_2.asm
    rjmp.16 assembler_2
