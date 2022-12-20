`timescale 1ps/1ps
module sMer
 (//Input:  name_i_modulename
  //Output: name_o_modulename

  lr_sw_i_smer,				//IN
  node_sw_i_smer,
  gen_sw_i_smer,
  opr_sw_i_smer,
  uni_opr_sw_i_smer,
  lr_icn_i_smer,
  node_icn_i_smer,
  gen_icn_i_smer,
  opr_icn_i_smer,
  uni_opr_icn_i_smer,
  mem_wen_icn_i_smer,
  nInterC_S_sSw_uCB_uCM,
  nInterC_S_sICN_uC_uCM,
  nInterC_A_sFC0_uC_uCM,

  lopen,
  rst,


  lr_o_smer,				//OUT
  node_o_smer,
  gen_o_smer,
  opr_o_smer,
  uni_opr_o_smer,
  mem_wen_o_smer,
  nInterC_S_uCM_sFC0_uC,
  nInterC_A_uCM_sSw_uCB,
  nInterC_A_uCM_sICN_uC  
  );


  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  //from Sw
  input		      lr_sw_i_smer;
  input	[15:0]	node_sw_i_smer;
  input	[11:0]	gen_sw_i_smer;
  input	[31:0]	opr_sw_i_smer;
  input 	      uni_opr_sw_i_smer;
  input		      nInterC_S_sSw_uCB_uCM;
  //from ICN
  input		      lr_icn_i_smer;
  input	[15:0]	node_icn_i_smer;
  input	[11:0]	gen_icn_i_smer;
  input	[31:0]	opr_icn_i_smer;
  input		      uni_opr_icn_i_smer;
  input	[1:0]	  mem_wen_icn_i_smer;
  input		      nInterC_S_sICN_uC_uCM;
  //from TC0
  input		      nInterC_A_sFC0_uC_uCM;

  input         lopen;
  input		      rst;

		
  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  //to TC0
  output	      lr_o_smer;
  output [15:0]	node_o_smer;
  output [11:0]	gen_o_smer;
  output [31:0]	opr_o_smer;
  output 	      uni_opr_o_smer;
  output [1:0]	mem_wen_o_smer;
  output	      nInterC_S_uCM_sFC0_uC;
  //to Sw
  output	      nInterC_A_uCM_sSw_uCB;
  //to IFOFO
  output	      nInterC_A_uCM_sICN_uC;
  

  /***********************************************************/
  /*                   DEFINITION OF WIRE                    */
  /***********************************************************/

  wire		clka_smer;
  wire		clkb_smer;
  wire		aeb_smer;


  /***********************************************************/
  /*                       INCLUDE CM                        */
  /***********************************************************/

  wire sendib_delay;
  wire ackoa_delay;
  wire ackob_delay;

 
  CELEMENT_Mer uCM_Mer(
		.RESETN( rst ),
		.SENDINA( nInterC_S_sSw_uCB_uCM ),
		// .SENDINB( nInterC_S_sICN_uC_uCM ),
    .SENDINB( sendib_delay ),
		.ACKIN( nInterC_A_sFC0_uC_uCM ),
		
		.SENDOUT( nInterC_S_uCM_sFC0_uC ),
		//.ACKOUTA( nInterC_A_uCM_sSw_uCB ),
		.ACKOUTA( ackoa_delay ),
		//.ACKOUTB( nInterC_A_uCM_sICN_uC ),
		.ACKOUTB( ackob_delay ),
		.AEBOUT( aeb_smer ),
		.CPA( clka_smer ),
		.CPB( clkb_smer ),
    .LOPEN( lopen )
		);

  buf #(4276, 4276) (sendib_delay, nInterC_S_sICN_uC_uCM);
  buf #(7796, 3754) (nInterC_A_uCM_sSw_uCB, ackoa_delay);
  buf #(7527, 3935) (nInterC_A_uCM_sICN_uC, ackob_delay);

  Mer iMer(
		.lr_sw_i_mer( lr_sw_i_smer ),
		.node_sw_i_mer( node_sw_i_smer ),
		.gen_sw_i_mer( gen_sw_i_smer ),
		.opr_sw_i_mer( opr_sw_i_smer ),
		.uni_opr_sw_i_mer( uni_opr_sw_i_smer ),
		.lr_icn_i_mer( lr_icn_i_smer ),
		.node_icn_i_mer( node_icn_i_smer ),
		.gen_icn_i_mer( gen_icn_i_smer ),
		.opr_icn_i_mer( opr_icn_i_smer ),
		.uni_opr_icn_i_mer( uni_opr_icn_i_smer ),
		.mem_wen_icn_i_mer( mem_wen_icn_i_smer ),
		.rst( rst ),
		.clka( clka_smer ),
		.clkb( clkb_smer ),
		.aeb_cm_mer( aeb_smer ),

		.lr_o_mer( lr_o_smer ),
		.node_o_mer( node_o_smer ),
		.gen_o_mer( gen_o_smer ),
		.opr_o_mer( opr_o_smer ),
		.uni_opr_o_mer( uni_opr_o_smer ),
		.mem_wen_o_mer( mem_wen_o_smer )
		);


endmodule //sMer
