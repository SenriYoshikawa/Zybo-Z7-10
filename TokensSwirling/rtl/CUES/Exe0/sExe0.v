`timescale 1ps/1ps
module sExe0
 (//Input:  name_i_modulename
  //Output: name_o_modulename

  node_i_sexe0,        //IN
  gen_i_sexe0,
  opr0_i_sexe0,
  opr1_i_sexe0,
  mem_wen_i_sexe0,
  dopc_i_sexe0,
  ins_i_sexe0,
  nInterC_S_sDec0_uC_uC,
  nInterC_A_sExe1_uCX2_uC,
  
  lopen,
  rst,


  opr0_o_sexe0,        //OUT
  opr1_o_sexe0,
  mem_wen_o_sexe0,
  dopc_o_sexe0,
  cc_o_sexe0,
  imm16_o_sexe0,
  acc_sel_o_sexe0,
  pe_out_o_sexe0,
  pe_num_o_sexe0,
  f_mem_w_o_sexe0,
  dm_dopc_o_sexe0,
  dm_addr_o_sexe0,
  sysreg_wen_vctr_o_sexe0,
  t_next_lr_o_sexe0,
  t_next_uni_opr_o_sexe0,
  t_next_node_o_sexe0,
  f_next_lr_o_sexe0,
  f_next_uni_opr_o_sexe0,
  f_next_node_o_sexe0,
  gen_o_sexe0,
  cp_o_sexe0,
  terminate_o_sexe0,
  
  nInterC_S_uC_sExe1_uCX2,
  nInterC_A_uC_sDec0_uC
  );


  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  //from Dec0
  input [15:0]  node_i_sexe0;
  input [11:0]  gen_i_sexe0;
  input [31:0]  opr0_i_sexe0;
  input [31:0]  opr1_i_sexe0;
  input         mem_wen_i_sexe0;
  input [9:0]   dopc_i_sexe0;
  input [26:0]  ins_i_sexe0;
  input         nInterC_S_sDec0_uC_uC;
  //from Exe1
  input         nInterC_A_sExe1_uCX2_uC;
  
  input         lopen;
  input         rst;

  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  //to Exe1
  output [31:0] opr0_o_sexe0;
  output [31:0] opr1_o_sexe0;
  output        mem_wen_o_sexe0;
  output [6:0]  dopc_o_sexe0;
  output [1:0]  cc_o_sexe0;
  output [15:0]	imm16_o_sexe0;
  output [3:0]  acc_sel_o_sexe0;
  output        pe_out_o_sexe0;
  output [2:0]  pe_num_o_sexe0;
  output        f_mem_w_o_sexe0;
  output [2:0]  dm_dopc_o_sexe0;
  output [13:0] dm_addr_o_sexe0;
  output [7:0]  sysreg_wen_vctr_o_sexe0;
  output        t_next_lr_o_sexe0;
  output        t_next_uni_opr_o_sexe0;
  output [15:0] t_next_node_o_sexe0;
  output        f_next_lr_o_sexe0;
  output        f_next_uni_opr_o_sexe0;
  output [15:0] f_next_node_o_sexe0;
  output [11:0] gen_o_sexe0;
  output        cp_o_sexe0;
  output        terminate_o_sexe0;
  output        nInterC_S_uC_sExe1_uCX2;
  //to Dec0
  output        nInterC_A_uC_sDec0_uC;
  

  /***********************************************************/
  /*                 DEFINITION OF WIRE                      */
  /***********************************************************/

  wire    clk_sexe0;


  /***********************************************************/
  /*                        INCLUDE C                        */
  /***********************************************************/

  wire send_delay;
  wire ack_delay;
     
  CELEMENT_Exe0 uC_Exe0(
    .RESETN( rst ),
    .SENDIN( nInterC_S_sDec0_uC_uC ),
    .ACKIN( nInterC_A_sExe1_uCX2_uC ),
    
    .SENDOUT( send_delay ),
    .ACKOUT( ack_delay ),
    .CP( clk_sexe0 ),
    .LOPEN( lopen )
  );

  
  buf #(7593, 10637) (nInterC_S_uC_sExe1_uCX2, send_delay);
  buf #(8592, 3169) (nInterC_A_uC_sDec0_uC, ack_delay);


  /***********************************************************/
  /*                       INCLUDE Exe0                      */
  /***********************************************************/

  Exe0 iExe0( 
    .node_i_exe0( node_i_sexe0 ),    //IN
    .gen_i_exe0( gen_i_sexe0 ),
    .opr0_i_exe0( opr0_i_sexe0 ),
    .opr1_i_exe0( opr1_i_sexe0 ),
    .mem_wen_i_exe0( mem_wen_i_sexe0 ),
    .dopc_i_exe0( dopc_i_sexe0 ),
    .ins_i_exe0( ins_i_sexe0 ),
    .pg_mul_i_exe0( 1'b1 ),
    .pg_sh_i_exe0( 1'b1 ),
    .pg_mul_exe0( 1'b1 ),
    .pg_sh_exe0( 1'b1 ),
    .rst( rst ),
    .clk( clk_sexe0 ),

    .opr0_o_exe0( opr0_o_sexe0 ),    //OUT
    .opr1_o_exe0( opr1_o_sexe0 ),
    .mem_wen_o_exe0( mem_wen_o_sexe0 ),
    .dopc_o_exe0( dopc_o_sexe0 ),
    .cc_o_exe0( cc_o_sexe0 ),
    .imm16_o_exe0( imm16_o_sexe0 ),
    .acc_sel_o_exe0( acc_sel_o_sexe0 ),
    .pe_out_o_exe0( pe_out_o_sexe0 ),
    .pe_num_o_exe0( pe_num_o_sexe0 ),
    .f_mem_w_o_exe0( f_mem_w_o_sexe0 ),
    .dm_dopc_o_exe0( dm_dopc_o_sexe0 ),
    .dm_addr_o_exe0( dm_addr_o_sexe0 ),
    .sysreg_wen_vctr_o_exe0( sysreg_wen_vctr_o_sexe0 ),
    .t_next_lr_o_exe0( t_next_lr_o_sexe0 ),
    .t_next_uni_opr_o_exe0( t_next_uni_opr_o_sexe0 ),
    .t_next_node_o_exe0( t_next_node_o_sexe0 ),
    .f_next_lr_o_exe0( f_next_lr_o_sexe0 ),
    .f_next_uni_opr_o_exe0( f_next_uni_opr_o_sexe0 ),
    .f_next_node_o_exe0( f_next_node_o_sexe0 ),
    .gen_o_exe0( gen_o_sexe0 ),
    .cp_o_exe0( cp_o_sexe0 ),
    .terminate_o_exe0( terminate_o_sexe0 )
  );


endmodule //sExe0
