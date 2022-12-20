`timescale 1ps/1ps
module sMem0
 (//Input:  name_i_modulename
  //Output: name_o_modulename

  opr0_i_smem0,        //IN
  opr1_i_smem0,
  dm_addr_i_smem0,
  mem_wen_i_smem0,
  dm_dopc_i_smem0,
  pe_out_i_smem0,
  pe_num_i_smem0,
  f_mem_w_i_smem0,
  next_lr_i_smem0,
  next_node_i_smem0,
  gen_i_smem0,
  next_uni_opr_i_smem0,
  nInterC_S_sExe1_uCX2_uC,
  nInterC_A_sMem1_uCEX_uC,

  lopen,
  rst,


  opr0_o_smem0,        //OUT
  opr1_o_smem0,
  dm_addr_o_smem0,
  mem_wen_o_smem0,
  dm_dopc_o_smem0,
  pe_out_o_smem0,
  pe_num_o_smem0,
  f_mem_w_o_smem0,
  next_lr_o_smem0,
  next_node_o_smem0,
  gen_o_smem0,
  next_uni_opr_o_smem0,
  w_en_cex_o_smem0,
  nInterC_S_uC_sMem1_uCEX,
  nInterC_A_uC_sExe1_uCX2
  );


  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  //from Exe1
  input [31:0]  opr0_i_smem0;
  input [31:0]  opr1_i_smem0;
  input [13:0]  dm_addr_i_smem0;
  input         mem_wen_i_smem0;
  input [2:0]   dm_dopc_i_smem0;
  input         pe_out_i_smem0;
  input [2:0]   pe_num_i_smem0;
  input         f_mem_w_i_smem0;
  input         next_lr_i_smem0;
  input [15:0]  next_node_i_smem0;
  input [11:0]  gen_i_smem0;
  input         next_uni_opr_i_smem0;
  input         nInterC_S_sExe1_uCX2_uC;
  //from Mem1
  input         nInterC_A_sMem1_uCEX_uC;

  input         lopen;
  input         rst;


  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  //to Mem1
  output [31:0] opr0_o_smem0;
  output [31:0] opr1_o_smem0;
  output [13:0] dm_addr_o_smem0;
  output        mem_wen_o_smem0;
  output [2:0]  dm_dopc_o_smem0;
  output        pe_out_o_smem0;
  output [2:0]  pe_num_o_smem0;
  output        f_mem_w_o_smem0;
  output        next_lr_o_smem0;
  output [15:0] next_node_o_smem0;
  output [11:0] gen_o_smem0;
  output        next_uni_opr_o_smem0;
  output        w_en_cex_o_smem0;
  output        nInterC_S_uC_sMem1_uCEX;
  //to Exe1
  output        nInterC_A_uC_sExe1_uCX2;


  /***********************************************************/
  /*                 DEFINITION OF WIRE                      */
  /***********************************************************/

  wire    clk_smem0;
  

  /***********************************************************/
  /*                        INCLUDE C                        */
  /***********************************************************/

  wire send_delay;
  wire ack_delay;

  CELEMENT_Mem0 uC_Mem0(
    .RESETN( rst ),
    .SENDIN( nInterC_S_sExe1_uCX2_uC ),
    .ACKIN( nInterC_A_sMem1_uCEX_uC ),
    
    .SENDOUT( send_delay ),
    .ACKOUT( ack_delay ),
    .CP( clk_smem0 ),
    .LOPEN( lopen )
  );

  buf #(5555, 9575) (nInterC_S_uC_sMem1_uCEX, send_delay);
  buf #(0, 0) (nInterC_A_uC_sExe1_uCX2, ack_delay);


  /***********************************************************/
  /*                       INCLUDE Mem0                       */
  /***********************************************************/
  
  Mem0 iMem0(
    .opr0_i_mem0( opr0_i_smem0 ),
    .opr1_i_mem0( opr1_i_smem0 ),
    .dm_addr_i_mem0( dm_addr_i_smem0 ),
    .mem_wen_i_mem0( mem_wen_i_smem0 ),
    .dm_dopc_i_mem0( dm_dopc_i_smem0 ),
    .pe_out_i_mem0( pe_out_i_smem0 ),
    .pe_num_i_mem0( pe_num_i_smem0 ),
    .f_mem_w_i_mem0( f_mem_w_i_smem0 ),
    .next_lr_i_mem0( next_lr_i_smem0 ),
    .next_node_i_mem0( next_node_i_smem0 ),
    .gen_i_mem0( gen_i_smem0 ),
    .next_uni_opr_i_mem0( next_uni_opr_i_smem0 ),
    .rst( rst ),
    .clk( clk_smem0 ),
    
    .opr0_o_mem0( opr0_o_smem0 ),
    .opr1_o_mem0( opr1_o_smem0 ),
    .dm_addr_o_mem0( dm_addr_o_smem0 ),
    .mem_wen_o_mem0( mem_wen_o_smem0 ),
    .dm_dopc_o_mem0( dm_dopc_o_smem0 ),
    .pe_out_o_mem0( pe_out_o_smem0 ),
    .pe_num_o_mem0( pe_num_o_smem0 ),
    .f_mem_w_o_mem0( f_mem_w_o_smem0 ),
    .next_lr_o_mem0( next_lr_o_smem0 ),
    .next_node_o_mem0( next_node_o_smem0 ),
    .gen_o_mem0( gen_o_smem0 ),
    .next_uni_opr_o_mem0( next_uni_opr_o_smem0 ),
    .w_en_cex_o_mem0( w_en_cex_o_smem0 )
  );

endmodule //sMem0
