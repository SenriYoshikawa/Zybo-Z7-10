`timescale 1ps/1ps
module sFtc0
 (//Input:  name_i_modulename
  //Output: name_o_modulename

  node_i_sftc0,          //IN
  gen_i_sftc0,
  opr0_i_sftc0,
  opr1_i_sftc0,
  mem_wen_i_sftc0,
  nInterC_S_sSM_uCEX_uC,
  nInterC_A_sFtc1_uCEX_uC,
  
  lopen,
  rst,


  node_o_sftc0,          //OUT
  gen_o_sftc0,
  opr0_o_sftc0,
  opr1_o_sftc0,
  mem_wen_o_sftc0,
  w_en_cex_o_sftc0,
  nInterC_S_uC_sFtc1_uCEX,
  nInterC_A_uC_sSM_uCEX
  );


  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  //from SM
  input  [15:0]  node_i_sftc0;
  input  [11:0]  gen_i_sftc0;
  input  [31:0]  opr0_i_sftc0;
  input  [31:0]  opr1_i_sftc0;
  input  [1:0]  mem_wen_i_sftc0;  
  input    nInterC_S_sSM_uCEX_uC;
  //from Ftc1
  input    nInterC_A_sFtc1_uCEX_uC;
  
  input         lopen;
  input    rst;


  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  //to Ftc1
  output [15:0]  node_o_sftc0;
  output [11:0]  gen_o_sftc0;
  output [31:0]  opr0_o_sftc0;
  output [31:0]  opr1_o_sftc0;
  output [1:0]  mem_wen_o_sftc0;
  output  w_en_cex_o_sftc0;
  output  nInterC_S_uC_sFtc1_uCEX;
  //to SM
  output  nInterC_A_uC_sSM_uCEX;


  /***********************************************************/
  /*                 DEFINITION OF WIRE                      */
  /***********************************************************/

  wire    clk_sftc0;


  /***********************************************************/
  /*                        INCLUDE C                        */
  /***********************************************************/

  wire send_delay;
  wire ack_delay;

  CELEMENT_Ftc0 uC_Ftc0(
    .RESETN( rst ),
    .SENDIN( nInterC_S_sSM_uCEX_uC ),
    .ACKIN( nInterC_A_sFtc1_uCEX_uC ),
    
    .SENDOUT( send_delay ),
    .ACKOUT( ack_delay ),
    .CP( clk_sftc0 ),
    .LOPEN( lopen )
  );

  buf #(5897, 8147) (nInterC_S_uC_sFtc1_uCEX, send_delay);
  buf #(0, 0) (nInterC_A_uC_sSM_uCEX, ack_delay);


  /***********************************************************/
  /*                       INCLUDE Ftc0                      */
  /***********************************************************/
  
  Ftc0 iFtc0(
    .node_i_ftc0( node_i_sftc0 ),
    .gen_i_ftc0( gen_i_sftc0 ),
    .opr0_i_ftc0( opr0_i_sftc0 ),
    .opr1_i_ftc0( opr1_i_sftc0 ),
    .mem_wen_i_ftc0( mem_wen_i_sftc0 ),
    .rst( rst ),
    .clk( clk_sftc0 ),

    .node_o_ftc0( node_o_sftc0 ),
    .gen_o_ftc0( gen_o_sftc0 ),
    .opr0_o_ftc0( opr0_o_sftc0 ),
    .opr1_o_ftc0( opr1_o_sftc0 ),
    .mem_wen_o_ftc0( mem_wen_o_sftc0 ),
    .w_en_cex_o_ftc0( w_en_cex_o_sftc0 )
    );


endmodule //sFtc0
