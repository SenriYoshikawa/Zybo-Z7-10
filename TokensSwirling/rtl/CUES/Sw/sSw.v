`timescale 1ps/1ps
module sSw
 (//Input:  name_i_modulename
  //Output: name_o_modulename

  lr_i_ssw,        //IN
  node_i_ssw,
  gen_i_ssw,
  opr_i_ssw,
  pe_out_i_ssw,
  pe_num_i_ssw,
  f_mem_w_i_ssw,
  uni_opr_i_ssw,
  nInterC_S_sSB_uCB_uCB,
  nInterC_A_sICN_uC_uCB,
  nInterC_A_sMer_uCM_uCB,

  lopen,
  rst,


  pe_num_icn_o_ssw,    //OUT
  mem_w_icn_o_ssw,
  lr_icn_o_ssw,
  node_icn_o_ssw,
  gen_icn_o_ssw,
  opr_icn_o_ssw,
  uni_opr_icn_o_ssw,
  lr_mer_o_ssw,  
  node_mer_o_ssw,
  gen_mer_o_ssw,
  opr_mer_o_ssw,
  uni_opr_mer_o_ssw,
  nInterC_S_uCB_sICN_uC,
  nInterC_S_uCB_sMer_uCM,
  nInterC_A_uCB_sSB_uCB
  );


  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  //from SB
  input         lr_i_ssw;
  input  [15:0] node_i_ssw;
  input  [11:0] gen_i_ssw;
  input  [31:0] opr_i_ssw;
  input         uni_opr_i_ssw;
  input         pe_out_i_ssw;
  input  [2:0]  pe_num_i_ssw;
  input         f_mem_w_i_ssw;
  input         nInterC_S_sSB_uCB_uCB;
  //from ICN
  input         nInterC_A_sICN_uC_uCB;
  //from Mer
  input         nInterC_A_sMer_uCM_uCB;

  input         lopen;
  input         rst;


  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  //to ICN
  output [2:0]  pe_num_icn_o_ssw;
  output [1:0]  mem_w_icn_o_ssw;
  output        lr_icn_o_ssw;
  output [15:0] node_icn_o_ssw;
  output [11:0] gen_icn_o_ssw;
  output [31:0] opr_icn_o_ssw;
  output        uni_opr_icn_o_ssw;
  output        nInterC_S_uCB_sICN_uC;
  //to Mer
  output        lr_mer_o_ssw;
  output [15:0] node_mer_o_ssw;
  output [11:0] gen_mer_o_ssw;
  output [31:0] opr_mer_o_ssw;
  output        uni_opr_mer_o_ssw;
  output        nInterC_S_uCB_sMer_uCM;
  //to Mem1
  output        nInterC_A_uCB_sSB_uCB;


  /***********************************************************/
  /*                 DEFINITION OF WIRE                      */
  /***********************************************************/

  wire     clk_ssw;
    
  
  /***********************************************************/
  /*                       INCLUDE CB                        */
  /***********************************************************/

  wire senda_delay;
  wire sendb_delay;
  wire ack_delay;
  wire ackin_delay;

  CELEMENT_Sw uCB_Sw(
    .RESETN( rst ),
    .BRIN( ~pe_out_i_ssw ),//0:A,1:B
    .SENDIN( nInterC_S_sSB_uCB_uCB ),
    .ACKINA( ackin_delay ),
    .ACKINB( nInterC_A_sMer_uCM_uCB ),
    .SENDOUTA( senda_delay ),
    .SENDOUTB( sendb_delay ),
    .ACKOUT( ack_delay ),
    .CP( clk_ssw ),
    .LOPEN( lopen )
  );

  buf #(5593, 14941) (nInterC_S_uCB_sICN_uC, senda_delay);
  buf #(10858, 12095) (nInterC_S_uCB_sMer_uCM, sendb_delay);
  buf #(7826, 3855) (nInterC_A_uCB_sSB_uCB, ack_delay);
  buf #(8000, 4000) (ackin_delay, nInterC_A_sICN_uC_uCB);


  /***********************************************************/
  /*                       INCLUDE Sw                       */
  /***********************************************************/
   
  Sw iSw(
    .lr_i_sw( lr_i_ssw ),
    .node_i_sw( node_i_ssw ),
    .gen_i_sw( gen_i_ssw ),
    .opr_i_sw( opr_i_ssw ),
    .pe_num_i_sw( pe_num_i_ssw ),
    .f_mem_w_i_sw( f_mem_w_i_ssw ),
    .uni_opr_i_sw( uni_opr_i_ssw ),

    .rst( rst ),
    .clk( clk_ssw ),

    .lr_mer_o_sw( lr_mer_o_ssw ),
    .node_mer_o_sw( node_mer_o_ssw ),
    .gen_mer_o_sw( gen_mer_o_ssw ),
    .opr_mer_o_sw( opr_mer_o_ssw ),
    .uni_opr_mer_o_sw( uni_opr_mer_o_ssw ),
    .pe_num_icn_o_sw( pe_num_icn_o_ssw ),
    .mem_w_icn_o_sw( mem_w_icn_o_ssw ),
    .lr_icn_o_sw( lr_icn_o_ssw ),
    .node_icn_o_sw( node_icn_o_ssw ),
    .gen_icn_o_sw( gen_icn_o_ssw ),
    .opr_icn_o_sw( opr_icn_o_ssw ),
    .uni_opr_icn_o_sw( uni_opr_icn_o_ssw )
    );


endmodule //sSw
