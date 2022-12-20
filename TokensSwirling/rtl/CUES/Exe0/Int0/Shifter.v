module Shifter(
  opr0_i_sh,
  opr1_i_sh,
  imm5_i_sh,
  shift_sel_i_sh,
  drct_sel_i_sh,
  r_sel_i_sh,
  option_i_sh,
  
  rslt_o_sh,
  rslt_cc_o_sh
  
  );
  
  
  //********************************
  input [31:0]	opr0_i_sh;
  input [31:0]	opr1_i_sh;
  input [4:0]	imm5_i_sh;
  input [1:0]	shift_sel_i_sh;
  input		drct_sel_i_sh;
  input 	r_sel_i_sh; // 0:oprR/1:imm
  input [1:0]	option_i_sh;
  
  output [31:0]	rslt_o_sh;
  output [1:0]	rslt_cc_o_sh;
  //********************************

  wire [4:0]	selected_oprb;
  wire [31:0]	shifted_tmp;
  wire [31:0]	optioned_tmp;
  wire		sign;
  wire		zero;
  
  assign	selected_oprb = r_sel_i_sh? imm5_i_sh: opr1_i_sh[4:0];

  assign 	sign = opr0_i_sh[31];
  
  assign 	shifted_tmp = shifter( opr0_i_sh,
				       selected_oprb,
				       shift_sel_i_sh,
				       drct_sel_i_sh,
				       sign
				     );
 
  function [31:0] shifter;
    input [31:0] opr0;
    input [4:0]  opr1;
    input [1:0]  shift_sel;
    input	 drct_sel;
    input 	 sign;
    
    casex({shift_sel, drct_sel})//synopsys parallel_case
      //shift_left(shift_sel = 00, drct_sel = 0)//
      {3'b00_0}: shifter = opr0 >> opr1;
      //shift_right(shift_sel = 00, drct_sel = 1)//
      {3'b00_1}: shifter = opr0 << opr1;
      //alithmetic_shift(shift_sel = 11, drct_sel = x)//
      {3'b11_x}: shifter = $signed(opr0) >>> opr1;
      default: shifter = {32{1'b1}};
    endcase
  endfunction // shifter
  
  
  assign	optioned_tmp = shift_option( shifted_tmp,
  					     opr1_i_sh,
  					     option_i_sh
  					   );
  
  function [31:0] shift_option;
    input [31:0] shifted_tmp;
    input [31:0] opr1;
    input [1:0]	 option;
    case(option)
      2'b00: shift_option = shifted_tmp;
      2'b01: shift_option = shifted_tmp & opr1;
      2'b11: shift_option = shifted_tmp | opr1;
      
      default: shift_option = {32{1'b1}};
    endcase
  endfunction
  
  
  assign	zero = ~|optioned_tmp;
  
  assign	rslt_o_sh = optioned_tmp; 
  assign	rslt_cc_o_sh = {1'b0, zero};
      
endmodule //Shifter
