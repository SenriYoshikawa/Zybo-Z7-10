`timescale 1ps/1ps
module SB
 (//Input:  name_i_modulename
  //Output: name_o_modulename

  //from Mem1
  opr0_i_sb,			//IN
  dm_data_valid_i_sb,
  dm_data_i_sb,
  pe_out_i_sb,
  pe_num_i_sb,
  f_mem_w_i_sb,
  next_lr_i_sb,
  next_node_i_sb,
  gen_i_sb,
  next_uni_opr_i_sb,

  rst,
  clk,
  
  
  //to Sw
  lr_sw_o_sb,				//OUT
  node_sw_o_sb,
  gen_sw_o_sb,
  opr_sw_o_sb,
  pe_out_sw_o_sb,
  pe_num_sw_o_sb,
  f_mem_w_sw_o_sb,
  uni_opr_sw_o_sb,

  //to CPMer
  node_sm_o_sb,			//OUT
  gen_sm_o_sb,
  opr_sm_o_sb,
  mem_wen_sm_o_sb
  
  
  );


  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  //from Mem1
  input [31:0]	opr0_i_sb;
  input 	      dm_data_valid_i_sb;
  input [31:0]	dm_data_i_sb;
  input 	      pe_out_i_sb;
  input [2:0]	  pe_num_i_sb;
  input 	      f_mem_w_i_sb;
  input 	      next_lr_i_sb;
  input [15:0]	next_node_i_sb;
  input [11:0]	gen_i_sb;
  input 	      next_uni_opr_i_sb;

  input 	      rst;
  input 	      clk;


  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  //to Sw
  output 	      lr_sw_o_sb;
  output [15:0]	node_sw_o_sb;
  output [11:0]	gen_sw_o_sb;
  output [31:0]	opr_sw_o_sb;
  output 	      pe_out_sw_o_sb;
  output [2:0]	pe_num_sw_o_sb;
  output 	      f_mem_w_sw_o_sb;
  output 	      uni_opr_sw_o_sb;
  
  //to CPMer
  output [15:0]	node_sm_o_sb;
  output [11:0]	gen_sm_o_sb;
  output [31:0]	opr_sm_o_sb;
  output [1:0]	mem_wen_sm_o_sb;


  /***********************************************************/
  /*                 DEFINITION OF REGISTER                  */
  /***********************************************************/

  //Pipeline Register at SB/Sw,CPMer
  reg	[31:0]	opr0_reg_sb;
  reg		      dm_data_valid_reg_sb;
  reg	[31:0]	dm_data_reg_sb;
  reg		      pe_out_reg_sb;
  reg	[2:0]	  pe_num_reg_sb;
  reg		      f_mem_w_reg_sb;
  reg		      uni_opr_reg_sb;
  reg		      next_lr_reg_sb;
  reg	[15:0]	next_node_reg_sb;
  reg	[11:0]	gen_reg_sb;


  /***********************************************************/
  /*                        OUT                              */ 
  /***********************************************************/

  assign 		lr_sw_o_sb = next_lr_reg_sb;
  
  assign 		node_sw_o_sb = next_node_reg_sb;
  assign 		node_sm_o_sb = next_node_reg_sb;
  
  assign 		gen_sw_o_sb = gen_reg_sb;
  assign 		gen_sm_o_sb = gen_reg_sb;
  
  assign		opr_sw_o_sb = (dm_data_valid_reg_sb)? dm_data_reg_sb: opr0_reg_sb;
  assign		opr_sm_o_sb = (dm_data_valid_reg_sb)? dm_data_reg_sb: opr0_reg_sb;
  
  assign 		mem_wen_sm_o_sb = (f_mem_w_reg_sb)? 2'b11: 2'b00;
  
  assign		pe_out_sw_o_sb = pe_out_reg_sb;
  assign		pe_num_sw_o_sb = pe_num_reg_sb;
  assign		f_mem_w_sw_o_sb = f_mem_w_reg_sb;
  assign		uni_opr_sw_o_sb = uni_opr_reg_sb;


  /***********************************************************/
  /*              PipeLine Register (SB/)                */
  /***********************************************************/

  always @(posedge clk  or  negedge rst) begin
    if (rst == 1'b0) begin
      opr0_reg_sb		        <= {32{1'b0}};
      dm_data_valid_reg_sb	<= 1'b0;
      dm_data_reg_sb		    <= {32{1'b0}};
      pe_out_reg_sb		      <= 1'b0;
      pe_num_reg_sb		      <= {3{1'b0}};
      f_mem_w_reg_sb		    <= 1'b0;
      uni_opr_reg_sb		    <= 1'b0;
      next_lr_reg_sb		    <= 1'b0;
      next_node_reg_sb	    <= {16{1'b0}};
      gen_reg_sb		        <= {12{1'b0}};
    end else begin
      opr0_reg_sb		        <= opr0_i_sb;
      dm_data_valid_reg_sb	<= dm_data_valid_i_sb;
      dm_data_reg_sb		    <= dm_data_i_sb;
      pe_out_reg_sb		      <= pe_out_i_sb;
      pe_num_reg_sb		      <= pe_num_i_sb;
      f_mem_w_reg_sb		    <= f_mem_w_i_sb;
      uni_opr_reg_sb		    <= next_uni_opr_i_sb;
      next_lr_reg_sb		    <= next_lr_i_sb;
      next_node_reg_sb	    <= next_node_i_sb;
      gen_reg_sb		        <= gen_i_sb;
    end
  end


endmodule //SB
