`timescale 1ps / 1ps

module MemDelay (
  I_i,
  IA_i,
  WE_i,
  
  I_o,
  IA_o,
  WE_o
  );
  
  parameter RWIDTH = 34;
  parameter RDEPTH = 14;
  
  
  input [RWIDTH-1:0]	I_i;
  input [RDEPTH-1:0]	IA_i;
  input 		WE_i;
  
  output [RWIDTH-1:0]   I_o;
  output [RDEPTH-1:0]   IA_o;
  output 		WE_o;

  //reg [RWIDTH-1:0] I_temp;
  //reg [RDEPTH-1:0] IA_temp;  
  
  assign #1 I_o = I_i;
  assign #1 IA_o = IA_i;
  assign #1 WE_o = WE_i;

endmodule
