`timescale 1ps/1ps
module PktSel(
  lr_pkta_i_pktsel,
  node_pkta_i_pktsel,
  gen_pkta_i_pktsel,
  opr_pkta_i_pktsel,
  uni_opr_pkta_i_pktsel,
  mem_wen_pkta_i_pktsel,
  lr_pktb_i_pktsel,
  node_pktb_i_pktsel,
  gen_pktb_i_pktsel,
  opr_pktb_i_pktsel,
  uni_opr_pktb_i_pktsel,
  mem_wen_pktb_i_pktsel,
  aeb_i_pktsel,


  lr_o_pktsel,
  node_o_pktsel,
  gen_o_pktsel,
  opr_o_pktsel,
  uni_opr_o_pktsel,
  mem_wen_o_pktsel
  
  );
  
  
  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  input		lr_pkta_i_pktsel;
  input	[15:0]	node_pkta_i_pktsel;
  input	[11:0]	gen_pkta_i_pktsel;
  input	[31:0]	opr_pkta_i_pktsel;
  input		uni_opr_pkta_i_pktsel;
  input	[1:0]	mem_wen_pkta_i_pktsel;
  input		lr_pktb_i_pktsel;
  input	[15:0]	node_pktb_i_pktsel;
  input	[11:0]	gen_pktb_i_pktsel;
  input	[31:0]	opr_pktb_i_pktsel;
  input		uni_opr_pktb_i_pktsel;
  input	[1:0]	mem_wen_pktb_i_pktsel;
  input		aeb_i_pktsel;


  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  output        lr_o_pktsel;
  output [15:0]	node_o_pktsel;
  output [11:0]	gen_o_pktsel;
  output [31:0]	opr_o_pktsel;
  output 	uni_opr_o_pktsel;
  output [1:0]	mem_wen_o_pktsel;
  
  
  /***********************************************************/
  /*                        OUT                              */ 
  /***********************************************************/

  assign 	lr_o_pktsel = aeb_i_pktsel? lr_pktb_i_pktsel: lr_pkta_i_pktsel;
  assign 	node_o_pktsel = aeb_i_pktsel? node_pktb_i_pktsel: node_pkta_i_pktsel;
  assign 	gen_o_pktsel = aeb_i_pktsel? gen_pktb_i_pktsel: gen_pkta_i_pktsel;
  assign 	opr_o_pktsel = aeb_i_pktsel? opr_pktb_i_pktsel: opr_pkta_i_pktsel;
  assign 	uni_opr_o_pktsel = aeb_i_pktsel? uni_opr_pktb_i_pktsel: uni_opr_pkta_i_pktsel;
  assign 	mem_wen_o_pktsel = aeb_i_pktsel? mem_wen_pktb_i_pktsel: mem_wen_pkta_i_pktsel;


endmodule // PktSel
