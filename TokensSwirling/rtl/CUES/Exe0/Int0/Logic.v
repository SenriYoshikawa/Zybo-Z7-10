module Logic(
  opr0_i_log, 
  opr1_i_log,
  imm16_i_log,
  gen_i_log,
  logic_sel_i_log,
  r_sel_i_log,
  
  rslt_o_log,
  rslt_cc_o_log
  
  );
  

  //********************************
  input [31:0]	opr0_i_log;
  input [31:0]	opr1_i_log;
  input [15:0]	imm16_i_log;
  input [11:0]	gen_i_log;
  input [2:0]	logic_sel_i_log;
  input 	r_sel_i_log; // 0:oprR/1:imm
  
  output [31:0]	rslt_o_log;
  output [1:0]	rslt_cc_o_log;
  //********************************

  wire [31:0]	selected_oprb;
  wire [31:0]	tmp;
  wire [31:0]	ldz_tmp;
  wire 		zero;
  
  assign	selected_oprb = r_sel_i_log? {{16{1'b0}}, imm16_i_log}: opr1_i_log;


  assign 	ldz_tmp = ldz(opr0_i_log);

  function[31:0] ldz;
    input [31:0] in_ldz;
    casex(in_ldz)//sysnopsys parallel_case
      32'b1xxxxxxx_xxxxxxxx_xxxxxxxx_xxxxxxxx: ldz=32'h00;
      32'b01xxxxxx_xxxxxxxx_xxxxxxxx_xxxxxxxx: ldz=32'h01;
      32'b001xxxxx_xxxxxxxx_xxxxxxxx_xxxxxxxx: ldz=32'h02;
      32'b0001xxxx_xxxxxxxx_xxxxxxxx_xxxxxxxx: ldz=32'h03;
      32'b00001xxx_xxxxxxxx_xxxxxxxx_xxxxxxxx: ldz=32'h04;
      32'b000001xx_xxxxxxxx_xxxxxxxx_xxxxxxxx: ldz=32'h05;
      32'b0000001x_xxxxxxxx_xxxxxxxx_xxxxxxxx: ldz=32'h06;
      32'b00000001_xxxxxxxx_xxxxxxxx_xxxxxxxx: ldz=32'h07;
      32'b00000000_1xxxxxxx_xxxxxxxx_xxxxxxxx: ldz=32'h08;
      32'b00000000_01xxxxxx_xxxxxxxx_xxxxxxxx: ldz=32'h09;
      32'b00000000_001xxxxx_xxxxxxxx_xxxxxxxx: ldz=32'h0a;
      32'b00000000_0001xxxx_xxxxxxxx_xxxxxxxx: ldz=32'h0b;
      32'b00000000_00001xxx_xxxxxxxx_xxxxxxxx: ldz=32'h0c;
      32'b00000000_000001xx_xxxxxxxx_xxxxxxxx: ldz=32'h0d;
      32'b00000000_0000001x_xxxxxxxx_xxxxxxxx: ldz=32'h0e;
      32'b00000000_00000001_xxxxxxxx_xxxxxxxx: ldz=32'h0f;
      32'b00000000_00000000_1xxxxxxx_xxxxxxxx: ldz=32'h10;
      32'b00000000_00000000_01xxxxxx_xxxxxxxx: ldz=32'h11;
      32'b00000000_00000000_001xxxxx_xxxxxxxx: ldz=32'h12;
      32'b00000000_00000000_0001xxxx_xxxxxxxx: ldz=32'h13;
      32'b00000000_00000000_00001xxx_xxxxxxxx: ldz=32'h14;
      32'b00000000_00000000_000001xx_xxxxxxxx: ldz=32'h15;
      32'b00000000_00000000_0000001x_xxxxxxxx: ldz=32'h16;
      32'b00000000_00000000_00000001_xxxxxxxx: ldz=32'h17;
      32'b00000000_00000000_00000000_1xxxxxxx: ldz=32'h18;
      32'b00000000_00000000_00000000_01xxxxxx: ldz=32'h19;
      32'b00000000_00000000_00000000_001xxxxx: ldz=32'h1a;
      32'b00000000_00000000_00000000_0001xxxx: ldz=32'h1b;
      32'b00000000_00000000_00000000_00001xxx: ldz=32'h1c;
      32'b00000000_00000000_00000000_000001xx: ldz=32'h1d;
      32'b00000000_00000000_00000000_0000001x: ldz=32'h1e;
      32'b00000000_00000000_00000000_00000001: ldz=32'h1f;
      32'b00000000_00000000_00000000_00000000: ldz=32'hffffffff;
      default: ldz=32'bx;
    endcase // casex(opr0)
  endfunction // ldz
  
  
  assign 	tmp = result_selector(
  					opr0_i_log,
  					selected_oprb,
  					gen_i_log,
  					logic_sel_i_log, 
  					ldz_tmp
  					);
  
  function [31:0] result_selector;
    input [31:0] 	opr0, opr1;
    input [11:0] 	gen;
    input [2:0] 	logic_sel;
    input [31:0]	ldz_tmp;
      case(logic_sel)
        3'b001: result_selector = opr0 & opr1;
        3'b010: result_selector = opr0 | opr1;
        3'b011: result_selector = ~opr0;
        3'b100: result_selector = opr0 ^ opr1;
        3'b101: result_selector = ^opr0;
        3'b110: result_selector = ldz_tmp;
        3'b111: result_selector = {{16{opr1[15]}},opr1[15:0]};
        3'b000: result_selector = {{20{1'b0}},gen};
        default: result_selector = 32'bx;
      endcase // case(logic_sel)
  endfunction // result_selector

  assign		zero = ~|tmp;
  
  assign		rslt_o_log = tmp; 
  assign		rslt_cc_o_log = {1'b0, zero};
 
endmodule // Logic
