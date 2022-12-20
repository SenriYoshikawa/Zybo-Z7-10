`timescale 1ps/1ps
module sSB
 (//Input:  name_i_modulename
  //Output: name_o_modulename

  opr0_i_ssb,      //IN
  dm_data_valid_i_ssb,
  dm_data_i_ssb,
  pe_out_i_ssb,
  pe_num_i_ssb,
  f_mem_w_i_ssb,
  next_lr_i_ssb,
  next_node_i_ssb,
  gen_i_ssb,
  next_uni_opr_i_ssb,
  nInterC_S_sMem1_uCEX_uCB,
  nInterC_A_sSw_uCB_uCB,
  nInterC_A_sSM_uCM_uCB,

  sp_disen_i_ssb,
  lopen,
  rst,


  lr_sw_o_ssb,
  node_sw_o_ssb,        //OUT
  gen_sw_o_ssb,
  opr_sw_o_ssb,
  pe_out_sw_o_ssb,
  pe_num_sw_o_ssb,
  f_mem_w_sw_o_ssb,
  uni_opr_sw_o_ssb,
  node_sm_o_ssb,
  gen_sm_o_ssb,
  opr_sm_o_ssb,
  mem_wen_sm_o_ssb,
  nInterC_S_uCB_sSw_uCB,
  nInterC_S_uCB_sSM_uCM,
  nInterC_A_uCB_sMem1_uCEX
  );


  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  //from Mem1
  input  [31:0]  opr0_i_ssb;
  input    dm_data_valid_i_ssb;
  input  [31:0]  dm_data_i_ssb;
  input    pe_out_i_ssb;
  input  [2:0]  pe_num_i_ssb;
  input    f_mem_w_i_ssb;
  input    next_lr_i_ssb;
  input  [15:0]  next_node_i_ssb;
  input  [11:0]  gen_i_ssb;
  input    next_uni_opr_i_ssb;
  input    nInterC_S_sMem1_uCEX_uCB;
  //from Sw
  input    nInterC_A_sSw_uCB_uCB;
  //from SM
  input    nInterC_A_sSM_uCM_uCB;

  input    sp_disen_i_ssb;
  input    lopen;
  input    rst;


  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  //to Sw
  output   lr_sw_o_ssb;
  output [15:0]  node_sw_o_ssb;
  output [11:0]  gen_sw_o_ssb;
  output [31:0]  opr_sw_o_ssb;
  output   pe_out_sw_o_ssb;
  output [2:0]  pe_num_sw_o_ssb;
  output   f_mem_w_sw_o_ssb;
  output   uni_opr_sw_o_ssb;
  output  nInterC_S_uCB_sSw_uCB;
  //to SM
  output [15:0]  node_sm_o_ssb;
  output [11:0]  gen_sm_o_ssb;
  output [31:0]  opr_sm_o_ssb;
  output [1:0]  mem_wen_sm_o_ssb;
  output  nInterC_S_uCB_sSM_uCM;
  //to Mem1
  output  nInterC_A_uCB_sMem1_uCEX;


  /***********************************************************/
  /*                 DEFINITION OF WIRE                      */
  /***********************************************************/

  wire     clk_ssb;
  
  
  /***********************************************************/
  /*                       INCLUDE CB                        */
  /***********************************************************/

  wire senda_delay;
  wire sendb_delay;
  wire ack_delay;

  CELEMENT_SB uCB_SB(
    .RESETN( rst ),
    .BRIN( next_uni_opr_i_ssb & ~pe_out_i_ssb & ~sp_disen_i_ssb ),//0:A,1:B
    .SENDIN( nInterC_S_sMem1_uCEX_uCB ),
    .ACKINA( nInterC_A_sSw_uCB_uCB ),
    .ACKINB( nInterC_A_sSM_uCM_uCB ), 
    
    .SENDOUTA( senda_delay ),
    .SENDOUTB( sendb_delay ),
    .ACKOUT( ack_delay ),
    .CP( clk_ssb ),
    .LOPEN( lopen )
  );

  buf #(10129, 11758) (nInterC_S_uCB_sSw_uCB, senda_delay);
  buf #(11688, 12431) (nInterC_S_uCB_sSM_uCM, sendb_delay);
  buf #(7990, 4348) (nInterC_A_uCB_sMem1_uCEX, ack_delay);


  /***********************************************************/
  /*                       INCLUDE Sw                       */
  /***********************************************************/
   
  SB iSB(
    .opr0_i_sb( opr0_i_ssb ),
    .dm_data_valid_i_sb( dm_data_valid_i_ssb ),
    .dm_data_i_sb( dm_data_i_ssb ),
    .pe_out_i_sb( pe_out_i_ssb ),
    .pe_num_i_sb( pe_num_i_ssb ),
    .f_mem_w_i_sb( f_mem_w_i_ssb ),
    .next_lr_i_sb( next_lr_i_ssb ),
    .next_node_i_sb( next_node_i_ssb ),
    .gen_i_sb( gen_i_ssb ),
    .next_uni_opr_i_sb( next_uni_opr_i_ssb ),
    .rst( rst ),
    .clk( clk_ssb ),

    .lr_sw_o_sb( lr_sw_o_ssb ),
    .node_sw_o_sb( node_sw_o_ssb ),
    .gen_sw_o_sb( gen_sw_o_ssb ),
    .opr_sw_o_sb( opr_sw_o_ssb ),
    .pe_out_sw_o_sb( pe_out_sw_o_ssb ),
    .pe_num_sw_o_sb( pe_num_sw_o_ssb ),
    .f_mem_w_sw_o_sb( f_mem_w_sw_o_ssb ),
    .uni_opr_sw_o_sb( uni_opr_sw_o_ssb ),
    .node_sm_o_sb( node_sm_o_ssb ),
    .gen_sm_o_sb( gen_sm_o_ssb ),
    .opr_sm_o_sb( opr_sm_o_ssb ),
    .mem_wen_sm_o_sb( mem_wen_sm_o_ssb )
  );


endmodule //sSB
