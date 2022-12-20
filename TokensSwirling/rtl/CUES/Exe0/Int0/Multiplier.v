module Multiplier(
  opr0_i_mul, 
  opr1_i_mul,
  imm16_i_mul,
  gen_i_mul,
  tag_i_mul,
  sat_i_mul,
  r_sel_i_mul,
  imm_sel_i_mul,
  
  rslt_o_mul,
  rslt_cc_o_mul,
  rslt_tag_o_mul
  
  );
  

  //********************************
  input signed [31:0]	opr0_i_mul;
  input signed [15:0]	opr1_i_mul;
  input signed [15:0]	imm16_i_mul;
  input [11:0]		gen_i_mul;
  input 		tag_i_mul;
  input 		sat_i_mul; // saturation
  input 		r_sel_i_mul; // 0:oprR/1:imm
  input 		imm_sel_i_mul;// 0:imm5/1:imm16
  
  output signed [31:0]	rslt_o_mul;
  output [1:0]		rslt_cc_o_mul;
  output [11:0]		rslt_tag_o_mul;
  //********************************

  wire signed [31:0]	selected_opra;
  wire signed [15:0]	selected_oprb;
  wire signed [15:0]	imm_opr;
  wire signed [47:0] 	rslt_tmp0;
  wire signed [31:0] 	rslt_tmp1;
  wire signed [31:0] 	rslt_tmp2;
  wire			plus_rslt;
  wire 			overflow_n;
  wire 			overflow_tag;
  wire			zero;
  
  assign	selected_opra = tag_i_mul? {{20{1'b0}}, gen_i_mul}:
  					   opr0_i_mul;
  assign	imm_opr = imm_sel_i_mul? {{11{1'b0}}, imm16_i_mul[4:0]}:
  					 imm16_i_mul;
  assign	selected_oprb = r_sel_i_mul? imm_opr: opr1_i_mul[15:0];
  
  assign 	rslt_tmp0 = selected_opra * selected_oprb;
  
  assign	plus_rslt = (~((selected_opra[31]) ^ (selected_oprb[15])));
  assign	overflow_n = plus_rslt & (|rslt_tmp0[47:31]);
  assign	overflow_tag = (|rslt_tmp0[47:12]);
  			   
  assign	rslt_tmp1 = (sat_i_mul & overflow_n)?
  			    {1'b0,{31{1'b1}}}: {rslt_tmp0[47],rslt_tmp0[30:0]};
  			   
  assign	zero = ((~(|selected_opra)) || (~(|selected_oprb)));

  assign	rslt_o_mul = tag_i_mul? opr0_i_mul: rslt_tmp1; 
  assign	rslt_cc_o_mul = tag_i_mul? {overflow_tag, zero}:
  					   {overflow_n, zero};
  assign	rslt_tag_o_mul = tag_i_mul? rslt_tmp1[11:0]: gen_i_mul;
 
endmodule // Multiplier
