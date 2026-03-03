/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

/* # Inputs
  ui[0]: "A0"
  ui[1]: "A1"
  ui[2]: "A2"
  ui[3]: "A3"
  ui[4]: "A4"
  ui[5]: "OP0"
  ui[6]: "OP1"
  ui[7]: "OP2"

  # Outputs
  uo[0]: "C0"
  uo[1]: "C1"
  uo[2]: "C2"
  uo[3]: "C3"
  uo[4]: "C4"
  uo[5]: ""
  uo[6]: ""
  uo[7]: ""

  # Bidirectional pins
  uio[0]: "B0"
  uio[1]: "B1"
  uio[2]: "B2"
  uio[3]: "B3"
  uio[4]: "B4"
  uio[5]: "B5"
  uio[6]: ""
  uio[7]: ""

  ALU that supports the following operations:
  * ADD
  * SUB
  * AND
  * OR
  * XOR
  * NOT
  * Shift left
  * Shift right
*/

`default_nettype none

module tt_um_ALU_harry_dole (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  wire[4:0] A, B;
  reg[4:0] C;
  wire[2:0] opcode;

  // All output pins must be assigned. If not used, assign to 0.
  assign uio_out = 0;
  assign uio_oe  = 0;

  // Assign relationships for my own sanity
  assign A = ui_in[4:0];
  assign B = uio_in[4:0];
  assign uo_out[4:0] = C;
  assign uo_out[7:5] = 0;
  assign opcode = ui_in[7:5];

  //ALU logic
  always @(*) begin 
    case (opcode)
      //ADD
      3'b000: C = A + B;
      //SUB
      3'b001: C = A - B;
      //AND
      3'b010: C = A & B;
      //OR
      3'b011: C = A | B;
      //XOR
      3'b100: C = A ^ B;
      //NOT (ignore B)
      3'b101: C = ~A;
      //SHIFT LEFT
      3'b110: C = A << B;
      //SHIFT RIGHT
      3'b111: C = A >> B;

      default: C = 5'b00000;
    endcase
  end

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
