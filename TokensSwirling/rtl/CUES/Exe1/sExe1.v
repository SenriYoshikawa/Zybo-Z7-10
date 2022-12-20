`timescale 1ps/1ps
module sExe1
 (//Input:  name_i_modulename
  //Output: name_o_modulename

  opr0_i_sexe1,      //IN
  opr1_i_sexe1,
  mem_wen_i_sexe1,
  dopc_i_sexe1,
  cc_i_sexe1,
  imm16_i_exe1,
  acc_sel_i_sexe1,
  pe_out_i_sexe1,
  pe_num_i_sexe1,
  f_mem_w_i_sexe1,
  dm_dopc_i_sexe1,
  dm_addr_i_sexe1,
  sysreg_wen_vctr_i_sexe1,
  t_next_lr_i_sexe1,
  t_next_uni_opr_i_sexe1,
  t_next_node_i_sexe1,
  f_next_lr_i_sexe1,
  f_next_uni_opr_i_sexe1,
  f_next_node_i_sexe1,
  gen_i_sexe1,
  cp_i_sexe1,
  terminate_i_sexe1,
  nInterC_S_sExe0_uC_uCX2,
  nInterC_A_sMem0_uC_uCX2,
  
  lopen,
  rst,
  

  opr0_o_sexe1,        //OUT
  opr1_o_sexe1,
  dm_addr_o_sexe1,
  mem_wen_o_sexe1,
  dm_dopc_o_sexe1,
  pe_out_o_sexe1,
  pe_num_o_sexe1,
  f_mem_w_o_sexe1,
  next_lr_o_sexe1,
  next_node_o_sexe1,
  gen_o_sexe1,
  next_uni_opr_o_sexe1,
  nInterC_S_uCX2_sMem0_uC,
  nInterC_A_uCX2_sExe0_uC,

  sp_disen_o_sexe1
  );


  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  //from Exe0 
  input [31:0]  opr0_i_sexe1;
  input [31:0]  opr1_i_sexe1;
  input         mem_wen_i_sexe1;
  input [6:0]   dopc_i_sexe1;
  input [1:0]   cc_i_sexe1;
  input [15:0]	imm16_i_exe1;
  input [3:0]   acc_sel_i_sexe1;
  input         pe_out_i_sexe1;
  input [2:0]   pe_num_i_sexe1;
  input         f_mem_w_i_sexe1;
  input [2:0]   dm_dopc_i_sexe1;
  input [13:0]  dm_addr_i_sexe1;
  input [7:0]   sysreg_wen_vctr_i_sexe1;
  input         t_next_lr_i_sexe1;
  input         t_next_uni_opr_i_sexe1;
  input [15:0]  t_next_node_i_sexe1;
  input         f_next_lr_i_sexe1;
  input         f_next_uni_opr_i_sexe1;
  input [15:0]  f_next_node_i_sexe1;
  input [11:0]  gen_i_sexe1;
  input         cp_i_sexe1;
  input         terminate_i_sexe1;
  input         nInterC_S_sExe0_uC_uCX2;
  //from Mem0
  input         nInterC_A_sMem0_uC_uCX2;
 
  input         lopen;
  input         rst;

  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  //to Mem0
  output [31:0] opr0_o_sexe1;
  output [31:0] opr1_o_sexe1;
  output [13:0] dm_addr_o_sexe1;
  output        mem_wen_o_sexe1;
  output [2:0]  dm_dopc_o_sexe1;
  output        pe_out_o_sexe1;
  output [2:0]  pe_num_o_sexe1;
  output        f_mem_w_o_sexe1;
  output        next_lr_o_sexe1;
  output [15:0] next_node_o_sexe1;
  output [11:0] gen_o_sexe1;
  output        next_uni_opr_o_sexe1;
  output        nInterC_S_uCX2_sMem0_uC;
  //to Exe0
  output        nInterC_A_uCX2_sExe0_uC;

  output        sp_disen_o_sexe1;
  

  /***********************************************************/
  /*                 DEFINITION OF WIRE                      */
  /***********************************************************/

  wire    clk_sexe1;
  
  wire    cppkt_sexe1;
  


  /***********************************************************/
  /*                       INCLUDE CX2                       */
  /***********************************************************/

  wire send_delay;
  wire ack_delay;
     
  CELEMENT_Exe1 uCX2_Exe1(
    .RESETN( rst ),
    .EXBIN( ~terminate_i_sexe1 ),
    .CPYIN( cp_i_sexe1 ),
    .SENDIN( nInterC_S_sExe0_uC_uCX2 ),
    .ACKIN( nInterC_A_sMem0_uC_uCX2 ),
    
    .SENDOUT( send_delay ),
    .ACKOUT( ack_delay ),
    .FEBOUT( cppkt_sexe1 ),
    .CP( clk_sexe1 ),
    .LOPEN( lopen )
  );

  buf #(0, 0) (nInterC_S_uCX2_sMem0_uC, send_delay);
  buf #(8228, 4836) (nInterC_A_uCX2_sExe0_uC, ack_delay);


  /***********************************************************/
  /*                       INCLUDE Exe1                      */
  /***********************************************************/

  Exe1 iExe1( 
    .opr0_i_exe1( opr0_i_sexe1 ),
    .opr1_i_exe1( opr1_i_sexe1 ),
    .mem_wen_i_exe1( mem_wen_i_sexe1 ),
    .dopc_i_exe1( dopc_i_sexe1 ),
    .cc_i_exe1( cc_i_sexe1 ),
    .imm16_i_exe1( imm16_i_exe1 ),
    .acc_sel_i_exe1( acc_sel_i_sexe1 ),
    .pe_out_i_exe1( pe_out_i_sexe1 ),
    .pe_num_i_exe1( pe_num_i_sexe1 ),
    .f_mem_w_i_exe1( f_mem_w_i_sexe1 ),
    .dm_dopc_i_exe1( dm_dopc_i_sexe1 ),
    .dm_addr_i_exe1( dm_addr_i_sexe1 ),
    .sysreg_wen_vctr_i_exe1( sysreg_wen_vctr_i_sexe1 ),
    .t_next_lr_i_exe1( t_next_lr_i_sexe1 ),
    .t_next_uni_opr_i_exe1( t_next_uni_opr_i_sexe1 ),
    .t_next_node_i_exe1( t_next_node_i_sexe1 ),
    .f_next_lr_i_exe1( f_next_lr_i_sexe1 ),
    .f_next_uni_opr_i_exe1( f_next_uni_opr_i_sexe1 ),
    .f_next_node_i_exe1( f_next_node_i_sexe1 ),
    .gen_i_exe1( gen_i_sexe1 ),
    .rst( rst ),
    .clk( clk_sexe1 ),
    .cppkt( cppkt_sexe1 ),

    .opr0_o_exe1( opr0_o_sexe1 ),
    .opr1_o_exe1( opr1_o_sexe1 ),
    .dm_addr_o_exe1( dm_addr_o_sexe1 ),
    .mem_wen_o_exe1( mem_wen_o_sexe1 ),
    .dm_dopc_o_exe1( dm_dopc_o_sexe1 ),
    .pe_out_o_exe1( pe_out_o_sexe1 ),
    .pe_num_o_exe1( pe_num_o_sexe1 ),
    .f_mem_w_o_exe1( f_mem_w_o_sexe1 ),
    .next_lr_o_exe1( next_lr_o_sexe1 ),
    .next_node_o_exe1( next_node_o_sexe1 ),
    .gen_o_exe1( gen_o_sexe1 ),
    .next_uni_opr_o_exe1( next_uni_opr_o_sexe1 ),
    
    .sp_disen_o_exe1( sp_disen_o_sexe1 )
  );


endmodule //sExe1
