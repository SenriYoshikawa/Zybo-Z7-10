`timescale 1ps/1ps
module sDec0
 (//Input:  name_i_modulename
  //Output: name_o_modulename

  node_i_sdec0,          //IN
  gen_i_sdec0,
  opr0_i_sdec0,
  opr1_i_sdec0,
  mem_wen_i_sdec0,
  ins_i_sdec0,
  nInterC_S_sFtc1_uCEX_uC,
  nInterC_A_sExe0_uC_uC,
  
  lopen,
  rst,


  node_o_sdec0,          //OUT
  gen_o_sdec0,
  opr0_o_sdec0,
  opr1_o_sdec0,
  mem_wen_o_sdec0,
  dopc_o_sdec0,
  ins_o_sdec0,
  nInterC_S_uC_sExe0_uC,
  nInterC_A_uC_sFtc1_uCEX
  );


  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  //from Ftc0
  input  [15:0] node_i_sdec0;
  input  [11:0] gen_i_sdec0;
  input  [31:0] opr0_i_sdec0;
  input  [31:0] opr1_i_sdec0;
  input         mem_wen_i_sdec0;  
  input  [33:0] ins_i_sdec0;  
  input         nInterC_S_sFtc1_uCEX_uC;
  //from Exe0
  input         nInterC_A_sExe0_uC_uC;
  
  input         lopen;
  input         rst;


  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  //to Exe0
  output [15:0] node_o_sdec0;
  output [11:0] gen_o_sdec0;
  output [31:0] opr0_o_sdec0;
  output [31:0] opr1_o_sdec0;
  output        mem_wen_o_sdec0;
  output [9:0]  dopc_o_sdec0;
  output [26:0] ins_o_sdec0;
  output        nInterC_S_uC_sExe0_uC;
  //to Ftc1
  output        nInterC_A_uC_sFtc1_uCEX;


  /***********************************************************/
  /*                 DEFINITION OF WIRE                      */
  /***********************************************************/

  wire    clk_sdec0;
  
  
  /***********************************************************/
  /*                        INCLUDE C                        */
  /***********************************************************/

  wire send_delay;
  wire ack_delay;

  CELEMENT_Dec0 uC_Dec0(
    .RESETN( rst ),
    .SENDIN( nInterC_S_sFtc1_uCEX_uC ),
    .ACKIN( nInterC_A_sExe0_uC_uC ),
    
    .SENDOUT( send_delay ),
    .ACKOUT( ack_delay ),
    .CP( clk_sdec0 ),
    .LOPEN( lopen )
  );

  buf #(5771, 8459) (nInterC_S_uC_sExe0_uC, send_delay);
  buf #(8977, 4876) (nInterC_A_uC_sFtc1_uCEX, ack_delay);

  /***********************************************************/
  /*                       INCLUDE Dec0                      */
  /***********************************************************/
  
  Dec0 iDec0(
    .node_i_dec0( node_i_sdec0 ),
    .gen_i_dec0( gen_i_sdec0 ),
    .opr0_i_dec0( opr0_i_sdec0 ),
    .opr1_i_dec0( opr1_i_sdec0 ),
    .mem_wen_i_dec0( mem_wen_i_sdec0 ),
    .ins_i_dec0( ins_i_sdec0 ),
    .rst( rst ),
    .clk( clk_sdec0 ),

    .node_o_dec0( node_o_sdec0 ),
    .gen_o_dec0( gen_o_sdec0 ),
    .opr0_o_dec0( opr0_o_sdec0 ),
    .opr1_o_dec0( opr1_o_sdec0 ),
    .mem_wen_o_dec0( mem_wen_o_sdec0 ),
    .dopc_o_dec0( dopc_o_sdec0 ),
    .ins_o_dec0( ins_o_sdec0 )
    );
    
    
endmodule //sDec0
