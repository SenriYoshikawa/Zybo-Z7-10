`timescale 1ps/1ps
module Mem0
 (//Input:  name_i_modulename
  //Output: name_o_modulename

  //from Exe1
  opr0_i_mem0,				//IN
  opr1_i_mem0,
  dm_addr_i_mem0,
  mem_wen_i_mem0,
  dm_dopc_i_mem0,
  pe_out_i_mem0,
  pe_num_i_mem0,
  f_mem_w_i_mem0,
  next_lr_i_mem0,
  next_node_i_mem0,
  gen_i_mem0,
  next_uni_opr_i_mem0,

  rst,
  clk,


  //to Mem1
  opr0_o_mem0,				//OUT
  opr1_o_mem0,
  dm_addr_o_mem0,
  mem_wen_o_mem0,
  dm_dopc_o_mem0,
  pe_out_o_mem0,
  pe_num_o_mem0,
  f_mem_w_o_mem0,
  next_lr_o_mem0,
  next_node_o_mem0,
  gen_o_mem0,
  next_uni_opr_o_mem0,
  
  w_en_cex_o_mem0


  );


  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  //from Exe1
  input [31:0]	opr0_i_mem0;
  input [31:0]	opr1_i_mem0;
  input [13:0]	dm_addr_i_mem0;
  input 	mem_wen_i_mem0;
  input [2:0]	dm_dopc_i_mem0;
  input 	pe_out_i_mem0;
  input [2:0]	pe_num_i_mem0;
  input 	f_mem_w_i_mem0;
  input 	next_lr_i_mem0;
  input [15:0]	next_node_i_mem0;
  input [11:0]	gen_i_mem0;
  input 	next_uni_opr_i_mem0;

  input 	rst;
  input 	clk;


  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  //to Mem1
  output [31:0]	opr0_o_mem0;
  output [31:0]	opr1_o_mem0;
  output [13:0]	dm_addr_o_mem0;
  output 	mem_wen_o_mem0;
  output [2:0]	dm_dopc_o_mem0;
  output 	pe_out_o_mem0;
  output [2:0]	pe_num_o_mem0;
  output 	f_mem_w_o_mem0;
  output 	next_lr_o_mem0;
  output [15:0]	next_node_o_mem0;
  output [11:0]	gen_o_mem0;
  output 	next_uni_opr_o_mem0;
  
  output	w_en_cex_o_mem0;


  /***********************************************************/
  /*                 DEFINITION OF REGISTER                  */
  /***********************************************************/

  //Pipeline Register at Mem0/Mem1
  reg [31:0]	opr0_reg_mem0;
  reg [31:0]	opr1_reg_mem0;
  reg [13:0]	dm_addr_reg_mem0;
  reg 		mem_wen_reg_mem0;
  reg [2:0]	dm_dopc_reg_mem0;
  reg 		pe_out_reg_mem0;
  reg [2:0]	pe_num_reg_mem0;
  reg 		f_mem_w_reg_mem0;
  reg 		next_lr_reg_mem0;
  reg [15:0]	next_node_reg_mem0;
  reg [11:0]	gen_reg_mem0;
  reg		next_uni_opr_reg_mem0;


  /***********************************************************/
  /*                        OUT                              */ 
  /***********************************************************/

  assign	opr0_o_mem0 = opr0_reg_mem0;
  assign	opr1_o_mem0 = opr1_reg_mem0;
  assign	dm_addr_o_mem0 = dm_addr_reg_mem0;
  assign	mem_wen_o_mem0 = mem_wen_reg_mem0;
  assign	dm_dopc_o_mem0 = dm_dopc_reg_mem0;
  assign	pe_out_o_mem0 = pe_out_reg_mem0;
  assign	pe_num_o_mem0 = pe_num_reg_mem0;
  assign	f_mem_w_o_mem0 = f_mem_w_reg_mem0;
  assign	next_lr_o_mem0 = next_lr_reg_mem0;
  assign	next_node_o_mem0 = next_node_reg_mem0;
  assign	gen_o_mem0 = gen_reg_mem0;
  assign	next_uni_opr_o_mem0 = next_uni_opr_reg_mem0;

  assign	w_en_cex_o_mem0 = ~(mem_wen_reg_mem0 | dm_dopc_reg_mem0[0]);


  /***********************************************************/
  /*              PipeLine Register (Mem0/Mem1)               */
  /***********************************************************/

  always @(posedge clk  or  negedge rst) begin
    if (rst == 1'b0) begin
      opr0_reg_mem0		<= {32{1'b0}};
      opr1_reg_mem0		<= {32{1'b0}};
      dm_addr_reg_mem0		<= {13{1'b0}};
      mem_wen_reg_mem0		<= 1'b0;
      dm_dopc_reg_mem0		<= {3{1'b0}};
      pe_out_reg_mem0		<= 1'b0;
      pe_num_reg_mem0		<= {3{1'b0}};
      f_mem_w_reg_mem0		<= 1'b0;
      next_lr_reg_mem0		<= 1'b0;
      next_node_reg_mem0	<= {16{1'b0}};
      gen_reg_mem0		<= {12{1'b0}};
      next_uni_opr_reg_mem0	<= 1'b0;
    end else begin
      opr0_reg_mem0		<= opr0_i_mem0;
      opr1_reg_mem0		<= opr1_i_mem0;
      dm_addr_reg_mem0		<= dm_addr_i_mem0;
      mem_wen_reg_mem0		<= mem_wen_i_mem0;
      dm_dopc_reg_mem0		<= dm_dopc_i_mem0;
      pe_out_reg_mem0		<= pe_out_i_mem0;
      pe_num_reg_mem0		<= pe_num_i_mem0;
      f_mem_w_reg_mem0		<= f_mem_w_i_mem0;
      next_lr_reg_mem0		<= next_lr_i_mem0;
      next_node_reg_mem0	<= next_node_i_mem0;
      gen_reg_mem0		<= gen_i_mem0;
      next_uni_opr_reg_mem0	<= next_uni_opr_i_mem0;
    end
  end


endmodule //Mem0
