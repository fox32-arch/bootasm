; continues from assembler_1.asm
assembler_2:
    push r0
    movz.8 r0, 10
    call r18
    pop r0
    call r19
    movz.8 r0, 10
    call r18

    ret

; inputs:
; r3: source or target string arg pointer
write_source_target:
    mov r10, r0
    movz.8 r11, [current_size]
    cmp r3, 0
    ifz ret
    movz.8 r1, 16
    cmp.8 [r3], 'r'
    ifz movz.8 r11, 0
    ifz movz.8 r1, 10
    ifz inc r3
    cmp.8 [r3], '['
    ifz movz.8 r11, 2 ; immediate pointers are always 32 bits long
    ifz inc r3
    cmp.16 [r3], 0x725B ; "[r"
    ifz movz.8 r11, 0
    ifz movz.8 r1, 10
    ifz inc r3, 2
    mov r0, r3
    call [ROM_string_to_int]
    cmp.8 r11, 0
    ifz rjmp.16 write_source_target_byte
    cmp.8 r11, 1
    ifz rjmp.16 write_source_target_half
    cmp.8 r11, 2
    ifz rjmp.16 write_source_target_word
write_source_target_end:
    mov r0, r10
    ret
write_source_target_byte:
    mov.8 [r10], r0
    call r16
    call r17
    inc r10
    rjmp.16 write_source_target_end
write_source_target_half:
    mov.16 [r10], r0
    call r16
    call r17
    sra r0, 8
    call r16
    call r17
    inc r10, 2
    rjmp.16 write_source_target_end
write_source_target_word:
    mov [r10], r0
    call r16
    call r17
    sra r0, 8
    call r16
    call r17
    sra r0, 8
    call r16
    call r17
    sra r0, 8
    call r16
    call r17
    inc r10, 4
    rjmp.16 write_source_target_end

print_space:
    push r0
    movz.8 r0, ' '
    call r18
    pop r0
    ret
