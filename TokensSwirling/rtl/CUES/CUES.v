`timescale 1ps/1ps
module CUES
 (//Input:  name_i_modulename
  //Output: name_o_modulename
  //Wire:   name_FromModule_to_ToModule

  ///////////////////////////////////////////////////
  // input
  //from ICN to Mer
  lr_i,
  node_i,
  gen_i,
  opr_i,
  uni_opr_i,
  mem_wen_i,
  nInterC_S_sICN_uC_sMer_uCM,
  //from ICN to Sw
  nInterC_A_sICN_uC_sSw_uCB,
  //lopen
  lopen,
  //clear
  rstn,
  
  ///////////////////////////////////////////////////
  // output
  //from Mer to ICN
  nInterC_A_sMer_uCM_sICN_uC,
  //from Sw to ICN
  pe_num_ssw_to_icn,
  mem_w_ssw_to_icn,
  lr_ssw_to_icn,
  node_ssw_to_icn,
  gen_ssw_to_icn,
  opr_ssw_to_icn,
  uni_opr_ssw_to_icn,
  nInterC_S_sSw_uCB_sICN_uC,
  //MM Condition
  mm_overflow_o_pe,
  // Probe
  prob1,
  prob2
  );
  
  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  //from ICN to Mer
  input   lr_i;
  input [13:0]  node_i;
  input [11:0]  gen_i;
  input [31:0]  opr_i;
  input   uni_opr_i;
  input [1:0]   mem_wen_i;
  input   nInterC_S_sICN_uC_sMer_uCM;
  //from ICN to Sw
  input   nInterC_A_sICN_uC_sSw_uCB;
  //lopen
  input   lopen;
  //clear
  input   rstn;
  

  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  //from Mer to ICN
  output        nInterC_A_sMer_uCM_sICN_uC;
  //from Sw to ICN
  output [2:0]  pe_num_ssw_to_icn;
  output [1:0]  mem_w_ssw_to_icn;
  output        lr_ssw_to_icn;
  output [13:0] node_ssw_to_icn;
  wire [15:0]   node_out;
  assign        node_ssw_to_icn = node_out[13:0];
  output [11:0] gen_ssw_to_icn;
  output [31:0] opr_ssw_to_icn;
  output        uni_opr_ssw_to_icn;
  output        nInterC_S_sSw_uCB_sICN_uC;
  //MM Condition
  output        mm_overflow_o_pe;
  // Probe
  output        prob1;
  output        prob2;


  /***********************************************************/
  /*                 DEFINITION OF WIRE                      */
  /***********************************************************/
  
  /// sMer /////////////////////////////////////

  wire          lr_smer_to_sfc0;
  wire [15:0]   node_smer_to_sfc0;
  wire [11:0]   gen_smer_to_sfc0;
  wire [31:0]   opr_smer_to_sfc0;
  wire          uni_opr_smer_to_sfc0;
  wire [1:0]    mem_wen_smer_to_sfc0;
  wire          nInterC_S_sMer_uCM_sFC0_uC;
  wire          nInterC_A_sMer_uCM_sSw_uCB;
  assign prob1 = nInterC_S_sMer_uCM_sFC0_uC;


  /// sFC0 /////////////////////////////////////

  wire          lr_sfc0_to_sfc1;
  wire [15:0]   node_sfc0_to_sfc1;
  wire [11:0]   gen_sfc0_to_sfc1;
  wire [31:0]   opr_sfc0_to_sfc1;
  wire [1:0]    mem_wen_sfc0_to_sfc1;
  wire [31:0]   mtch_data_sfc0_to_sfc1;
  wire          mtch_rslt_cex_sfc0_to_sfc1;
  wire          nInterC_S_sFC0_uC_sFC1_uCEX;
  wire          nInterC_A_sFC0_uC_sMer_uCM;
  assign prob2 = nInterC_S_sFC0_uC_sFC1_uCEX;


  /// sFC1 /////////////////////////////////////

  wire [15:0]   node_sfc1_to_ssm;
  wire [11:0]   gen_sfc1_to_ssm;
  wire [31:0]   opr0_sfc1_to_ssm;
  wire [31:0]   opr1_sfc1_to_ssm;
  wire [1:0]    mem_wen_sfc1_to_ssm;
  wire          nInterC_S_sFC1_uCEX_sSM_uCM;
  wire          nInterC_A_sFC1_uCEX_sFC0_uC;


  /// sSM /////////////////////////////////////

  wire [15:0]   node_ssm_to_ftc0;
  wire [11:0]   gen_ssm_to_ftc0;
  wire [31:0]   opr0_ssm_to_ftc0;
  wire [31:0]   opr1_ssm_to_ftc0;
  wire [1:0]    mem_wen_ssm_to_ftc0;
  wire          nInterC_S_sSM_uCM_sFtc0_uC;
  wire          nInterC_A_sSM_uCM_sSB_uCB;
  wire          nInterC_A_sSM_uCM_sFC1_uCEX;


  /// sFtc0 ////////////////////////////////////

  wire [15:0] node_sftc0_to_sftc1;
  wire [11:0] gen_sftc0_to_sftc1;
  wire [31:0] opr0_sftc0_to_sftc1;
  wire [31:0] opr1_sftc0_to_sftc1;
  wire [1:0]  mem_wen_sftc0_to_sftc1;
  wire        w_en_cex_sftc0_to_sftc1;
  wire        nInterC_S_sFtc0_uC_sFtc1_uCEX;
  wire        nInterC_A_sFtc0_uC_sSM_uCM;


  /// sFtc1 ////////////////////////////////////

  wire [15:0] node_sftc1_to_sdec0;
  wire [11:0] gen_sftc1_to_sdec0;
  wire [31:0] opr0_sftc1_to_sdec0;
  wire [31:0] opr1_sftc1_to_sdec0;
  wire        mem_wen_sftc1_to_sdec0;
  wire [33:0] ins_sftc1_to_sdec0;
  wire        nInterC_S_sFtc1_uCEX_sDec0_uC;
  wire        nInterC_A_sFtc1_uCEX_sFtc0_uC;


  /// sDec0 ////////////////////////////////////

  wire [15:0] node_sdec0_to_sexe0;
  wire [11:0] gen_sdec0_to_sexe0;
  wire [31:0] opr0_sdec0_to_sexe0;
  wire [31:0] opr1_sdec0_to_sexe0;
  wire        mem_wen_sdec0_to_sexe0;
  wire [9:0]  dopc_sdec0_to_sexe0;
  wire [26:0] ins_sdec0_to_sexe0;
  wire        pg_mul_sdec0_to_sexe0;
  wire        pg_sh_sdec0_to_sexe0;
  wire        nInterC_S_sDec0_uC_sExe0_uC;
  wire        nInterC_A_sDec0_uC_sFtc1_uCEX;


  /// sExe0 ////////////////////////////////////

  wire [31:0] opr0_sexe0_to_sexe1;
  wire [31:0] opr1_sexe0_to_sexe1;
  wire        mem_wen_sexe0_to_sexe1;
  wire [6:0]  dopc_sexe0_to_sexe1;
  wire [1:0]  cc_sexe0_to_sexe1;
  wire [15:0]	imm16_sexe0_to_sexe1;
  wire [3:0]  acc_sel_sexe0_to_sexe1;
  wire        pe_out_sexe0_to_sexe1;
  wire [2:0]  pe_num_sexe0_to_sexe1;
  wire        f_mem_w_sexe0_to_sexe1;
  wire [2:0]  dm_dopc_sexe0_to_sexe1;
  wire [13:0] dm_addr_sexe0_to_sexe1;
  wire [7:0]  sysreg_wen_vctr_sexe0_to_sexe1;
  wire        t_next_lr_sexe0_to_sexe1;
  wire        t_next_uni_opr_sexe0_to_sexe1;
  wire [15:0] t_next_node_sexe0_to_sexe1;
  wire        f_next_lr_sexe0_to_sexe1;
  wire        f_next_uni_opr_sexe0_to_sexe1;
  wire [15:0] f_next_node_sexe0_to_sexe1;
  wire [11:0] gen_sexe0_to_sexe1;
  wire        cp_sexe0_to_sexe1;
  wire        terminate_sexe0_to_sexe1;
  wire        nInterC_S_sExe0_uC_sExe1_uCX2;
  wire        nInterC_A_sExe0_uC_sDec0_uC;

  /// sExe1 ////////////////////////////////////

  wire [31:0] opr0_sexe1_to_smem0;
  wire [31:0] opr1_sexe1_to_smem0;
  wire [13:0] dm_addr_sexe1_to_smem0;
  wire        mem_wen_sexe1_to_smem0;
  wire [2:0]  dm_dopc_sexe1_to_smem0;
  wire        pe_out_sexe1_to_smem0;
  wire [2:0]  pe_num_sexe1_to_smem0;
  wire        f_mem_w_sexe1_to_smem0;
  wire        next_lr_sexe1_to_smem0;
  wire [15:0] next_node_sexe1_to_smem0;
  wire        next_uni_opr_sexe1_to_smem0;
  wire [11:0] gen_sexe1_to_smem0;
  wire        nInterC_S_sExe1_uCX2_sMem0_uC;
  wire        nInterC_A_sExe1_uCX2_sExe0_uC;
  wire        sp_disen_sexe1;

  /// sMem0 ////////////////////////////////////

  wire [31:0] opr0_smem0_to_smem1;
  wire [31:0] opr1_smem0_to_smem1;
  wire [13:0] dm_addr_smem0_to_smem1;
  wire        mem_wen_smem0_to_smem1;
  wire [2:0]  dm_dopc_smem0_to_smem1;
  wire        pe_out_smem0_to_smem1;
  wire [2:0]  pe_num_smem0_to_smem1;
  wire        f_mem_w_smem0_to_smem1;
  wire        next_lr_smem0_to_smem1;
  wire [15:0] next_node_smem0_to_smem1;
  wire [11:0] gen_smem0_to_smem1;
  wire        next_uni_opr_smem0_to_smem1;
  wire        w_en_cex_smem0_to_smem1;
  wire        nInterC_S_sMem0_uC_sMem1_uCEX;
  wire        nInterC_A_sMem0_uC_sExe1_uCX2;


  /// sMem1 ////////////////////////////////////

  wire [31:0] opr0_smem1_to_ssb;
  wire        dm_data_valid_smem1_to_ssb;
  wire [31:0] dm_data_smem1_to_ssb;
  wire        pe_out_smem1_to_ssb;
  wire [2:0]  pe_num_smem1_to_ssb;
  wire        f_mem_w_smem1_to_ssb;
  wire        next_lr_smem1_to_ssb;
  wire [15:0] next_node_smem1_to_ssb;
  wire [11:0] gen_smem1_to_ssb;
  wire        next_uni_opr_smem1_to_ssb;
  wire        nInterC_S_sMem1_uCEX_sSB_uCB;
  wire        nInterC_A_sMem1_uCEX_sMem0_uC;
  

  /// sSB //////////////////////////////////////

  wire        lr_ssb_to_ssw;
  wire [15:0] node_ssb_to_ssw;
  wire [11:0] gen_ssb_to_ssw;
  wire [31:0] opr_ssb_to_ssw;
  wire        pe_out_ssb_to_ssw;
  wire [2:0]  pe_num_ssb_to_ssw;
  wire        f_mem_w_ssb_to_ssw;
  wire        uni_opr_ssb_to_ssw;
  wire [15:0] node_ssb_to_ssm;
  wire [11:0] gen_ssb_to_ssm;
  wire [31:0] opr_ssb_to_ssm;
  wire [1:0]  mem_wen_ssb_to_ssm;
  wire        nInterC_S_sSB_uCB_sSw_uCB;
  wire        nInterC_S_sSB_uCB_sSM_uCM;
  wire        nInterC_A_sSB_uCB_sMem1_uCEX;


  /// sSw //////////////////////////////////////

  wire        lr_ssw_to_smer;
  wire [15:0] node_ssw_to_smer;
  wire [11:0] gen_ssw_to_smer;
  wire [31:0] opr_ssw_to_smer;
  wire        uni_opr_ssw_to_smer;
  wire        mem_w_ssw_to_smer;
  wire        nInterC_S_sSw_uCB_sMer_uCM;
  wire        nInterC_A_sSw_uCB_sSB_uCB;


  /***********************************************************/
  /*                       sMer                              */
  /***********************************************************/

  sMer sMer(
    .lr_sw_i_smer( lr_ssw_to_smer ),
    .node_sw_i_smer( node_ssw_to_smer ),
    .gen_sw_i_smer( gen_ssw_to_smer ),
    .opr_sw_i_smer( opr_ssw_to_smer ),
    .uni_opr_sw_i_smer( uni_opr_ssw_to_smer ),
    .lr_icn_i_smer( lr_i ),
    .node_icn_i_smer( {2'b0,node_i} ),
    .gen_icn_i_smer( gen_i ),
    .opr_icn_i_smer( opr_i ),
    .uni_opr_icn_i_smer( uni_opr_i ),
    .mem_wen_icn_i_smer( mem_wen_i ),
    .nInterC_S_sSw_uCB_uCM( nInterC_S_sSw_uCB_sMer_uCM ),
    .nInterC_S_sICN_uC_uCM( nInterC_S_sICN_uC_sMer_uCM ),
    .nInterC_A_sFC0_uC_uCM( nInterC_A_sFC0_uC_sMer_uCM ),

    .lopen( lopen ),
    .rst( rstn ),


    .lr_o_smer( lr_smer_to_sfc0 ),
    .node_o_smer( node_smer_to_sfc0 ),
    .gen_o_smer( gen_smer_to_sfc0 ),
    .opr_o_smer( opr_smer_to_sfc0 ),
    .uni_opr_o_smer( uni_opr_smer_to_sfc0 ),
    .mem_wen_o_smer( mem_wen_smer_to_sfc0 ),
    .nInterC_S_uCM_sFC0_uC( nInterC_S_sMer_uCM_sFC0_uC ),
    .nInterC_A_uCM_sSw_uCB( nInterC_A_sMer_uCM_sSw_uCB ),
    .nInterC_A_uCM_sICN_uC( nInterC_A_sMer_uCM_sICN_uC )

  );


  /***********************************************************/
  /*                       sFC0                              */
  /***********************************************************/
  
  sFC0 sFC0(
    .lr_i_sfc0( lr_smer_to_sfc0 ),
    .node_i_sfc0( node_smer_to_sfc0 ),
    .gen_i_sfc0( gen_smer_to_sfc0 ),
    .opr_i_sfc0( opr_smer_to_sfc0 ),
    .uni_opr_i_sfc0( uni_opr_smer_to_sfc0 ),
    .mem_wen_i_sfc0( mem_wen_smer_to_sfc0 ),
    .nInterC_S_sMer_uCM_uC( nInterC_S_sMer_uCM_sFC0_uC ),
    .nInterC_A_sFC1_uCEX_uC( nInterC_A_sFC1_uCEX_sFC0_uC ),

    .lopen( lopen ),
    .rst( rstn ),


    .lr_o_sfc0( lr_sfc0_to_sfc1 ),
    .node_o_sfc0( node_sfc0_to_sfc1 ),
    .gen_o_sfc0( gen_sfc0_to_sfc1 ),
    .opr_o_sfc0( opr_sfc0_to_sfc1 ),
    .mem_wen_o_sfc0( mem_wen_sfc0_to_sfc1 ),
    .mtch_data_o_sfc0( mtch_data_sfc0_to_sfc1 ),
    .mtch_rslt_cex_o_sfc0( mtch_rslt_cex_sfc0_to_sfc1 ),
    .nInterC_S_uC_sFC1_uCEX( nInterC_S_sFC0_uC_sFC1_uCEX ),
    .nInterC_A_uC_sMer_uCM( nInterC_A_sFC0_uC_sMer_uCM ),
    
    .mm_full_sfc0( mm_overflow_o_pe )
  );


  /***********************************************************/
  /*                       sFC1                              */
  /***********************************************************/

  sFC1 sFC1(
    .lr_i_sfc1( lr_sfc0_to_sfc1 ),
    .node_i_sfc1( node_sfc0_to_sfc1 ),
    .gen_i_sfc1( gen_sfc0_to_sfc1 ),
    .opr_i_sfc1( opr_sfc0_to_sfc1 ),
    .mem_wen_i_sfc1( mem_wen_sfc0_to_sfc1 ),
    .mtch_data_i_sfc1( mtch_data_sfc0_to_sfc1 ),
    .mtch_rslt_cex_i_sfc1( mtch_rslt_cex_sfc0_to_sfc1 ),
    .nInterC_S_sFC0_uC_uCEX( nInterC_S_sFC0_uC_sFC1_uCEX ),
    .nInterC_A_sSM_uCM_uCEX( nInterC_A_sSM_uCM_sFC1_uCEX ),

    .lopen( lopen ),
    .rst( rstn ),


    .node_o_sfc1( node_sfc1_to_ssm ),
    .gen_o_sfc1( gen_sfc1_to_ssm ),
    .opr0_o_sfc1( opr0_sfc1_to_ssm ),
    .opr1_o_sfc1( opr1_sfc1_to_ssm ),
    .mem_wen_o_sfc1( mem_wen_sfc1_to_ssm ),
    .nInterC_S_uCEX_sSM_uCM( nInterC_S_sFC1_uCEX_sSM_uCM ),
    .nInterC_A_uCEX_sFC0_uC( nInterC_A_sFC1_uCEX_sFC0_uC )
  );


  /***********************************************************/
  /*                       sSM                            */
  /***********************************************************/
  
  sSM sSM(
    .node_sb_i_ssm( node_ssb_to_ssm ),
    .gen_sb_i_ssm( gen_ssb_to_ssm ),
    .opr_sb_i_ssm( opr_ssb_to_ssm ),
    .mem_wen_sb_i_ssm( mem_wen_ssb_to_ssm ),
    .node_fc1_i_ssm( node_sfc1_to_ssm ),
    .gen_fc1_i_ssm( gen_sfc1_to_ssm ),
    .opr0_fc1_i_ssm( opr0_sfc1_to_ssm ),
    .opr1_fc1_i_ssm( opr1_sfc1_to_ssm ),
    .mem_wen_fc1_i_ssm( mem_wen_sfc1_to_ssm ),
    .nInterC_S_sSB_uCB_uCM( nInterC_S_sSB_uCB_sSM_uCM ),
    .nInterC_S_sFC1_uCEX_uCM( nInterC_S_sFC1_uCEX_sSM_uCM ),
    .nInterC_A_sFtc0_uC_uCM( nInterC_A_sFtc0_uC_sSM_uCM ),

    .lopen( lopen ),
    .rst( rstn ),


    .node_o_ssm( node_ssm_to_ftc0 ),
    .gen_o_ssm( gen_ssm_to_ftc0 ),
    .opr0_o_ssm( opr0_ssm_to_ftc0 ),
    .opr1_o_ssm( opr1_ssm_to_ftc0 ),
    .mem_wen_o_ssm( mem_wen_ssm_to_ftc0 ),
    .nInterC_S_uCM_sFtc0_uC( nInterC_S_sSM_uCM_sFtc0_uC ),
    .nInterC_A_uCM_sSB_uCB( nInterC_A_sSM_uCM_sSB_uCB ),
    .nInterC_A_uCM_sFC1_uCEX( nInterC_A_sSM_uCM_sFC1_uCEX )
  );


  /***********************************************************/
  /*                       sFtc0                             */
  /***********************************************************/
  
  sFtc0 sFtc0(
    .node_i_sftc0( node_ssm_to_ftc0 ),
    .gen_i_sftc0( gen_ssm_to_ftc0 ),
    .opr0_i_sftc0( opr0_ssm_to_ftc0 ),
    .opr1_i_sftc0( opr1_ssm_to_ftc0 ),
    .mem_wen_i_sftc0( mem_wen_ssm_to_ftc0 ),
    .nInterC_S_sSM_uCEX_uC( nInterC_S_sSM_uCM_sFtc0_uC ),
    .nInterC_A_sFtc1_uCEX_uC( nInterC_A_sFtc1_uCEX_sFtc0_uC ),

    .lopen( lopen ),
    .rst( rstn ),


    .node_o_sftc0( node_sftc0_to_sftc1 ),
    .gen_o_sftc0( gen_sftc0_to_sftc1 ),
    .opr0_o_sftc0( opr0_sftc0_to_sftc1 ),
    .opr1_o_sftc0( opr1_sftc0_to_sftc1 ),
    .mem_wen_o_sftc0( mem_wen_sftc0_to_sftc1 ),
    .w_en_cex_o_sftc0( w_en_cex_sftc0_to_sftc1 ),
    .nInterC_S_uC_sFtc1_uCEX( nInterC_S_sFtc0_uC_sFtc1_uCEX ),
    .nInterC_A_uC_sSM_uCEX( nInterC_A_sFtc0_uC_sSM_uCM )
  );


  /***********************************************************/
  /*                       sFtc1                             */
  /***********************************************************/
  sFtc1 sFtc1(
    .node_i_sftc1( node_sftc0_to_sftc1 ),
    .gen_i_sftc1( gen_sftc0_to_sftc1 ),
    .opr0_i_sftc1( opr0_sftc0_to_sftc1 ),
    .opr1_i_sftc1( opr1_sftc0_to_sftc1 ),
    .mem_wen_i_sftc1( mem_wen_sftc0_to_sftc1 ),
    .w_en_cex_i_sftc1( w_en_cex_sftc0_to_sftc1 ),
    .nInterC_S_sFtc0_uC_uCEX( nInterC_S_sFtc0_uC_sFtc1_uCEX ),
    .nInterC_A_sDec0_uC_uCEX( nInterC_A_sDec0_uC_sFtc1_uCEX ),

    .lopen( lopen ),
    .rst( rstn ),

    .node_o_sftc1( node_sftc1_to_sdec0 ),
    .gen_o_sftc1( gen_sftc1_to_sdec0 ),
    .opr0_o_sftc1( opr0_sftc1_to_sdec0 ),
    .opr1_o_sftc1( opr1_sftc1_to_sdec0 ),
    .mem_wen_o_sftc1( mem_wen_sftc1_to_sdec0 ),
    .ins_o_sftc1( ins_sftc1_to_sdec0 ),
    .nInterC_S_uCEX_sDec0_uC( nInterC_S_sFtc1_uCEX_sDec0_uC ),
    .nInterC_A_uCEX_sFtc0_uC( nInterC_A_sFtc1_uCEX_sFtc0_uC )
  );


  /***********************************************************/
  /*                       sDec0                             */
  /***********************************************************/
  
   sDec0 sDec0(
    .node_i_sdec0( node_sftc1_to_sdec0 ),
    .gen_i_sdec0( gen_sftc1_to_sdec0 ),
    .opr0_i_sdec0( opr0_sftc1_to_sdec0 ),
    .opr1_i_sdec0( opr1_sftc1_to_sdec0 ),
    .mem_wen_i_sdec0( mem_wen_sftc1_to_sdec0 ),
    .ins_i_sdec0( ins_sftc1_to_sdec0 ),
    .nInterC_S_sFtc1_uCEX_uC( nInterC_S_sFtc1_uCEX_sDec0_uC ),
    .nInterC_A_sExe0_uC_uC( nInterC_A_sExe0_uC_sDec0_uC ),

    .lopen( lopen ),
    .rst( rstn ),


    .node_o_sdec0( node_sdec0_to_sexe0 ),
    .gen_o_sdec0( gen_sdec0_to_sexe0 ),
    .opr0_o_sdec0( opr0_sdec0_to_sexe0 ),
    .opr1_o_sdec0( opr1_sdec0_to_sexe0 ),
    .mem_wen_o_sdec0( mem_wen_sdec0_to_sexe0 ),
    .dopc_o_sdec0( dopc_sdec0_to_sexe0 ),
    .ins_o_sdec0( ins_sdec0_to_sexe0 ),
    .nInterC_S_uC_sExe0_uC( nInterC_S_sDec0_uC_sExe0_uC ),
    .nInterC_A_uC_sFtc1_uCEX( nInterC_A_sDec0_uC_sFtc1_uCEX )
  );


  /***********************************************************/
  /*                       sExe0                             */
  /***********************************************************/
  
  sExe0 sExe0(
    .node_i_sexe0( node_sdec0_to_sexe0 ),
    .gen_i_sexe0( gen_sdec0_to_sexe0 ),
    .opr0_i_sexe0( opr0_sdec0_to_sexe0 ),
    .opr1_i_sexe0( opr1_sdec0_to_sexe0 ),
    .mem_wen_i_sexe0( mem_wen_sdec0_to_sexe0 ),
    .dopc_i_sexe0( dopc_sdec0_to_sexe0 ),
    .ins_i_sexe0( ins_sdec0_to_sexe0 ),
    .nInterC_S_sDec0_uC_uC( nInterC_S_sDec0_uC_sExe0_uC ),
    .nInterC_A_sExe1_uCX2_uC( nInterC_A_sExe1_uCX2_sExe0_uC ),

    .lopen( lopen ),
    .rst( rstn ),

    
    .opr0_o_sexe0( opr0_sexe0_to_sexe1 ),
    .opr1_o_sexe0( opr1_sexe0_to_sexe1 ),
    .mem_wen_o_sexe0( mem_wen_sexe0_to_sexe1 ),
    .dopc_o_sexe0( dopc_sexe0_to_sexe1 ),
    .cc_o_sexe0( cc_sexe0_to_sexe1 ),
    .acc_sel_o_sexe0( acc_sel_sexe0_to_sexe1 ),
    .imm16_o_sexe0( imm16_sexe0_to_sexe1 ),
    .pe_out_o_sexe0( pe_out_sexe0_to_sexe1 ),
    .pe_num_o_sexe0( pe_num_sexe0_to_sexe1 ),
    .f_mem_w_o_sexe0( f_mem_w_sexe0_to_sexe1 ),
    .dm_dopc_o_sexe0( dm_dopc_sexe0_to_sexe1 ),
    .dm_addr_o_sexe0( dm_addr_sexe0_to_sexe1 ),
    .sysreg_wen_vctr_o_sexe0( sysreg_wen_vctr_sexe0_to_sexe1 ),
    .t_next_lr_o_sexe0( t_next_lr_sexe0_to_sexe1 ),
    .t_next_uni_opr_o_sexe0( t_next_uni_opr_sexe0_to_sexe1 ),
    .t_next_node_o_sexe0( t_next_node_sexe0_to_sexe1 ),
    .f_next_lr_o_sexe0( f_next_lr_sexe0_to_sexe1 ),
    .f_next_uni_opr_o_sexe0( f_next_uni_opr_sexe0_to_sexe1 ),
    .f_next_node_o_sexe0( f_next_node_sexe0_to_sexe1 ),
    .gen_o_sexe0( gen_sexe0_to_sexe1 ),
    .cp_o_sexe0( cp_sexe0_to_sexe1 ),
    .terminate_o_sexe0( terminate_sexe0_to_sexe1 ),
    .nInterC_S_uC_sExe1_uCX2( nInterC_S_sExe0_uC_sExe1_uCX2 ),
    .nInterC_A_uC_sDec0_uC( nInterC_A_sExe0_uC_sDec0_uC )
  );


  /***********************************************************/
  /*                       sExe1                             */
  /***********************************************************/
  
  sExe1 sExe1(
    .opr0_i_sexe1( opr0_sexe0_to_sexe1 ),
    .opr1_i_sexe1( opr1_sexe0_to_sexe1 ),
    .mem_wen_i_sexe1( mem_wen_sexe0_to_sexe1 ),
    .dopc_i_sexe1( dopc_sexe0_to_sexe1 ),
    .cc_i_sexe1( cc_sexe0_to_sexe1 ),
    .imm16_i_exe1( imm16_sexe0_to_sexe1 ),
    .acc_sel_i_sexe1( acc_sel_sexe0_to_sexe1 ),
    .pe_out_i_sexe1( pe_out_sexe0_to_sexe1 ),
    .pe_num_i_sexe1( pe_num_sexe0_to_sexe1 ),
    .f_mem_w_i_sexe1( f_mem_w_sexe0_to_sexe1 ),
    .dm_dopc_i_sexe1( dm_dopc_sexe0_to_sexe1 ),
    .dm_addr_i_sexe1( dm_addr_sexe0_to_sexe1 ),
    .sysreg_wen_vctr_i_sexe1( sysreg_wen_vctr_sexe0_to_sexe1 ),
    .t_next_lr_i_sexe1( t_next_lr_sexe0_to_sexe1 ),
    .t_next_uni_opr_i_sexe1( t_next_uni_opr_sexe0_to_sexe1 ),
    .t_next_node_i_sexe1( t_next_node_sexe0_to_sexe1 ),
    .f_next_lr_i_sexe1( f_next_lr_sexe0_to_sexe1 ),
    .f_next_uni_opr_i_sexe1( f_next_uni_opr_sexe0_to_sexe1 ),
    .f_next_node_i_sexe1( f_next_node_sexe0_to_sexe1 ),
    .gen_i_sexe1( gen_sexe0_to_sexe1 ),
    .cp_i_sexe1( cp_sexe0_to_sexe1 ),
    .terminate_i_sexe1( terminate_sexe0_to_sexe1 ),
    .nInterC_S_sExe0_uC_uCX2( nInterC_S_sExe0_uC_sExe1_uCX2 ),
    .nInterC_A_sMem0_uC_uCX2( nInterC_A_sMem0_uC_sExe1_uCX2 ),

    .lopen( lopen ),
    .rst( rstn ),


    .opr0_o_sexe1( opr0_sexe1_to_smem0 ),
    .opr1_o_sexe1( opr1_sexe1_to_smem0 ),
    .dm_addr_o_sexe1( dm_addr_sexe1_to_smem0 ),
    .mem_wen_o_sexe1( mem_wen_sexe1_to_smem0 ),
    .dm_dopc_o_sexe1( dm_dopc_sexe1_to_smem0 ),
    .pe_out_o_sexe1( pe_out_sexe1_to_smem0 ),
    .pe_num_o_sexe1( pe_num_sexe1_to_smem0 ),
    .f_mem_w_o_sexe1( f_mem_w_sexe1_to_smem0 ),
    .next_lr_o_sexe1( next_lr_sexe1_to_smem0 ),
    .next_node_o_sexe1( next_node_sexe1_to_smem0 ),
    .gen_o_sexe1( gen_sexe1_to_smem0 ),
    .next_uni_opr_o_sexe1( next_uni_opr_sexe1_to_smem0 ),
    .nInterC_S_uCX2_sMem0_uC( nInterC_S_sExe1_uCX2_sMem0_uC ),
    .nInterC_A_uCX2_sExe0_uC( nInterC_A_sExe1_uCX2_sExe0_uC ),

    .sp_disen_o_sexe1( sp_disen_sexe1 )
  );


  /***********************************************************/
  /*                       sMem0                             */
  /***********************************************************/
  
  sMem0 sMem0(
    .opr0_i_smem0( opr0_sexe1_to_smem0 ),
    .opr1_i_smem0( opr1_sexe1_to_smem0 ),
    .dm_addr_i_smem0( dm_addr_sexe1_to_smem0 ),
    .mem_wen_i_smem0( mem_wen_sexe1_to_smem0 ),
    .dm_dopc_i_smem0( dm_dopc_sexe1_to_smem0 ),
    .pe_out_i_smem0( pe_out_sexe1_to_smem0 ),
    .pe_num_i_smem0( pe_num_sexe1_to_smem0 ),
    .f_mem_w_i_smem0( f_mem_w_sexe1_to_smem0 ),
    .next_lr_i_smem0( next_lr_sexe1_to_smem0 ),
    .next_node_i_smem0( next_node_sexe1_to_smem0 ),
    .gen_i_smem0( gen_sexe1_to_smem0 ),
    .next_uni_opr_i_smem0( next_uni_opr_sexe1_to_smem0 ),
    .nInterC_S_sExe1_uCX2_uC( nInterC_S_sExe1_uCX2_sMem0_uC ),
    .nInterC_A_sMem1_uCEX_uC( nInterC_A_sMem1_uCEX_sMem0_uC ),

    .lopen( lopen ),
    .rst( rstn ),


    .opr0_o_smem0( opr0_smem0_to_smem1 ),
    .opr1_o_smem0( opr1_smem0_to_smem1 ),
    .dm_addr_o_smem0( dm_addr_smem0_to_smem1 ),
    .mem_wen_o_smem0( mem_wen_smem0_to_smem1 ),
    .dm_dopc_o_smem0( dm_dopc_smem0_to_smem1 ),
    .pe_out_o_smem0( pe_out_smem0_to_smem1 ),
    .pe_num_o_smem0( pe_num_smem0_to_smem1 ),
    .f_mem_w_o_smem0( f_mem_w_smem0_to_smem1 ),
    .next_lr_o_smem0( next_lr_smem0_to_smem1 ),
    .next_node_o_smem0( next_node_smem0_to_smem1 ),
    .gen_o_smem0( gen_smem0_to_smem1 ),
    .next_uni_opr_o_smem0( next_uni_opr_smem0_to_smem1 ),
    .w_en_cex_o_smem0( w_en_cex_smem0_to_smem1 ),
    .nInterC_S_uC_sMem1_uCEX( nInterC_S_sMem0_uC_sMem1_uCEX ),
    .nInterC_A_uC_sExe1_uCX2( nInterC_A_sMem0_uC_sExe1_uCX2 )
  );


  /***********************************************************/
  /*                       sMem1                             */
  /***********************************************************/
  
  sMem1 sMem1(
    .opr0_i_smem1( opr0_smem0_to_smem1 ),
    .opr1_i_smem1( opr1_smem0_to_smem1 ),
    .dm_addr_i_smem1( dm_addr_smem0_to_smem1 ),
    .mem_wen_i_smem1( mem_wen_smem0_to_smem1 ),
    .dm_dopc_i_smem1( dm_dopc_smem0_to_smem1 ),
    .pe_out_i_smem1( pe_out_smem0_to_smem1 ),
    .pe_num_i_smem1( pe_num_smem0_to_smem1 ),
    .f_mem_w_i_smem1( f_mem_w_smem0_to_smem1 ),
    .next_lr_i_smem1( next_lr_smem0_to_smem1 ),
    .next_node_i_smem1( next_node_smem0_to_smem1 ),
    .gen_i_smem1( gen_smem0_to_smem1 ),
    .next_uni_opr_i_smem1( next_uni_opr_smem0_to_smem1 ),
    .w_en_cex_i_smem1( w_en_cex_smem0_to_smem1 ),
    .nInterC_S_sMem0_uC_uCEX( nInterC_S_sMem0_uC_sMem1_uCEX ),
    .nInterC_A_sSB_uCB_uCEX( nInterC_A_sSB_uCB_sMem1_uCEX ),

    .lopen( lopen ),
    .rst( rstn ),


    .opr0_o_smem1( opr0_smem1_to_ssb ),
    .dm_data_valid_o_smem1( dm_data_valid_smem1_to_ssb ),
    .dm_data_o_smem1( dm_data_smem1_to_ssb ),
    .pe_out_o_smem1( pe_out_smem1_to_ssb ),
    .pe_num_o_smem1( pe_num_smem1_to_ssb ),
    .f_mem_w_o_smem1( f_mem_w_smem1_to_ssb ),
    .next_lr_o_smem1( next_lr_smem1_to_ssb ),
    .next_node_o_smem1( next_node_smem1_to_ssb ),
    .gen_o_smem1( gen_smem1_to_ssb ),
    .next_uni_opr_o_smem1( next_uni_opr_smem1_to_ssb ),
    .nInterC_S_uCEX_sSB_uCB( nInterC_S_sMem1_uCEX_sSB_uCB ),
    .nInterC_A_uCEX_sMem0_uC( nInterC_A_sMem1_uCEX_sMem0_uC )
  );


  /***********************************************************/
  /*                        sSB                             */
  /***********************************************************/
  
  sSB sSB(
    .opr0_i_ssb( opr0_smem1_to_ssb ),
    .dm_data_valid_i_ssb( dm_data_valid_smem1_to_ssb ),
    .dm_data_i_ssb( dm_data_smem1_to_ssb ),
    .pe_out_i_ssb( pe_out_smem1_to_ssb ),
    .pe_num_i_ssb( pe_num_smem1_to_ssb ),
    .f_mem_w_i_ssb( f_mem_w_smem1_to_ssb ),
    .next_lr_i_ssb( next_lr_smem1_to_ssb ),
    .next_node_i_ssb( next_node_smem1_to_ssb ),
    .gen_i_ssb( gen_smem1_to_ssb ),
    .next_uni_opr_i_ssb( next_uni_opr_smem1_to_ssb ),
    .nInterC_S_sMem1_uCEX_uCB( nInterC_S_sMem1_uCEX_sSB_uCB ),
    .nInterC_A_sSw_uCB_uCB( nInterC_A_sSw_uCB_sSB_uCB ),
    .nInterC_A_sSM_uCM_uCB( nInterC_A_sSM_uCM_sSB_uCB ),

    .sp_disen_i_ssb( sp_disen_sexe1 ),
    
    .lopen( lopen ),
    .rst( rstn ),


    .lr_sw_o_ssb( lr_ssb_to_ssw ),
    .node_sw_o_ssb( node_ssb_to_ssw ),
    .gen_sw_o_ssb( gen_ssb_to_ssw ),
    .opr_sw_o_ssb( opr_ssb_to_ssw ),
    .pe_out_sw_o_ssb( pe_out_ssb_to_ssw ),
    .pe_num_sw_o_ssb( pe_num_ssb_to_ssw ),
    .f_mem_w_sw_o_ssb( f_mem_w_ssb_to_ssw ),
    .uni_opr_sw_o_ssb( uni_opr_ssb_to_ssw ),
    .node_sm_o_ssb( node_ssb_to_ssm ),
    .gen_sm_o_ssb( gen_ssb_to_ssm ),
    .opr_sm_o_ssb( opr_ssb_to_ssm ),
    .mem_wen_sm_o_ssb( mem_wen_ssb_to_ssm ),
    .nInterC_S_uCB_sSw_uCB( nInterC_S_sSB_uCB_sSw_uCB ),
    .nInterC_S_uCB_sSM_uCM( nInterC_S_sSB_uCB_sSM_uCM ),
    .nInterC_A_uCB_sMem1_uCEX( nInterC_A_sSB_uCB_sMem1_uCEX )
  );


  /***********************************************************/
  /*                        sSw                              */
  /***********************************************************/
  
  sSw sSw(
    .lr_i_ssw( lr_ssb_to_ssw ),
    .node_i_ssw( node_ssb_to_ssw ),
    .gen_i_ssw( gen_ssb_to_ssw ),
    .opr_i_ssw( opr_ssb_to_ssw ),
    .pe_out_i_ssw( pe_out_ssb_to_ssw ),
    .pe_num_i_ssw( pe_num_ssb_to_ssw ),
    .f_mem_w_i_ssw( f_mem_w_ssb_to_ssw ),
    .uni_opr_i_ssw( uni_opr_ssb_to_ssw ),
    .nInterC_S_sSB_uCB_uCB( nInterC_S_sSB_uCB_sSw_uCB ),
    .nInterC_A_sICN_uC_uCB( nInterC_A_sICN_uC_sSw_uCB ),
    .nInterC_A_sMer_uCM_uCB( nInterC_A_sMer_uCM_sSw_uCB ),

    .lopen( lopen ),
    .rst( rstn ),


    .pe_num_icn_o_ssw( pe_num_ssw_to_icn ),
    .mem_w_icn_o_ssw( mem_w_ssw_to_icn ),
    .lr_icn_o_ssw( lr_ssw_to_icn ),
    .node_icn_o_ssw( node_out ),
    .gen_icn_o_ssw( gen_ssw_to_icn ),
    .opr_icn_o_ssw( opr_ssw_to_icn ),
    .uni_opr_icn_o_ssw( uni_opr_ssw_to_icn ),
    .lr_mer_o_ssw( lr_ssw_to_smer ),
    .node_mer_o_ssw( node_ssw_to_smer ),
    .gen_mer_o_ssw( gen_ssw_to_smer ),
    .opr_mer_o_ssw( opr_ssw_to_smer ),
    .uni_opr_mer_o_ssw( uni_opr_ssw_to_smer ),
    .nInterC_S_uCB_sICN_uC( nInterC_S_sSw_uCB_sICN_uC ),
    .nInterC_S_uCB_sMer_uCM( nInterC_S_sSw_uCB_sMer_uCM ),
    .nInterC_A_uCB_sSB_uCB( nInterC_A_sSw_uCB_sSB_uCB )
  );


endmodule //CUES
