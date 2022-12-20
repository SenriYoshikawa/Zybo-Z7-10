`timescale 1ps/1ps
module sFC0
 (//Input:  name_i_modulename
  //Output: name_o_modulename

  lr_i_sfc0,          //IN
  node_i_sfc0,
  gen_i_sfc0,
  opr_i_sfc0,
  uni_opr_i_sfc0,
  mem_wen_i_sfc0,
  nInterC_S_sMer_uCM_uC,
  nInterC_A_sFC1_uCEX_uC,
  
  lopen,
  rst,


  lr_o_sfc0,
  node_o_sfc0,
  gen_o_sfc0,
  opr_o_sfc0,
  mem_wen_o_sfc0,
  mtch_data_o_sfc0,
  mtch_rslt_cex_o_sfc0,
  nInterC_S_uC_sFC1_uCEX,
  nInterC_A_uC_sMer_uCM,

  mm_full_sfc0
  );


  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  //from TC1
  input         lr_i_sfc0;
  input  [15:0] node_i_sfc0;
  input  [11:0] gen_i_sfc0;
  input  [31:0] opr_i_sfc0;
  input         uni_opr_i_sfc0;
  input  [1:0]  mem_wen_i_sfc0;  
  input         nInterC_S_sMer_uCM_uC;
  //from FC1
  input         nInterC_A_sFC1_uCEX_uC;
  
  input         lopen;
  input         rst;


  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  //to FC1
  output        lr_o_sfc0;
  output [15:0] node_o_sfc0;
  output [11:0] gen_o_sfc0;
  output [31:0] opr_o_sfc0;
  output [1:0]  mem_wen_o_sfc0;
  output [31:0] mtch_data_o_sfc0;
  output        mtch_rslt_cex_o_sfc0;  
  output        nInterC_S_uC_sFC1_uCEX;
  //to TC1
  output        nInterC_A_uC_sMer_uCM;

  output        mm_full_sfc0;


  /***********************************************************/
  /*                 DEFINITION OF WIRE                      */
  /***********************************************************/

  wire    clk_sfc0;
    
  wire    uni_opr_fc0_sfc0;
  
  wire    mmu0_mm_full_sfc0;
  wire    mmu0_mm_empty_sfc0;
  wire    mmu1_mm_empty_sfc0;
  wire    mm_next_mmu0_w_sfc0;
  wire    mm_next_mmu1_w_sfc0;
  wire    mmu0_next_empty_sfc0;
  wire    mmu1_next_empty_sfc0;


  /***********************************************************/
  /*                        INCLUDE C                        */
  /***********************************************************/

  wire  send_delay;
  wire  ack_delay;

  CELEMENT_FC0 uC_FC0(
    .RESETN( rst ),
    .SENDIN( nInterC_S_sMer_uCM_uC ),
    .ACKIN( nInterC_A_sFC1_uCEX_uC ),
    
    .SENDOUT( send_delay ),
    .ACKOUT( ack_delay ),
    .CP( clk_sfc0 ),
    .LOPEN( lopen )
    );


  buf #(5551, 8587) (nInterC_S_uC_sFC1_uCEX, send_delay);
  buf #(0, 0) (nInterC_A_uC_sMer_uCM, ack_delay);


  /***********************************************************/
  /*                       INCLUDE FC0                       */
  /***********************************************************/
  
  FC0 iFC0(
    .lr_i_fc0( lr_i_sfc0 ),
    .node_i_fc0( node_i_sfc0 ),
    .gen_i_fc0( gen_i_sfc0 ),
    .opr_i_fc0( opr_i_sfc0 ),
    .uni_opr_i_fc0( uni_opr_i_sfc0 ),
    .mem_wen_i_fc0( mem_wen_i_sfc0 ),
    .mm16_fc0( 1'b0 ),
    .pg_mmu0_fc0( 1'b1 ),
    .pg_mmu1_fc0( 1'b1 ),
    .rst( rst ),
    .clk( clk_sfc0 ),
    
    .lr_o_fc0( lr_o_sfc0 ),
    .node_o_fc0( node_o_sfc0 ),
    .gen_o_fc0( gen_o_sfc0 ),
    .opr_o_fc0( opr_o_sfc0 ),
    .mem_wen_o_fc0( mem_wen_o_sfc0 ),
    .mtch_data_o_fc0( mtch_data_o_sfc0 ),
    .mtch_rslt_cex_o_fc0( mtch_rslt_cex_o_sfc0 ),
    .uni_opr_fc0( uni_opr_fc0_sfc0 ),
    .mm_full_fc0( mm_full_sfc0 ),
    .mmu0_mm_full_fc0( mmu0_mm_full_sfc0 ),
    .mmu0_mm_empty_fc0( mmu0_mm_empty_sfc0 ),
    .mmu1_mm_empty_fc0( mmu1_mm_empty_sfc0 ),
    .next_mmu0_w_fc0( mm_next_mmu0_w_sfc0 ),
    .next_mmu1_w_fc0( mm_next_mmu1_w_sfc0 ),
    .mmu0_next_empty_fc0( mmu0_next_empty_sfc0 ),
    .mmu1_next_empty_fc0( mmu1_next_empty_sfc0 )
    );
    
    
endmodule //sFC0
