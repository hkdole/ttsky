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

## How to test

Testing occurs by comparing the resultant to known answers to the formula. If they are equivalent, the test is successful. It also tests against overflows to see if they correctly do so.

## External hardware

No external hardware is used

## Use of generative AI

Use of genAI is constrained to explanations. My skills with verilog is from CSE 100 and needed concepts explained to me such as regs (as opposed to FDRE DFF's from Xilinx) and how one could make test benches. None of the code is written by AI.