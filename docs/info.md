<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

ALU that supports the following operations:
* ADD
* SUB
* AND
* OR
* XOR
* NOT
* Shift left
* Shift right

Op codes are three bits and in order of presented (e.g. ADD is 000)
The system supports 5 bit numbers and will perform operations on them according to the opcode (with the exception of the NOT operation).

Every time the input in opcode changes, the ALU will compute according to what's specified to the opcode. For example if the inputs are:
A: 10011  B: 01100  opcode: 001
Then that means we are essentially subtracting 19(A) by 12(B). The result will be:
C: 00111
The binary equivalent of 7.

## How to test

One inputs 5 bit number A to the first 5 bits of the dedicated input and 5 bit number B to the first 5 bits of bidirectional input. The remaining 3 bits of the dedicated input define what operation the ALU should do.
After some time, the output C will be available as the first 5 bits of the dedicated output.

Testing occurs by comparing the resultant to known answers to the formula for each operation. If they are equivalent, the test is successful. There are additional tests against overflows if applicable.
This is adequate testing as it rigorously verifies each and every operation, making sure each one is functional.

## External hardware

No external hardware is used

## Use of generative AI

Use of genAI is constrained to explanations. My skills with verilog is from CSE 100 and needed concepts explained to me such as regs (as opposed to FDRE DFF's from Xilinx) and how one could make test benches. None of the code is written by AI.