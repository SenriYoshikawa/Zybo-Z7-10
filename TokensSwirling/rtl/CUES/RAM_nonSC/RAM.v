
// ****
module RAMS34B16KW (A, I, IA, DM, CK, CE, WE, BP);
parameter DWIDTH=34, AWIDTH=14, WORDS=16384;

input [AWIDTH-1:0] IA;
input CE;
input WE;
input [DWIDTH-1:0] I;
input CK;
input [DWIDTH-1:0] DM;
input BP;
output [DWIDTH-1:0] A;


reg [DWIDTH-1:0] A;
reg [DWIDTH-1:0] mem [WORDS-1:0];

always@(posedge CK) begin
  if (~CE & ~WE) mem[IA] <= I;
  else if (~CE) A <= mem[IA];
  else A <= A;
end

endmodule


// ****
module RAMS32B16KW (A, I, IA, DM, CK, CE, WE, BP);
parameter DWIDTH=32, AWIDTH=14, WORDS=16384;

input [AWIDTH-1:0] IA;
input CE;
input WE;
input [DWIDTH-1:0] I;
input CK;
input [DWIDTH-1:0] DM;
input BP;
output [DWIDTH-1:0] A;


reg [DWIDTH-1:0] A;
reg [DWIDTH-1:0] mem [WORDS-1:0];

always@(posedge CK) begin
  if (~CE & ~WE) mem[IA] <= I;
  else if (~CE) A <= mem[IA];
  else A <= A;
end

endmodule
