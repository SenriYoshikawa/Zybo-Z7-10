`timescale 1ps / 1ps
// ****
module SCDFFQRB (CLK, RB, DATA, Q);
input CLK, RB, DATA;
output Q;

reg Q;

always@( posedge CLK or negedge RB) begin
  if (RB == 0)  Q <= 1'b0;
  else          Q <= DATA;
end

endmodule


// *****
module SCNAND2 (YB, A, B);
input A, B;
output YB;

assign #1 YB = ~(A & B); 

endmodule


// ****
// module SCNAND2B (YB, A, BB);
// input A, BB;
// output YB;

// assign #1 YB = ~(A & ~BB); 

// endmodule


// ****
// module SCNAND3 (YB, A, B, C);
// input A, B, C;
// output YB;

// assign #1 YB = ~(A & B & C); 

// endmodule


// ****
// module SCAND3 (Y, A, B, C);
// input A, B, C;
// output Y;

// assign #1 Y = A & B & C; 

// endmodule


// ****
// module SCAND2 (Y, A, B);
// input A, B;
// output Y;

// assign #1 Y = A & B; 

// endmodule


// ****
module SCOR2 (Y, A, B);
input A, B;
output Y;

assign #1 Y = A | B; 

endmodule


// ****
module SCOR3 (Y, A, B, C);
input A, B, C;
output Y;

assign #1 Y = A | B | C; 

endmodule


// ****
module SCNOR2 (YB, A, B);
input A, B;
output YB;

assign #1 YB = ~(A | B); 

endmodule


// ****
module SCNOR3 (YB, A, B, C);
input A, B, C;
output YB;

assign #1 YB = ~(A | B | C); 

endmodule


// ****
module SCINV (YB, A);
input A;
output YB;

assign #1 YB = ~A; 

endmodule


// ****
// module SCCKINVCL (YB, A);
// input A;
// output YB;

// assign #0 YB = ~A; 

// endmodule


// ****
module SCBUF (Y, A);
input A;
output Y;

assign #0 Y = A; 

endmodule


// ****
module SCCKBUFCL (Y, A);
input A;
output Y;

BUFG BUFG_inst(.O(Y), .I(A));
// assign #0 Y = A; 

endmodule


// ****
// module SCDLY07 (Y, A);
// input A;
// output Y;

// assign #0 Y = A; 

// endmodule


// ****
module SCDLY04 (Y, A);
input A;
output Y;

assign #0 Y = A; 

endmodule


// ****
// module SCDLY02 (Y, A);
// input A;
// output Y;

// assign #0 Y = A; 

// endmodule


// ****
// module SCECCLH (H);
// (* dont_touch = "true" *) output H;

// assign H = 1'b1; 

// endmodule
