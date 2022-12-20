`timescale 1ps/1ps
module sSM
 (//Input:  name_i_modulename
  //Output: name_o_modulename

  node_sb_i_ssm,        //IN
  gen_sb_i_ssm,
  opr_sb_i_ssm,
  mem_wen_sb_i_ssm,
  node_fc1_i_ssm,
  gen_fc1_i_ssm,
  opr0_fc1_i_ssm,
  opr1_fc1_i_ssm,
  mem_wen_fc1_i_ssm,
  nInterC_S_sSB_uCB_uCM,
  nInterC_S_sFC1_uCEX_uCM,
  nInterC_A_sFtc0_uC_uCM,
  
  lopen,
  rst,


  node_o_ssm,        //OUT
  gen_o_ssm,
  opr0_o_ssm,
  opr1_o_ssm,
  mem_wen_o_ssm,
  nInterC_S_uCM_sFtc0_uC,
  nInterC_A_uCM_sSB_uCB,
  nInterC_A_uCM_sFC1_uCEX
  );


  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  //from Sw
  input  [15:0]  node_sb_i_ssm;
  input  [11:0]  gen_sb_i_ssm;
  input  [31:0]  opr_sb_i_ssm;
  input  [1:0]  mem_wen_sb_i_ssm;
  input    nInterC_S_sSB_uCB_uCM;
  //from IFIFO
  input  [15:0]  node_fc1_i_ssm;
  input  [11:0]  gen_fc1_i_ssm;
  input  [31:0]  opr0_fc1_i_ssm;
  input  [31:0]  opr1_fc1_i_ssm;
  input  [1:0]  mem_wen_fc1_i_ssm;
  input    nInterC_S_sFC1_uCEX_uCM;
  //from TC0
  input    nInterC_A_sFtc0_uC_uCM;
  
  input         lopen;
  input         rst;

    
  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  //to TC0
  output [15:0]  node_o_ssm;
  output [11:0]  gen_o_ssm;
  output [31:0]  opr1_o_ssm;
  output [31:0]  opr0_o_ssm;
  output [1:0]  mem_wen_o_ssm;
  output  nInterC_S_uCM_sFtc0_uC;
  //to Sw
  output  nInterC_A_uCM_sSB_uCB;
  //to IFOFO
  output  nInterC_A_uCM_sFC1_uCEX;
  

  /***********************************************************/
  /*                   DEFINITION OF WIRE                    */
  /***********************************************************/

  wire    clka_ssm;
  wire    clkb_ssm;
  wire    aeb_ssm;


  /***********************************************************/
  /*                       INCLUDE CM                        */
  /***********************************************************/
  
  wire acka_delay;
  wire ackb_delay;
 
  CELEMENT_SM uCM_SM(
    .RESETN( rst ),
    .SENDINA( nInterC_S_sSB_uCB_uCM ),
    .SENDINB( nInterC_S_sFC1_uCEX_uCM ),
    .ACKIN( nInterC_A_sFtc0_uC_uCM ),
    
    .SENDOUT( nInterC_S_uCM_sFtc0_uC ),
    //.ACKOUTA( nInterC_A_uCM_sSB_uCB ),
    .ACKOUTA( acka_delay ),
    //.ACKOUTB( nInterC_A_uCM_sFC1_uCEX ),
    .ACKOUTB( ackb_delay ),
    .AEBOUT( aeb_ssm ),
    .CPA( clka_ssm ),
    .CPB( clkb_ssm ),
    .LOPEN( lopen )
    );


  buf #(8199, 4214) (nInterC_A_uCM_sSB_uCB, acka_delay);
  buf #(7750, 3958) (nInterC_A_uCM_sFC1_uCEX, ackb_delay);

  /***********************************************************/
  /*                       INCLUDE Mer                       */
  /***********************************************************/

  SM iSM(
    .node_sb_i_sm( node_sb_i_ssm ),
    .gen_sb_i_sm( gen_sb_i_ssm ),
    .opr_sb_i_sm( opr_sb_i_ssm ),
    .mem_wen_sb_i_sm( mem_wen_sb_i_ssm ),
    .node_fc1_i_sm( node_fc1_i_ssm ),
    .gen_fc1_i_sm( gen_fc1_i_ssm ),
    .opr0_fc1_i_sm( opr0_fc1_i_ssm ),
    .opr1_fc1_i_sm( opr1_fc1_i_ssm ),
    .mem_wen_fc1_i_sm( mem_wen_fc1_i_ssm ),
    .rst( rst ),
    .clka( clka_ssm ),
    .clkb( clkb_ssm ),
    .aeb_cm_sm( aeb_ssm ),

    .node_o_sm( node_o_ssm ),
    .gen_o_sm( gen_o_ssm ),
    .opr0_o_sm( opr0_o_ssm ),
    .opr1_o_sm( opr1_o_ssm ),
    .mem_wen_o_sm( mem_wen_o_ssm )
    );


endmodule //sSM
