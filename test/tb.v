`default_nettype none
`timescale 1ns / 1ps

/* This testbench just instantiates the module and makes some convenient wires
   that can be driven / tested by the cocotb test.py.
*/
module tb ();

  // Dump the signals to a FST file. You can view it with gtkwave or surfer.
  initial begin
    $dumpfile("tb.fst");
    $dumpvars(0, tb);
    #1;
  end

  // Wire up the inputs and outputs:
  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  reg [7:0] uio_in;
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;
`ifdef GL_TEST
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif

  // Replace tt_um_example with your module name:
 tt_um_ALU_harry_dole user_project (

      // Include power ports for the Gate Level test:
`ifdef GL_TEST
      .VPWR(VPWR),
      .VGND(VGND),
`endif

      .ui_in  (ui_in),    // Dedicated inputs
      .uo_out (uo_out),   // Dedicated outputs
      .uio_in (uio_in),   // IOs: Input path
      .uio_out(uio_out),  // IOs: Output path
      .uio_oe (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
      .ena    (ena),      // enable - goes high when design is selected
      .clk    (clk),      // clock
      .rst_n  (rst_n)     // not reset
  );

/*
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
initial begin
  ena    = 1'b1;
  clk    = 1'b0;
  rst_n  = 1'b1;
  ui_in  = 8'b0;
  uio_in = 8'b0;

  #10;
  // ---------------- Testing addition ----------------
    //Generic addition
  ui_in[4:0] = 5'd19; //A
  uio_in[4:0] = 5'd12; //B
  ui_in[7:5] = 3'b000; // op code

  #10;

  $display("A=19 B=12 ADD Result=%d", uo_out[4:0]);
  assert (uo_out[4:0] == 5'd31)
      $display("PASS");
    else
        $display("FAIL");

  #10;
    //Overflow addition
  ui_in[4:0] = 5'd31; //A
  uio_in[4:0] = 5'd1; //B
  ui_in[7:5] = 3'b000; // op code

  #10;

  $display("A=31 B=1 ADD Result=%d", uo_out[4:0]);
  assert (uo_out[4:0] == 5'd0)
      $display("PASS");
  else
      $display("FAIL");

  #10;
  // ---------------- Testing subtraction ----------------
    //Generic subtraction
  ui_in[4:0] = 5'd19; //A
  uio_in[4:0] = 5'd12; //B
  ui_in[7:5] = 3'b001; // op code

  #10;

  $display("A=19 B=12 SUB Result=%d", uo_out[4:0]);
  assert (uo_out[4:0] == 5'd7)
      $display("PASS");
  else
      $display("FAIL");

  #10;
    //Overflow subtraction
  ui_in[4:0] = 5'd0; //A
  uio_in[4:0] = 5'd1; //B
  ui_in[7:5] = 3'b001; // op code

  #10;

  $display("A=31 B=1 SUB Result=%d", uo_out[4:0]);
  assert (uo_out[4:0] == 5'd31)
      $display("PASS");
  else
      $display("FAIL");

  #10;
  // ---------------- Testing and'ing ----------------
  ui_in[4:0] = 5'b11111; //A
  uio_in[4:0] = 5'b01010; //B
  ui_in[7:5] = 3'b010; // op code

  #10;

  $display("A=11111 B=01010 AND Result=%b", uo_out[4:0]);
  assert (uo_out[4:0] == 5'b01010)
      $display("PASS");
  else
      $display("FAIL");

  #10;
  // ---------------- Testing or'ing ----------------
  ui_in[4:0] = 5'b00000; //A
  uio_in[4:0] = 5'b01010; //B
  ui_in[7:5] = 3'b011; // op code

  #10;

  $display("A=00000 B=01010 OR Result=%b", uo_out[4:0]);
  assert (uo_out[4:0] == 5'b01010)
      $display("PASS");
  else
      $display("FAIL");

  #10;
  // ---------------- Testing xor'ing ----------------
  ui_in[4:0] = 5'b10001; //A
  uio_in[4:0] = 5'b11011; //B
  ui_in[7:5] = 3'b100; // op code

  #10;

  $display("A=10001 B=11011 OR Result=%b", uo_out[4:0]);
  assert (uo_out[4:0] == 5'b01010)
      $display("PASS");
  else
      $display("FAIL");

  #10;
  // ---------------- Testing not'ing ----------------
  ui_in[4:0] = 5'b10001; //A
  uio_in[4:0] = 5'b11111; //B should be ignored
  ui_in[7:5] = 3'b101; // op code

  #10;

  $display("A=10001 B=11111 NOT Result=%b", uo_out[4:0]);
  assert (uo_out[4:0] == 5'b01110)
      $display("PASS");
  else
      $display("FAIL");

  #10;
  // ---------------- Testing shift left ----------------
    //Small shift
  ui_in[4:0] = 5'b00101; //A
  uio_in[4:0] = 5'b00001; //B
  ui_in[7:5] = 3'b110; // op code

  #10;

  $display("A=00101 B=00001 SHIFT LEFT Result=%b", uo_out[4:0]);
  assert (uo_out[4:0] == 5'b01010)
      $display("PASS");
  else
      $display("FAIL");

  #10;
    //Big shift
  ui_in[4:0] = 5'b00101; //A
  uio_in[4:0] = 5'b11111; //B
  ui_in[7:5] = 3'b110; // op code

  #10;

  $display("A=00101 B=11111 SHIFT LEFT Result=%b", uo_out[4:0]);
  assert (uo_out[4:0] == 5'b00000)
      $display("PASS");
  else
      $display("FAIL");

  #10;
  // ---------------- Testing shift right ----------------
    //Small shift
  ui_in[4:0] = 5'b00101; //A
  uio_in[4:0] = 5'b00001; //B
  ui_in[7:5] = 3'b111; // op code

  #10;

  $display("A=00101 B=00001 SHIFT RIGHT Result=%b", uo_out[4:0]);
  assert (uo_out[4:0] == 5'b00010)
      $display("PASS");
  else
      $display("FAIL");

  #10;
    //Big shift
  ui_in[4:0] = 5'b00101; //A
  uio_in[4:0] = 5'b11111; //B
  ui_in[7:5] = 3'b111; // op code

  #10;

  $display("A=00101 B=11111 SHIFT RIGHT Result=%b", uo_out[4:0]);
  assert (uo_out[4:0] == 5'b00000)
      $display("PASS");
  else
      $display("FAIL");

  #10;
  //$finish;
end
endmodule
