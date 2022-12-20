`timescale 1ps/1ps
module Exe1
 (//Input:  name_i_modulename
  //Output: name_o_modulename

  //from Exe0
  opr0_i_exe1,				//IN
  opr1_i_exe1,
  mem_wen_i_exe1,
  dopc_i_exe1,
  cc_i_exe1,
  imm16_i_exe1,
  acc_sel_i_exe1,
  pe_out_i_exe1,
  pe_num_i_exe1,
  f_mem_w_i_exe1,
  dm_dopc_i_exe1,
  dm_addr_i_exe1,
  sysreg_wen_vctr_i_exe1,
  t_next_lr_i_exe1,
  t_next_uni_opr_i_exe1,
  t_next_node_i_exe1,
  f_next_lr_i_exe1,
  f_next_uni_opr_i_exe1,
  f_next_node_i_exe1,
  gen_i_exe1,

  rst,
  clk,
  cppkt,


  //to Mem0
  opr0_o_exe1,				//OUT
  opr1_o_exe1,
  dm_addr_o_exe1,
  mem_wen_o_exe1,
  dm_dopc_o_exe1,
  pe_out_o_exe1,
  pe_num_o_exe1,
  f_mem_w_o_exe1,
  next_lr_o_exe1,
  next_node_o_exe1,
  gen_o_exe1,
  next_uni_opr_o_exe1,
  pgen_o_exe1,
  vdd_o_exe1,
  pid_o_exe1,
  probe0_o_exe1,
  probe1_o_exe1,
  probe2_o_exe1,
  probe3_o_exe1,
  sp_disen_o_exe1,
  mm16_o_exe1,
  );


  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  //from Exe0  
  input [31:0]	opr0_i_exe1;				//IN
  input [31:0]	opr1_i_exe1;
  input 	mem_wen_i_exe1;
  input [6:0]	dopc_i_exe1;
  input [1:0]	cc_i_exe1;
  input [15:0]	imm16_i_exe1;
  input [3:0]	acc_sel_i_exe1;
  input 	pe_out_i_exe1;
  input [2:0]	pe_num_i_exe1;
  input 	f_mem_w_i_exe1;
  input [2:0]	dm_dopc_i_exe1;
  input [13:0]	dm_addr_i_exe1;
  input [7:0] 	sysreg_wen_vctr_i_exe1;
  input 	t_next_lr_i_exe1;
  input 	t_next_uni_opr_i_exe1;
  input [15:0]	t_next_node_i_exe1;
  input 	f_next_lr_i_exe1;
  input 	f_next_uni_opr_i_exe1;
  input [15:0]	f_next_node_i_exe1;
  input [11:0]	gen_i_exe1;
  
  input 	rst;
  input 	clk;
  input 	cppkt;


  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  //to Mem0
  output [31:0]	opr0_o_exe1;
  output [31:0]	opr1_o_exe1;
  output [13:0]	dm_addr_o_exe1;
  output 	mem_wen_o_exe1;
  output [2:0] 	dm_dopc_o_exe1;
  output 	pe_out_o_exe1;
  output [2:0]	pe_num_o_exe1;
  output 	f_mem_w_o_exe1;
  output 	next_lr_o_exe1;
  output [15:0]	next_node_o_exe1;
  output [11:0]	gen_o_exe1;
  output 	next_uni_opr_o_exe1;
  output 	pgen_o_exe1;
  output [3:0]	vdd_o_exe1;
  output 	pid_o_exe1;
  output 	probe0_o_exe1;
  output 	probe1_o_exe1;
  output 	probe2_o_exe1;
  output 	probe3_o_exe1;
  output 	sp_disen_o_exe1;
  output 	mm16_o_exe1;


  /***********************************************************/
  /*                 DEFINITION OF REGISTER                  */
  /***********************************************************/

  //Pipeline Register at Exe1/Mem0
  reg [31:0]	opr0_reg_exe1;
  reg [31:0]	opr1_reg_exe1;
  reg 		mem_wen_reg_exe1;
  reg [6:0]	dopc_reg_exe1;
  reg [1:0]	cc_reg_exe1;
  reg [15:0]	imm16_reg_exe1;
  reg [3:0]	acc_sel_reg_exe1;
  reg 		pe_out_reg_exe1;
  reg [2:0]	pe_num_reg_exe1;
  reg 		f_mem_w_reg_exe1;
  reg [2:0]	dm_dopc_reg_exe1;
  reg [13:0]	dm_addr_reg_exe1;
  reg 		t_next_lr_reg_exe1;
  reg 		t_next_uni_opr_reg_exe1;
  reg [15:0]	t_next_node_reg_exe1;
  reg 		f_next_lr_reg_exe1;
  reg 		f_next_uni_opr_reg_exe1;
  reg [15:0]	f_next_node_reg_exe1;
  reg [11:0]	gen_reg_exe1;
  reg 		fst_clk_reg_exe1;
  
  //Accumulator, System Register
  reg [31:0]   acc00_reg_exe1;
  reg [31:0]   acc01_reg_exe1;
  reg [31:0]   acc02_reg_exe1;
  reg [31:0]   acc03_reg_exe1;
  reg [31:0]   acc04_reg_exe1;
  reg [31:0]   acc05_reg_exe1;
  reg [31:0]   acc06_reg_exe1;
  reg [31:0]   acc07_reg_exe1;
  reg [31:0]   acc08_reg_exe1;
  reg [31:0]   acc09_reg_exe1;
  reg [31:0]   acc10_reg_exe1;
  reg [31:0]   acc11_reg_exe1;
  reg [31:0]   acc12_reg_exe1;
  reg [31:0]   acc13_reg_exe1;
  reg [31:0]   acc14_reg_exe1;
  reg [31:0]   acc15_reg_exe1;
  reg [31:0] 	sysreg00_reg_exe1;
  reg [31:0] 	sysreg01_reg_exe1;
  reg [31:0] 	sysreg02_reg_exe1;
  reg [31:0] 	sysreg03_reg_exe1;
  reg [31:0] 	sysreg04_reg_exe1;
  reg [31:0] 	sysreg05_reg_exe1;
  reg [31:0] 	sysreg06_reg_exe1;
  reg [31:0] 	sysreg07_reg_exe1;


  /***********************************************************/
  /*                 DEFINITION OF WIRE                      */
  /***********************************************************/

  wire [4:0] 	acc_wen_vctr_exe1;
  wire [31:0] acc_wdata_exe1;

  
  /***********************************************************/
  /*                        OUT                              */ 
  /***********************************************************/

  assign 	opr1_o_exe1 = opr1_reg_exe1;
  assign 	mem_wen_o_exe1 = mem_wen_reg_exe1;
  assign 	pe_out_o_exe1 = pe_out_reg_exe1;
  assign 	pe_num_o_exe1 = pe_num_reg_exe1;
  assign 	f_mem_w_o_exe1 = f_mem_w_reg_exe1;
  assign 	dm_dopc_o_exe1 = dm_dopc_reg_exe1;
  assign 	dm_addr_o_exe1 = dm_addr_reg_exe1;
  assign 	gen_o_exe1 = gen_reg_exe1;
  
  assign 	vdd_o_exe1 = sysreg00_reg_exe1[3:0];
  assign 	pid_o_exe1 = sysreg00_reg_exe1[4];
  assign 	pgen_o_exe1 = sysreg00_reg_exe1[5];
  assign 	probe0_o_exe1 = sysreg01_reg_exe1[0];
  assign 	probe1_o_exe1 = sysreg01_reg_exe1[1];
  assign 	probe2_o_exe1 = sysreg01_reg_exe1[2];
  assign 	probe3_o_exe1 = sysreg01_reg_exe1[3];
  assign 	sp_disen_o_exe1 = sysreg02_reg_exe1[0];
  assign 	mm16_o_exe1 = sysreg03_reg_exe1[0];


  /***********************************************************/
  /*              PipeLine Register (Dec/Exe)                */
  /***********************************************************/

  always @(posedge clk  or  negedge rst) begin
    if (rst == 1'b0) begin
      opr0_reg_exe1		<= {32{1'b0}};
      opr1_reg_exe1		<= {32{1'b0}};
      mem_wen_reg_exe1		<= 1'b0;
      dopc_reg_exe1		<= {7{1'b0}};
      cc_reg_exe1		<= {2{1'b0}};
      imm16_reg_exe1		<= {16{1'b0}};
      acc_sel_reg_exe1		<= {4{1'b0}};
      pe_out_reg_exe1		<= 1'b0;
      pe_num_reg_exe1		<= {3{1'b0}};
      f_mem_w_reg_exe1		<= 1'b0;
      dm_dopc_reg_exe1		<= {3{1'b0}};
      dm_addr_reg_exe1		<= {13{1'b0}};
      t_next_lr_reg_exe1	<= 1'b0;
      t_next_uni_opr_reg_exe1	<= 1'b0;
      t_next_node_reg_exe1	<= {16{1'b0}};
      f_next_lr_reg_exe1	<= 1'b0;
      f_next_uni_opr_reg_exe1	<= 1'b0;
      f_next_node_reg_exe1	<= {16{1'b0}};
      gen_reg_exe1		<= {12{1'b0}};
      
      fst_clk_reg_exe1		<= 1'b0;
      
      acc00_reg_exe1    <= 32'h00000000;
      acc01_reg_exe1    <= 32'h00000000;
      acc02_reg_exe1    <= 32'h00000000;
      acc03_reg_exe1    <= 32'h00000000;
      acc04_reg_exe1    <= 32'h00000000;
      acc05_reg_exe1    <= 32'h00000000;
      acc06_reg_exe1    <= 32'h00000000;
      acc07_reg_exe1    <= 32'h00000000;
      acc08_reg_exe1    <= 32'h00000000;
      acc09_reg_exe1    <= 32'h00000000;
      acc10_reg_exe1    <= 32'h00000000;
      acc11_reg_exe1    <= 32'h00000000;
      acc12_reg_exe1    <= 32'h00000000;
      acc13_reg_exe1    <= 32'h00000000;
      acc14_reg_exe1    <= 32'h00000000;
      acc15_reg_exe1    <= 32'h00000000;
      
      sysreg00_reg_exe1 	<= {32{1'b0}};
      sysreg01_reg_exe1 	<= {32{1'b0}};
      sysreg02_reg_exe1 	<= {32{1'b0}};
      sysreg03_reg_exe1 	<= {32{1'b0}};
      sysreg04_reg_exe1 	<= {32{1'b0}};
      sysreg05_reg_exe1 	<= {32{1'b0}};
      sysreg06_reg_exe1 	<= {32{1'b0}};
      sysreg07_reg_exe1 	<= {32{1'b0}};
      
    end else begin      
      opr0_reg_exe1		<= opr0_i_exe1;
      opr1_reg_exe1		<= opr1_i_exe1;
      mem_wen_reg_exe1		<= mem_wen_i_exe1;
      dopc_reg_exe1		<= dopc_i_exe1;
      cc_reg_exe1		<= cc_i_exe1;
      imm16_reg_exe1		<= imm16_i_exe1;
      acc_sel_reg_exe1		<= acc_sel_i_exe1;
      pe_out_reg_exe1		<= pe_out_i_exe1;
      pe_num_reg_exe1		<= pe_num_i_exe1;
      f_mem_w_reg_exe1		<= f_mem_w_i_exe1;
      dm_dopc_reg_exe1		<= dm_dopc_i_exe1;
      dm_addr_reg_exe1		<= dm_addr_i_exe1;
      t_next_lr_reg_exe1	<= t_next_lr_i_exe1;
      t_next_uni_opr_reg_exe1	<= t_next_uni_opr_i_exe1;
      t_next_node_reg_exe1	<= t_next_node_i_exe1;
      f_next_lr_reg_exe1	<= f_next_lr_i_exe1;
      f_next_uni_opr_reg_exe1	<= f_next_uni_opr_i_exe1;
      f_next_node_reg_exe1	<= f_next_node_i_exe1;
      gen_reg_exe1		<= gen_i_exe1;

      fst_clk_reg_exe1		<= 1'b1;
      
      case(acc_wen_vctr_exe1) 
        5'h10:acc00_reg_exe1 <= acc_wdata_exe1;
        5'h11:acc01_reg_exe1 <= acc_wdata_exe1;
        5'h12:acc02_reg_exe1 <= acc_wdata_exe1;
        5'h13:acc03_reg_exe1 <= acc_wdata_exe1;
        5'h14:acc04_reg_exe1 <= acc_wdata_exe1;
        5'h15:acc05_reg_exe1 <= acc_wdata_exe1;
        5'h16:acc06_reg_exe1 <= acc_wdata_exe1;
        5'h17:acc07_reg_exe1 <= acc_wdata_exe1;
        5'h18:acc08_reg_exe1 <= acc_wdata_exe1;
        5'h19:acc09_reg_exe1 <= acc_wdata_exe1;
        5'h1a:acc10_reg_exe1 <= acc_wdata_exe1;
        5'h1b:acc11_reg_exe1 <= acc_wdata_exe1;
        5'h1c:acc12_reg_exe1 <= acc_wdata_exe1;
        5'h1d:acc13_reg_exe1 <= acc_wdata_exe1;
        5'h1e:acc14_reg_exe1 <= acc_wdata_exe1;
        5'h1f:acc15_reg_exe1 <= acc_wdata_exe1;
      endcase
      
      if (sysreg_wen_vctr_i_exe1[0]) begin
        sysreg00_reg_exe1 <= opr0_i_exe1;
      end
      if (sysreg_wen_vctr_i_exe1[1]) begin
        sysreg01_reg_exe1 <= opr0_i_exe1;
      end
      if (sysreg_wen_vctr_i_exe1[2]) begin
        sysreg02_reg_exe1 <= opr0_i_exe1;
      end
      if (sysreg_wen_vctr_i_exe1[3]) begin
        sysreg03_reg_exe1 <= opr0_i_exe1;
      end
      if (sysreg_wen_vctr_i_exe1[4]) begin
        sysreg04_reg_exe1 <= opr0_i_exe1;
      end
      if (sysreg_wen_vctr_i_exe1[5]) begin
        sysreg05_reg_exe1 <= opr0_i_exe1;
      end
      if (sysreg_wen_vctr_i_exe1[6]) begin
        sysreg06_reg_exe1 <= opr0_i_exe1;
      end
      if (sysreg_wen_vctr_i_exe1[7]) begin
        sysreg07_reg_exe1 <= opr0_i_exe1;
      end
    end
  end


  /***********************************************************/
  /*                      INCLUDE Int                        */
  /***********************************************************/
   
  Int1 Int1(
  		.opr0_i_int1( opr0_reg_exe1 ),
  		.sel_module_i_int1( dopc_reg_exe1[6:4] ),
  		.sel1_i_int1( dopc_reg_exe1[3] ),
  		.sel2_i_int1( dopc_reg_exe1[2:1] ),
  		.sel3_i_int1( dopc_reg_exe1[0] ),
  		.cc_i_int1( cc_reg_exe1 ),
  		.imm5_i_int1( imm16_reg_exe1[4:0] ),
  		.acc_sel_i_int1( acc_sel_reg_exe1 ),
  		.t_next_lr_i_int1( t_next_lr_reg_exe1 ),
  		.t_next_uni_opr_i_int1( t_next_uni_opr_reg_exe1 ),
  		.t_next_node_i_int1( t_next_node_reg_exe1 ),
  		.f_next_lr_i_int1( f_next_lr_reg_exe1 ),
  		.f_next_uni_opr_i_int1( f_next_uni_opr_reg_exe1 ),
  		.f_next_node_i_int1( f_next_node_reg_exe1 ),
  		.cppkt_i_int1( cppkt ),
  		.fst_clk_i_int1( fst_clk_reg_exe1 ),
      .acc00_i_int1( acc00_reg_exe1 ),
      .acc01_i_int1( acc01_reg_exe1 ),
      .acc02_i_int1( acc02_reg_exe1 ),
      .acc03_i_int1( acc03_reg_exe1 ),
      .acc04_i_int1( acc04_reg_exe1 ),
      .acc05_i_int1( acc05_reg_exe1 ),
      .acc06_i_int1( acc06_reg_exe1 ),
      .acc07_i_int1( acc07_reg_exe1 ),
      .acc08_i_int1( acc08_reg_exe1 ),
      .acc09_i_int1( acc09_reg_exe1 ),
      .acc10_i_int1( acc10_reg_exe1 ),
      .acc11_i_int1( acc11_reg_exe1 ),
      .acc12_i_int1( acc12_reg_exe1 ),
      .acc13_i_int1( acc13_reg_exe1 ),
      .acc14_i_int1( acc14_reg_exe1 ),
      .acc15_i_int1( acc15_reg_exe1 ),
  		.sysreg00_i_int1( sysreg00_reg_exe1 ),
  		.sysreg01_i_int1( sysreg01_reg_exe1 ),
  		.sysreg02_i_int1( sysreg02_reg_exe1 ),
  		.sysreg03_i_int1( sysreg03_reg_exe1 ),
  		.sysreg04_i_int1( sysreg04_reg_exe1 ),
  		.sysreg05_i_int1( sysreg05_reg_exe1 ),
  		.sysreg06_i_int1( sysreg06_reg_exe1 ),
  		.sysreg07_i_int1( sysreg07_reg_exe1 ),


  		.rslt_o_int1( opr0_o_exe1 ),
  		.acc_wen_vctr_o_int1( acc_wen_vctr_exe1 ),
  		.acc_wdata_o_int1( acc_wdata_exe1 ),
  		
  		.next_lr_o_int1( next_lr_o_exe1 ),
  		.next_uni_opr_o_int1( next_uni_opr_o_exe1 ),
  		.next_node_o_int1( next_node_o_exe1 )


		);


endmodule //Exe1
