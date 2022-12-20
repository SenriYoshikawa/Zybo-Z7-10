module Exe0
 (//Input:  name_i_modulename
  //Output: name_o_modulename

  //from Dec0
  node_i_exe0,				//IN
  gen_i_exe0,
  opr0_i_exe0,
  opr1_i_exe0,
  mem_wen_i_exe0,
  dopc_i_exe0,
  ins_i_exe0,
  
  pg_mul_i_exe0,
  pg_sh_i_exe0,
  pg_mul_exe0,
  pg_sh_exe0,

  rst,
  clk,


  //to Exe1
  opr0_o_exe0,				//OUT
  opr1_o_exe0,
  mem_wen_o_exe0,
  dopc_o_exe0,
  cc_o_exe0,
  imm16_o_exe0,
  acc_sel_o_exe0,
  pe_out_o_exe0,
  pe_num_o_exe0,
  f_mem_w_o_exe0,
  dm_dopc_o_exe0,
  dm_addr_o_exe0,
  sysreg_wen_vctr_o_exe0,
  t_next_lr_o_exe0,
  t_next_uni_opr_o_exe0,
  t_next_node_o_exe0,
  f_next_lr_o_exe0,
  f_next_uni_opr_o_exe0,
  f_next_node_o_exe0,
  gen_o_exe0,
  cp_o_exe0,
  pg_mul_o_exe0,
  pg_sh_o_exe0,
  terminate_o_exe0


  );


  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  //from Dec0
  input [15:0]	node_i_exe0;
  input [11:0]	gen_i_exe0;
  input [31:0]	opr0_i_exe0;
  input [31:0]	opr1_i_exe0;
  input 	mem_wen_i_exe0;
  input [9:0] 	dopc_i_exe0;
  input [26:0]	ins_i_exe0;
  
  input 	pg_mul_i_exe0;
  input 	pg_sh_i_exe0;
  input 	pg_mul_exe0;
  input 	pg_sh_exe0;

  input 	rst;
  input 	clk;


   /***********************************************************/
   /*           DEFINITION OF OUTPUT SIGNALS                  */
   /***********************************************************/

  //to Mem0
  output [31:0]	opr0_o_exe0;
  output [31:0]	opr1_o_exe0;
  output 	      mem_wen_o_exe0;
  output [6:0]	dopc_o_exe0;
  output [1:0]	cc_o_exe0;
  output [15:0]	imm16_o_exe0;
  output [3:0]	acc_sel_o_exe0;
  output 	      pe_out_o_exe0;
  output [2:0]	pe_num_o_exe0;
  output 	      f_mem_w_o_exe0;
  output [2:0]	dm_dopc_o_exe0;
  output [13:0]	dm_addr_o_exe0;
  output [7:0]	sysreg_wen_vctr_o_exe0;
  output 	      t_next_lr_o_exe0;
  output 	      t_next_uni_opr_o_exe0;
  output [15:0]	t_next_node_o_exe0;
  output 	      f_next_lr_o_exe0;
  output 	      f_next_uni_opr_o_exe0;
  output [15:0]	f_next_node_o_exe0;
  output [11:0]	gen_o_exe0;
  output	      cp_o_exe0;
  output	      pg_mul_o_exe0;
  output	      pg_sh_o_exe0;
  output 	      terminate_o_exe0;


  /***********************************************************/
  /*                 DEFINITION OF REGISTER                  */
  /***********************************************************/

  //Pipeline Register at Exe0/Mem0
  reg [15:0] 	node_reg_exe0;		
  reg [11:0] 	gen_reg_exe0;
  reg [31:0] 	opr0_reg_exe0;
  reg [31:0] 	opr1_reg_exe0;
  reg 		    mem_wen_reg_exe0;
  reg [9:0] 	dopc_reg_exe0;
  reg [26:0] 	ins_reg_exe0;
  
  reg 		    pg_mul_reg_exe0;
  reg 		    pg_sh_reg_exe0;


  /***********************************************************/
  /*                        OUT                              */ 
  /***********************************************************/
  assign 	opr1_o_exe0 = opr1_reg_exe0;
  assign 	dopc_o_exe0 = dopc_reg_exe0[9:3];
  assign 	cc_o_exe0 = ins_reg_exe0[6:5];
  assign 	imm16_o_exe0 = ins_reg_exe0[4:0];
  assign 	acc_sel_o_exe0 = dopc_reg_exe0[2]? opr1_reg_exe0[3:0]:
  						   ins_reg_exe0[3:0];
  assign 	mem_wen_o_exe0 = mem_wen_reg_exe0;
  
  assign 	pg_mul_o_exe0 = pg_mul_reg_exe0;
  assign 	pg_sh_o_exe0 = pg_sh_reg_exe0;


  /***********************************************************/
  /*              PipeLine Register (Dec/Exe)                */
  /***********************************************************/
  
  always @(posedge clk  or  negedge rst) begin
    if (rst == 1'b0) begin
      node_reg_exe0	<= {16{1'b0}};
      gen_reg_exe0	<= {12{1'b0}};
      opr0_reg_exe0	<= {32{1'b0}};
      opr1_reg_exe0	<= {32{1'b0}};
      mem_wen_reg_exe0	<= 1'b0;
      dopc_reg_exe0	<= {10{1'b0}};
      ins_reg_exe0	<= {27{1'b0}};
      pg_mul_reg_exe0	<= 1'b0;
      pg_sh_reg_exe0	<= 1'b0;
    end else begin
      node_reg_exe0	<= node_i_exe0;
      gen_reg_exe0	<= gen_i_exe0;
      opr0_reg_exe0	<= opr0_i_exe0;
      opr1_reg_exe0	<= opr1_i_exe0;
      mem_wen_reg_exe0	<= mem_wen_i_exe0;
      dopc_reg_exe0	<= dopc_i_exe0;
      ins_reg_exe0	<= ins_i_exe0;
      pg_mul_reg_exe0	<= pg_mul_i_exe0;
      pg_sh_reg_exe0	<= pg_sh_i_exe0;
    end
  end


  /***********************************************************/
  /*                      INCLUDE Int                        */
  /***********************************************************/
   
  Int0 Int0(
  	  .node_i_int0( node_reg_exe0 ),
  	  .gen_i_int0( gen_reg_exe0 ),
  	  .opr0_i_int0( opr0_reg_exe0 ),
  	  .opr1_i_int0( opr1_reg_exe0 ),
  	  .mem_wen_i_int0( mem_wen_reg_exe0 ),
  	  .dopc_i_int0( dopc_reg_exe0 ),
  	  .ins_i_int0( ins_reg_exe0 ),
  	  .pg_mul_int0( pg_mul_exe0 ),
  	  .pg_sh_int0( pg_sh_exe0 ),
	  
  	  .opr0_o_int0( opr0_o_exe0 ),
  	  .pe_out_o_int0( pe_out_o_exe0 ),
  	  .pe_num_o_int0( pe_num_o_exe0 ),
  	  .f_mem_w_o_int0( f_mem_w_o_exe0 ),
  	  .dm_dopc_o_int0( dm_dopc_o_exe0 ),
  	  .dm_addr_o_int0( dm_addr_o_exe0 ),
  	  .sysreg_wen_vctr_o_int0( sysreg_wen_vctr_o_exe0 ),
  	  .t_next_lr_o_int0( t_next_lr_o_exe0 ),
  	  .t_next_uni_opr_o_int0( t_next_uni_opr_o_exe0 ),
  	  .t_next_node_o_int0( t_next_node_o_exe0 ),
  	  .f_next_lr_o_int0( f_next_lr_o_exe0 ),
  	  .f_next_uni_opr_o_int0( f_next_uni_opr_o_exe0 ),
  	  .f_next_node_o_int0( f_next_node_o_exe0 ),
  	  .gen_o_int0( gen_o_exe0 ),
  	  .cp_o_int0( cp_o_exe0 ),
  	  .terminate_o_int0( terminate_o_exe0 )
	  );


endmodule //Exe0
