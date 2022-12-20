`timescale 1ps/1ps
module Mem1
  (//Input:  name_i_modulename
  //Output: name_o_modulename

  //from Mem0
  opr0_i_mem1,						//IN
  opr1_i_mem1,
  dm_addr_i_mem1,
  mem_wen_i_mem1,
  dm_dopc_i_mem1,
  pe_out_i_mem1,
  pe_num_i_mem1,
  f_mem_w_i_mem1,
  next_lr_i_mem1,
  next_node_i_mem1,
  gen_i_mem1,
  next_uni_opr_i_mem1,

  rst,
  clk,

  b_clk, // bist clock
  bist_mode_i_mem1,

  //to Sw
  opr0_o_mem1,						//OUT
  dm_data_valid_o_mem1,
  dm_data_o_mem1,
  pe_out_o_mem1,
  pe_num_o_mem1,
  f_mem_w_o_mem1,
  next_lr_o_mem1,
  next_node_o_mem1,
  gen_o_mem1,
  next_uni_opr_o_mem1,

  bistfail_o_mem1,
  bistfinish_o_mem1

  );


  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  //from Mem0
  input [31:0]	opr0_i_mem1;
  input [31:0]	opr1_i_mem1;
  input [13:0]	dm_addr_i_mem1;
  input 	mem_wen_i_mem1;
  input [1:0] 	dm_dopc_i_mem1;
  input 	pe_out_i_mem1;
  input [2:0]	pe_num_i_mem1;
  input 	f_mem_w_i_mem1;
  input 	next_lr_i_mem1;
  input [15:0]	next_node_i_mem1;
  input [11:0]	gen_i_mem1;
  input 	next_uni_opr_i_mem1;

  input 	rst;
  input 	clk;
  
  input 	b_clk;
  input 	bist_mode_i_mem1;


  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  //to Sw
  output [31:0]	opr0_o_mem1;
  output 	dm_data_valid_o_mem1;
  output [31:0]	dm_data_o_mem1;
  output 	pe_out_o_mem1;
  output [2:0]	pe_num_o_mem1;
  output 	f_mem_w_o_mem1;
  output 	next_lr_o_mem1;
  output [15:0]	next_node_o_mem1;
  output [11:0]	gen_o_mem1;
  output 	next_uni_opr_o_mem1;

  output 	bistfail_o_mem1;
  output 	bistfinish_o_mem1;


  /***********************************************************/
  /*                 DEFINITION OF REGISTER                  */
  /***********************************************************/

  //Pipeline Register at Mem1/Sw
  reg [31:0]	opr0_reg_mem1;
  reg [31:0]	opr1_reg_mem1;
  reg [13:0]	dm_addr_reg_mem1;
  reg [1:0]	dm_dopc_reg_mem1;
  reg 		pe_out_reg_mem1;
  reg [2:0]	pe_num_reg_mem1;
  reg 		f_mem_w_reg_mem1;
  reg 		next_lr_reg_mem1;
  reg [15:0] 	next_node_reg_mem1;
  reg [11:0] 	gen_reg_mem1;
  reg 		next_uni_opr_reg_mem1;


  /***********************************************************/
  /*                        OUT                              */ 
  /***********************************************************/

  assign 	 opr0_o_mem1 = (&dm_dopc_reg_mem1)? opr1_reg_mem1: opr0_reg_mem1;
  assign 	 pe_out_o_mem1 = pe_out_reg_mem1;
  assign 	 pe_num_o_mem1 = pe_num_reg_mem1;
  assign 	 f_mem_w_o_mem1 = f_mem_w_reg_mem1;
  assign 	 next_lr_o_mem1 = next_lr_reg_mem1;
  assign 	 next_node_o_mem1 = next_node_reg_mem1;
  assign 	 gen_o_mem1 = gen_reg_mem1;
  assign 	 next_uni_opr_o_mem1 = next_uni_opr_reg_mem1;
  assign 	 dm_data_valid_o_mem1 = dm_dopc_reg_mem1[1] & ~dm_dopc_reg_mem1[0];


  /***********************************************************/
  /*              PipeLine Register (Mem1/Sw)                */
  /***********************************************************/

  always @(posedge clk  or  negedge rst) begin
    if (rst == 1'b0) begin
      opr0_reg_mem1      	    <= {32{1'b0}};
      opr1_reg_mem1      	    <= {32{1'b0}};
      dm_addr_reg_mem1   	    <= {14{1'b0}};
      dm_dopc_reg_mem1   	    <= 2'b00;
      pe_out_reg_mem1    	    <= 1'b0;
      pe_num_reg_mem1    	    <= {3{1'b0}};
      f_mem_w_reg_mem1        <= 1'b0;
      next_lr_reg_mem1   	    <= 1'b0;
      next_node_reg_mem1 	    <= {16{1'b0}};
      gen_reg_mem1       	    <= {12{1'b0}};
      next_uni_opr_reg_mem1 	<= 1'b0;
    end else begin
      opr0_reg_mem1      	    <= opr0_i_mem1;
      opr1_reg_mem1      	    <= opr1_i_mem1;
      dm_addr_reg_mem1   	    <= dm_addr_i_mem1;
      dm_dopc_reg_mem1   	    <= dm_dopc_i_mem1;
      pe_out_reg_mem1    	    <= pe_out_i_mem1;
      pe_num_reg_mem1    	    <= pe_num_i_mem1;
      f_mem_w_reg_mem1        <= f_mem_w_i_mem1;
      next_lr_reg_mem1   	    <= next_lr_i_mem1;
      next_node_reg_mem1 	    <= next_node_i_mem1;
      gen_reg_mem1       	    <= gen_i_mem1;
      next_uni_opr_reg_mem1   <= next_uni_opr_i_mem1;
    end
  end
  
  
  /***********************************************************/
  /*                     INCLUDE DM                          */
  /***********************************************************/
  
  DM DM(
    //input
	  .opr0_i_dm( opr0_i_mem1 ),
	  .dm_addr_i_dm( dm_addr_i_mem1 ),
	  .mem_wen_i_dm( mem_wen_i_mem1 ),
	  .dm_dopc_i_dm( dm_dopc_i_mem1 ),

	  .rst( rst ),
	  .clk( clk ),

	  .b_clk( b_clk ),
	  .bist_mode_i_dm( bist_mode_i_mem1 ),


	 //output
	  .dm_data_o_dm( dm_data_o_mem1 ),

    .bistfail_o_dm( bistfail_o_mem1 ),
    .bistfinish_o_dm( bistfinish_o_mem1 )


	 );


endmodule //Mem1
