`timescale 1ps/1ps
module sMem1
 (//Input:  name_i_modulename
  //Output: name_o_modulename

  opr0_i_smem1,            //IN
  opr1_i_smem1,
  dm_addr_i_smem1,
  mem_wen_i_smem1,
  dm_dopc_i_smem1,
  pe_out_i_smem1,
  pe_num_i_smem1,
  f_mem_w_i_smem1,
  next_lr_i_smem1,
  next_node_i_smem1,
  gen_i_smem1,
  next_uni_opr_i_smem1,
  w_en_cex_i_smem1,
  nInterC_S_sMem0_uC_uCEX,
  nInterC_A_sSB_uCB_uCEX,
  
  lopen,
  rst,

  opr0_o_smem1,            //OUT
  dm_data_valid_o_smem1,
  dm_data_o_smem1,
  pe_out_o_smem1,
  pe_num_o_smem1,
  f_mem_w_o_smem1,
  next_lr_o_smem1,
  next_node_o_smem1,
  gen_o_smem1,
  next_uni_opr_o_smem1,
  nInterC_S_uCEX_sSB_uCB,
  nInterC_A_uCEX_sMem0_uC
  );


  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  //from Mem0
  input  [31:0] opr0_i_smem1;
  input  [31:0] opr1_i_smem1;
  input  [13:0] dm_addr_i_smem1;
  input         mem_wen_i_smem1;
  input  [2:0]  dm_dopc_i_smem1;
  input         pe_out_i_smem1;
  input  [2:0]  pe_num_i_smem1;
  input         f_mem_w_i_smem1;
  input         next_lr_i_smem1;
  input  [15:0] next_node_i_smem1;
  input  [11:0] gen_i_smem1;
  input         next_uni_opr_i_smem1;
  input         w_en_cex_i_smem1;
  input         nInterC_S_sMem0_uC_uCEX;
  //from Sw
  input         nInterC_A_sSB_uCB_uCEX;

  input         lopen;
  input         rst;


  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  //to Sw
  output [31:0] opr0_o_smem1;
  output        dm_data_valid_o_smem1;
  output [31:0] dm_data_o_smem1;
  output        pe_out_o_smem1;
  output [2:0]  pe_num_o_smem1;
  output        f_mem_w_o_smem1;
  output        next_lr_o_smem1;
  output [15:0] next_node_o_smem1;
  output [11:0] gen_o_smem1;
  output        next_uni_opr_o_smem1;
  output        nInterC_S_uCEX_sSB_uCB;
  //to Mem0
  output        nInterC_A_uCEX_sMem0_uC;


  /***********************************************************/
  /*                 DEFINITION OF WIRE                      */
  /***********************************************************/

  wire    clk_smem1;
  

  /***********************************************************/
  /*                       INCLUDE CEX                       */
  /***********************************************************/

  wire send_delay;
  wire ack_delay;
     
  CELEMENT_Mem1 uCEX_Mem1(
    .RESETN( rst ),
    .EXBIN( w_en_cex_i_smem1 ), //0:terminate
    .SENDIN( nInterC_S_sMem0_uC_uCEX ),
    .ACKIN( nInterC_A_sSB_uCB_uCEX ),
    
    //.SENDOUT( nInterC_S_uCEX_sSB_uCB ),
    .SENDOUT( send_delay ),
    //.ACKOUT( nInterC_A_uCEX_sMem0_uC ),
    .ACKOUT( ack_delay ),
    .CP( clk_smem1 ),
    .LOPEN( lopen )
  );

  buf #(13067, 13934) (nInterC_S_uCEX_sSB_uCB, send_delay);
  buf #(7796, 3578) (nInterC_A_uCEX_sMem0_uC, ack_delay);


  /***********************************************************/
  /*                       INCLUDE Mem1                      */
  /***********************************************************/

  Mem1 iMem1(
    .opr0_i_mem1( opr0_i_smem1 ),
    .opr1_i_mem1( opr1_i_smem1 ),
    .dm_addr_i_mem1( dm_addr_i_smem1 ),
    .mem_wen_i_mem1( mem_wen_i_smem1 ),
    .dm_dopc_i_mem1( dm_dopc_i_smem1[2:1] ),
    .pe_out_i_mem1( pe_out_i_smem1 ),
    .pe_num_i_mem1( pe_num_i_smem1 ),
    .f_mem_w_i_mem1( f_mem_w_i_smem1 ),
    .next_lr_i_mem1( next_lr_i_smem1 ),
    .next_node_i_mem1( next_node_i_smem1 ),
    .gen_i_mem1( gen_i_smem1 ),
    .next_uni_opr_i_mem1( next_uni_opr_i_smem1 ),
    .rst( rst ),
    .clk( clk_smem1 ),
    .b_clk( 1'b0 ),
    .bist_mode_i_mem1( 1'b0 ),

    .opr0_o_mem1( opr0_o_smem1 ),
    .dm_data_valid_o_mem1( dm_data_valid_o_smem1 ),
    .dm_data_o_mem1( dm_data_o_smem1 ),
    .pe_out_o_mem1( pe_out_o_smem1 ),
    .pe_num_o_mem1( pe_num_o_smem1 ),
    .f_mem_w_o_mem1( f_mem_w_o_smem1 ),
    .next_lr_o_mem1( next_lr_o_smem1 ),
    .next_node_o_mem1( next_node_o_smem1 ),
    .gen_o_mem1( gen_o_smem1 ),
    .next_uni_opr_o_mem1( next_uni_opr_o_smem1 )
    );


endmodule //sMem1
