`timescale 1ps/1ps
module sFC1
  (//Input:  name_i_modulename
   //Output: name_o_modulename

  lr_i_sfc1,					//IN
  node_i_sfc1,
  gen_i_sfc1,
  opr_i_sfc1,
  mem_wen_i_sfc1,
  mtch_data_i_sfc1,
  mtch_rslt_cex_i_sfc1,
  nInterC_S_sFC0_uC_uCEX,
  nInterC_A_sSM_uCM_uCEX,
 
  lopen,
  rst,


  node_o_sfc1,					//OUT
  gen_o_sfc1,
  opr0_o_sfc1,
  opr1_o_sfc1,
  mem_wen_o_sfc1,
  nInterC_S_uCEX_sSM_uCM,
  nInterC_A_uCEX_sFC0_uC
  );


  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  //from FC0
  input		      lr_i_sfc1;
  input [15:0] 	node_i_sfc1;
  input [11:0] 	gen_i_sfc1;
  input [31:0] 	opr_i_sfc1;
  input [1:0] 	mem_wen_i_sfc1;
  input [31:0] 	mtch_data_i_sfc1;
  input 	      mtch_rslt_cex_i_sfc1;
  input 	      nInterC_S_sFC0_uC_uCEX;
  //from SM
  input 	      nInterC_A_sSM_uCM_uCEX;

  input         lopen;
  input 	      rst;


  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  //to SM
  output [15:0] node_o_sfc1;
  output [11:0] gen_o_sfc1;
  output [31:0] opr0_o_sfc1;
  output [31:0] opr1_o_sfc1;
  output [1:0] 	mem_wen_o_sfc1;
  output	nInterC_S_uCEX_sSM_uCM;
  //to FC0
  output	nInterC_A_uCEX_sFC0_uC;


  /***********************************************************/
  /*                 DEFINITION OF WIRE                      */
  /***********************************************************/

  wire		clk_sfc1;
 


  /***********************************************************/
  /*                       INCLUDE CEX                       */
  /***********************************************************/

  wire send_delay;
  wire ack_delay;

  CELEMENT_FC1 uCEX_FC1(
		.RESETN( rst ),
		.EXBIN( mtch_rslt_cex_i_sfc1 ),
		.SENDIN( nInterC_S_sFC0_uC_uCEX ),
		.ACKIN( nInterC_A_sSM_uCM_uCEX ),

		.SENDOUT( send_delay ),
		.ACKOUT( ack_delay ),
		.CP( clk_sfc1 ),
    .LOPEN( lopen )
		);

  buf #(14272, 15255) (nInterC_S_uCEX_sSM_uCM, send_delay);
  buf #(8090, 3742) (nInterC_A_uCEX_sFC0_uC, ack_delay);


  FC1 iFC1(
		.lr_i_fc1( lr_i_sfc1 ),
		.node_i_fc1( node_i_sfc1 ),
		.gen_i_fc1( gen_i_sfc1 ),
		.opr_i_fc1( opr_i_sfc1 ),
		.mem_wen_i_fc1( mem_wen_i_sfc1 ),
		.mtch_data_i_fc1( mtch_data_i_sfc1 ),
		.rst( rst ),
		.clk( clk_sfc1 ),
		
		.node_o_fc1( node_o_sfc1 ),
		.gen_o_fc1( gen_o_sfc1 ),
		.opr0_o_fc1( opr0_o_sfc1 ),
		.opr1_o_fc1( opr1_o_sfc1 ),
		.mem_wen_o_fc1( mem_wen_o_sfc1 )
		);

endmodule //sFC1
