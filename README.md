# COA Lab Programs

Programs transcribed from `COA LAB MANUAL Expt 1 to 9 (2).pdf` for the requested experiments 2–10. The notes below summarize the code and the core concepts that are useful to explain in a viva; they do not reproduce the full manual.

## DOS/MASM filenames


| Experiment | Program | Source file |
|---|---|---|
| 2 | ALU arithmetic operations | `02ALUADD.ASM` |
| 2 | ALU logical operations | `02ALULOG.ASM` |
| 3 | Hexadecimal to BCD | `03HEXBCD.ASM` |
| 3 | Packed BCD to ASCII | `03BCDASCI.ASM` |
| 3 | ASCII-labelled packed BCD to ASCII digits | `03ASCTBCD.ASM` |
| 4 | Keyboard-input BCD addition | `04BCDADD.ASM` |
| 5 | Display string | `05STRDISP.ASM` |
| 5 | Read and count string length | `05STRLEN.ASM` |
| 5 | Reverse string | `05STRREV.ASM` |
| 6 | Block transfer | `06BLKTRAN.ASM` |
| 6 | Block exchange | `06BLKEXCH.ASM` |
| 7 | Draw rectangle and triangle with BIOS video services | `07SHAPES.ASM` |
| 8 | Booth multiplication algorithm | `08BOOTH.C` |
| 9 | Display 8086 flag register bits | `09FLAGS.ASM` |
| 10 | Direct-mapped cache-line index calculation | `10CACHEIDX.ASM` |

Experiment 1 in the manual contains installation and setup instructions only. The manual labels the Experiment 3 programs “HEX to BCD”, “ASCII to BCD”, and “BCD to ASCII”; the latter two source snippets actually both convert a packed two-digit BCD byte to displayed ASCII digits, so the filenames describe the code's behavior.

## Viva notes

### Experiment 2 — ALU operations

The arithmetic program demonstrates `ADD`, `SUB`, `MUL`, and `DIV` on 8086 registers. `ADD` and `SUB` update the destination and affect status flags. For 8-bit unsigned `MUL`, the product is stored in `AX` (`AH:AL`); for 8-bit `DIV`, the dividend is `AX`, and the quotient and remainder are returned in `AL` and `AH`. Logical operations (`AND`, `OR`, `XOR`, `NOT`) work bit by bit. `NOT` complements every bit and does not change flags; the other logical instructions clear CF and OF and update status flags such as ZF, SF, and PF.

**Likely viva questions:** What is the difference between `MUL` and `IMUL`? Where do 8-bit multiply/divide results go? What do CF, ZF, and OF indicate? What is the difference between `XOR` and `OR`? (The sample ends with `INT 3h`, a debugger breakpoint.)

### Experiment 3 — Number representation and conversion

`03_hex_to_bcd.asm` repeatedly divides the input value by 10. Each remainder is a decimal digit; the program pushes the remainders and pops them in reverse order to display the digits. `03_bcd_to_ascii.asm` splits a packed BCD byte into high and low nibbles, then adds `30h` to each digit to get its ASCII character. The file named `03_ascii_to_bcd.asm` is labeled that way in the manual, but its code performs the same packed-BCD-to-ASCII display conversion.

BCD stores one decimal digit per 4-bit nibble. Packed BCD `37h` represents decimal 37, while ASCII characters `'3'` and `'7'` are `33h` and `37h`. Conversion between a digit value and its ASCII character commonly adds or subtracts `30h`.

**Likely viva questions:** What is packed versus unpacked BCD? Why divide by 10? Why add `30h` to a digit? Where does `DIV r/m16` leave quotient and remainder? (For 16-bit division, dividend is `DX:AX`, quotient is `AX`, remainder is `DX`.)

### Experiment 4 — BCD addition with keyboard input

The program reads two decimal characters for each operand using DOS `INT 21h` function `01h`, converts them from ASCII to digit values by subtracting `30h`, and combines the digits into packed BCD. It adds the bytes and uses `DAA` (Decimal Adjust after Addition) to correct the binary sum into valid packed BCD. DOS function `09h` displays `$`-terminated strings; function `02h` displays one character.

**Likely viva questions:** Why is `DAA` needed after adding BCD? What does `DAA` adjust? What input format does the routine expect? How does `INT 21h` choose a DOS service? The sample displays only two result digits, so a carry into a third digit is not displayed.

### Experiment 5 — String handling and DOS services

The examples display a `$`-terminated string, read characters until Enter (carriage return, ASCII `0Dh`) and count them, and reverse a fixed string using the stack. `SI` points to string data; `CX` is commonly used as a loop counter; `PUSH` and `POP` use the stack in last-in, first-out order, which reverses the character order when values are popped.

**Likely viva questions:** What terminates a DOS function `09h` string? What does `INT 21h` function `01h` return? What are `SI` and `CX` used for? How does a stack reverse data? The supplied string-length code prints a single digit for the count, and the reverse-string snippet's word-sized memory access may not behave as intended for characters; those limitations are present in the source.

### Experiment 6 — Block transfer and exchange

The transfer program copies five bytes from `SOURCE` to `DEST` by advancing `SI` and `DI` after each byte. The exchange program swaps corresponding bytes from two blocks using `AL` and `BL` as temporary storage. `LOOP` decrements `CX` and branches while it is nonzero.

**Likely viva questions:** What do `SI` and `DI` point to here? Why use a temporary register when swapping? What does `LOOP` do? How would you use the 8086 string instruction `MOVSB` for a transfer? (It copies `DS:[SI]` to `ES:[DI]`; `DF` controls whether the pointers advance or retreat.)

### Experiment 7 — BIOS graphics services

The program switches to BIOS video mode `13h` (320×200, 256 colors), plots pixels with `INT 10h` function `0Ch`, draws rectangle and triangle edges with coordinate loops, waits for a key using BIOS keyboard service `INT 16h`, then restores text mode `03h`. For pixel plotting, `CX` carries the X coordinate, `DX` the Y coordinate, `AL` the color, and `BH` the display page.

**Likely viva questions:** What are the resolution and color depth of mode `13h`? Which registers specify a pixel's coordinates and color? What is the difference between BIOS `INT 10h` video services and DOS `INT 21h` services? What do the loops do to trace each edge?

### Experiment 8 — Booth multiplication

The C program illustrates signed binary multiplication using Booth's algorithm and two's-complement representation. It examines adjacent multiplier bits (the current least-significant bit and an appended previous bit): `01` means add the multiplicand, `10` means subtract it, and `00` or `11` means leave the partial product unchanged. Each iteration then performs an arithmetic right shift of the combined partial product and multiplier.

**Likely viva questions:** Why use Booth's algorithm? What is two's complement? What operation corresponds to bit pairs `01` and `10`? Why must the shift preserve the sign bit? The source is a C simulation, not 8086 assembly, and its input/range checks and shift implementation should be reviewed before treating it as a general-purpose multiplier.

### Experiment 9 — Display the 8086 flag register

This program changes selected flags (`CLI` clears IF, `STC` sets CF, and `STD` sets DF), then uses `PUSHF` to copy the flags word to the stack and `POPF` is not used: it pops the saved word into `BX` for inspection. The program checks each bit against a mask, prints `1` or `0`, and rotates the mask to move to the next bit. The heading labels the displayed status/control flags, including OF, DF, IF, TF, SF, ZF, AF, PF, and CF. Some flag bits are reserved or fixed on an 8086, so the raw 16-bit word includes bits that are not named in the heading.

**Likely viva questions:** What are the 8086 flags and what do status flags indicate? What is the role of CF, ZF, SF, OF, IF, DF, and TF? What do `PUSHF` and `POPF` do? How do `CLI`, `STC`, and `STD` affect flags? How does a bit mask test whether a particular flag bit is set? (In this listing, `AND` tests the current mask and `ROR` rotates that mask.)

### Experiment 10 — Direct-mapped cache-line index calculation

The simplified program calculates the cache line using `block number MOD number of cache lines`. With `BLOCK = 13` and `LINES = 4`, it computes `13 MOD 4 = 1` and displays `Cache line: 1`. For 8-bit `DIV`, the quotient is returned in `AL` and the remainder in `AH`.

**Likely viva questions:** What is cache memory and why is it used? How is a direct-mapped cache index calculated? What do `AL` and `AH` contain after 8-bit `DIV`? What is a conflict miss? How do direct, fully associative, and set-associative mapping differ? This short program demonstrates index calculation only; it does not model cache data storage or replacement.

These files are faithful transcriptions, not validated or repaired implementations. Some snippets in the manual appear incomplete or contain inconsistencies; check each program in your target assembler/compiler before relying on its output.
