`timescale 1ps/1ps
module sFtc1
 (//Input:  name_i_modulename
  //Output: name_o_modulename

  node_i_sftc1,        //IN
  gen_i_sftc1,
  opr0_i_sftc1,
  opr1_i_sftc1,
  mem_wen_i_sftc1,
  w_en_cex_i_sftc1,
  nInterC_S_sFtc0_uC_uCEX,
  nInterC_A_sDec0_uC_uCEX,
  
  lopen,
  rst,

  node_o_sftc1,        //OUT
  gen_o_sftc1,
  opr0_o_sftc1,
  opr1_o_sftc1,
  mem_wen_o_sftc1,
  ins_o_sftc1,
  nInterC_S_uCEX_sDec0_uC,
  nInterC_A_uCEX_sFtc0_uC
  );

  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  //from Ftc0
  input [15:0]  node_i_sftc1;
  input [11:0]  gen_i_sftc1;
  input [31:0]  opr0_i_sftc1;
  input [31:0]  opr1_i_sftc1;
  input [1:0]   mem_wen_i_sftc1;
  input         w_en_cex_i_sftc1;
  input         nInterC_S_sFtc0_uC_uCEX;
  //from Dec0
  input         nInterC_A_sDec0_uC_uCEX;
 
  input         lopen;
  input         rst;
  

  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  //to Dec0
  output [15:0] node_o_sftc1;
  output [11:0] gen_o_sftc1;
  output [31:0] opr0_o_sftc1;
  output [31:0] opr1_o_sftc1;
  output        mem_wen_o_sftc1;
  output [33:0] ins_o_sftc1;
  output        nInterC_S_uCEX_sDec0_uC;
  //to Ftc0
  output        nInterC_A_uCEX_sFtc0_uC;


  /***********************************************************/
  /*                 DEFINITION OF WIRE                      */
  /***********************************************************/

  wire          clk_sftc1;

  
  
  /***********************************************************/
  /*                       INCLUDE CEX                       */
  /***********************************************************/

  wire send_delay;
  wire ack_delay;
  
  CELEMENT_Ftc1 uCEX_Ftc1(
    .RESETN( rst ),
    .EXBIN( w_en_cex_i_sftc1 ),
    .SENDIN( nInterC_S_sFtc0_uC_uCEX ),
    .ACKIN( nInterC_A_sDec0_uC_uCEX ),
    
    .SENDOUT( send_delay ),
    .ACKOUT( ack_delay ),
    .CP( clk_sftc1 ),
    .LOPEN( lopen )
  );

  buf #(14147, 14132) (nInterC_S_uCEX_sDec0_uC, send_delay);
  buf #(8044, 3654) (nInterC_A_uCEX_sFtc0_uC, ack_delay);


  /***********************************************************/
  /*                       INCLUDE Ftc1                      */
  /***********************************************************/

  Ftc1 iFtc1(
    .node_i_ftc1( node_i_sftc1 ),
    .gen_i_ftc1( gen_i_sftc1 ),
    .opr0_i_ftc1( opr0_i_sftc1 ),
    .opr1_i_ftc1( opr1_i_sftc1 ),
    .mem_wen_i_ftc1( mem_wen_i_sftc1 ),
    .rst( rst ),
    .clk( clk_sftc1 ),

    .b_clk(1'b0),
    .bist_mode_i_ftc1(1'b0),

    .node_o_ftc1( node_o_sftc1 ),
    .gen_o_ftc1( gen_o_sftc1 ),
    .opr0_o_ftc1( opr0_o_sftc1 ),
    .opr1_o_ftc1( opr1_o_sftc1 ),
    .mem_wen_o_ftc1( mem_wen_o_sftc1 ),
    .ins_o_ftc1( ins_o_sftc1 )
  );


endmodule //sFtc1
