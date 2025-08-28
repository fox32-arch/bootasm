# bootasm

Extremely basic fox32 assembler in under 1024 bytes

## Usage
Assemble to a raw binary with `fox32asm main.asm bootasm.bin`, then attach it to the fox32 emulator as a disk.
fox32rom will boot it and enter its built-in monitor, which now has the `a` command to assemble a single instruction.
Type `help` in the monitor for a basic overview.

Essentially, the syntax is this: `a <address> <[condition] opcode [operand [operand]]>`. Commas are not used between the two operands. Upon return it will print the resulting bytes and the address where the next instruction should begin.

## Status
The parsing is very primitive and likely has weird edge cases, please let me know if you run into issues!

The standard `.8`/`.16` suffixes are supported. `.32` is not recognized as it is the default size with no suffix.
All values are expressed in hexadecimal *without the `0x` prefix*. General purpose registers are `r0` through `r31`, others (like `rsp`) are not currently recognized.
As a workaround, use `r32`, `r33`, and `r34` in place of `rsp`, `resp`, and `rfp` respectively.
Registers and immediate addresses may be dereferenced using the standard `[something here]` bracket syntax.
Register pointer offsets are not currently supported.

Instructions are not checked for the correct number of operands, it will simply assemble whatever you tell it.
It won't complain if you try to assemble `mov 5` or something weird like that.

Supported instructions:
- `add`
- `sub`
- `inc` (only by 1, not 2,4,8)
- `dec` (only by 1, not 2,4,8)
- `mov`
- `movz`
- `cmp`
- `call`
- `ret`
- `jmp`
- `rjmp`
- `loop`
- `brk`

Supported conditions:
- `ifz`
- `ifnz`
- `ifc`
- `iflt`
- `ifnc`
- `ifge` (`ifgteq` in the conventional fox32asm)
- `ifgt`
- `ifle` (`iflteq` in the conventional fox32asm)

## License
This project is licensed under the [MIT license](LICENSE).
