`timescale 1ps/1ps
module Sw
 (//Input:  name_i_modulename
  //Output: name_o_modulename

  //from CPB
  lr_i_sw,			//IN
  node_i_sw,
  gen_i_sw,
  opr_i_sw,
  pe_num_i_sw,
  f_mem_w_i_sw,
  uni_opr_i_sw,

  rst,
  clk,
  
  
  //to ICN
  pe_num_icn_o_sw,			//OUT
  mem_w_icn_o_sw,
  lr_icn_o_sw,
  node_icn_o_sw,
  gen_icn_o_sw,
  opr_icn_o_sw,
  uni_opr_icn_o_sw,
  //to Mer
  lr_mer_o_sw,	
  node_mer_o_sw,
  gen_mer_o_sw,
  opr_mer_o_sw,
  uni_opr_mer_o_sw

  
  );


  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  //from Mem1
  input		      lr_i_sw;	
  input	[15:0]	node_i_sw;
  input	[11:0]	gen_i_sw;
  input	[31:0]	opr_i_sw;
  input	[2:0]	  pe_num_i_sw;
  input		      f_mem_w_i_sw;
  input		      uni_opr_i_sw;

  input		      rst;
  input		      clk;


  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  //to ICN
  output [2:0]	pe_num_icn_o_sw;
  output [1:0]	mem_w_icn_o_sw;
  output 	      lr_icn_o_sw;
  output [15:0]	node_icn_o_sw;
  output [11:0]	gen_icn_o_sw;
  output [31:0]	opr_icn_o_sw;
  output 	      uni_opr_icn_o_sw;
  //to Mer
  output 	      lr_mer_o_sw;
  output [15:0]	node_mer_o_sw;
  output [11:0]	gen_mer_o_sw;
  output [31:0]	opr_mer_o_sw;
  output 	      uni_opr_mer_o_sw;


  /***********************************************************/
  /*                 DEFINITION OF REGISTER                  */
  /***********************************************************/

  //Pipeline Register at Sw/Mer,ICN
  reg         f_mem_w_reg_sw;
  reg  [2:0]  pe_num_reg_sw;
  reg         lr_reg_sw;
  reg  [15:0] node_reg_sw;
  reg  [11:0] gen_reg_sw;
  reg  [31:0] opr_reg_sw;
  reg         uni_opr_reg_sw;


  /***********************************************************/
  /*                        OUT                              */ 
  /***********************************************************/

  assign 		pe_num_icn_o_sw = pe_num_reg_sw;
  
  assign 		mem_w_icn_o_sw = f_mem_w_reg_sw? 2'b11: 2'b00;

  assign 		lr_icn_o_sw = lr_reg_sw;
  assign 		lr_mer_o_sw = lr_reg_sw;
  
  assign 		node_icn_o_sw = node_reg_sw;
  assign 		node_mer_o_sw = node_reg_sw;
  
  assign 		gen_icn_o_sw = gen_reg_sw;
  assign 		gen_mer_o_sw = gen_reg_sw;
  
  assign		opr_icn_o_sw = opr_reg_sw;
  assign		opr_mer_o_sw = opr_reg_sw;
  
  assign		uni_opr_icn_o_sw = uni_opr_reg_sw;
  assign		uni_opr_mer_o_sw = uni_opr_reg_sw;


  /***********************************************************/
  /*                  PipeLine Register (Sw/)                */
  /***********************************************************/

  always @(posedge clk  or  negedge rst) begin
    if (rst == 1'b0) begin
      f_mem_w_reg_sw      <= 1'b0;
      pe_num_reg_sw       <= {3{1'b0}};
      node_reg_sw         <= {16{1'b0}};
      gen_reg_sw          <= {12{1'b0}};
      opr_reg_sw          <= {32{1'b0}};
      uni_opr_reg_sw      <= 1'b0;
    end else begin
      f_mem_w_reg_sw      <= f_mem_w_i_sw;
      pe_num_reg_sw       <= pe_num_i_sw;
      lr_reg_sw           <= lr_i_sw;
      node_reg_sw         <= node_i_sw;
      gen_reg_sw          <= gen_i_sw;
      opr_reg_sw          <= opr_i_sw;
      uni_opr_reg_sw      <= uni_opr_i_sw;
    end
  end


endmodule //Sw
