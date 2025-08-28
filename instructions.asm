instr_error_str: data.str "bad mnemonic" data.8 10 data.8 0

const NUM_CONDITIONS: 8
condition_table:
    data.str "ifz"  data.fill 0, 2 data.8 0x01
    data.str "ifnz" data.fill 0, 1 data.8 0x02
    data.str "ifc"  data.fill 0, 2 data.8 0x03
    data.str "iflt" data.fill 0, 1 data.8 0x03
    data.str "ifnc" data.fill 0, 1 data.8 0x04
    data.str "ifge" data.fill 0, 1 data.8 0x04 ; ifgteq
    data.str "ifgt" data.fill 0, 1 data.8 0x05
    data.str "ifle" data.fill 0, 1 data.8 0x06 ; iflteq

const NUM_INSTRUCTIONS: 13
instruction_table:
    data.str "add"  data.fill 0, 2 data.8 0x01
    data.str "sub"  data.fill 0, 2 data.8 0x21
    data.str "inc"  data.fill 0, 2 data.8 0x11
    data.str "dec"  data.fill 0, 2 data.8 0x31
    data.str "mov"  data.fill 0, 2 data.8 0x17
    data.str "movz" data.fill 0, 1 data.8 0x27
    data.str "cmp"  data.fill 0, 2 data.8 0x07
    data.str "call" data.fill 0, 1 data.8 0x18
    data.str "ret"  data.fill 0, 2 data.8 0x2A
    data.str "jmp"  data.fill 0, 2 data.8 0x08
    data.str "rjmp" data.fill 0, 1 data.8 0x09
    data.str "loop" data.fill 0, 1 data.8 0x28
    data.str "brk"  data.fill 0, 2 data.8 0x20
