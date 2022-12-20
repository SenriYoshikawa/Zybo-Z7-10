`timescale 1ps/1ps
module Int1( 
  opr0_i_int1,				//IN
  sel_module_i_int1,
  sel1_i_int1,
  sel2_i_int1,
  sel3_i_int1,
  cc_i_int1,
  imm5_i_int1,
  acc_sel_i_int1,
  t_next_lr_i_int1,
  t_next_uni_opr_i_int1,
  t_next_node_i_int1,
  f_next_lr_i_int1,
  f_next_uni_opr_i_int1,
  f_next_node_i_int1,
  cppkt_i_int1,
  fst_clk_i_int1,

  acc00_i_int1,
  acc01_i_int1,
  acc02_i_int1,
  acc03_i_int1,
  acc04_i_int1,
  acc05_i_int1,
  acc06_i_int1,
  acc07_i_int1,
  acc08_i_int1,
  acc09_i_int1,
  acc10_i_int1,
  acc11_i_int1,
  acc12_i_int1,
  acc13_i_int1,
  acc14_i_int1,
  acc15_i_int1,
  sysreg00_i_int1,
  sysreg01_i_int1,
  sysreg02_i_int1,
  sysreg03_i_int1,
  sysreg04_i_int1,
  sysreg05_i_int1,
  sysreg06_i_int1,
  sysreg07_i_int1,


  rslt_o_int1,				//OUT
  
  acc_wen_vctr_o_int1,
  acc_wdata_o_int1,
  
  next_lr_o_int1,
  next_uni_opr_o_int1,
  next_node_o_int1

  );

  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  //from Dec(Exe)
  input [31:0]	opr0_i_int1;
  input [2:0]	sel_module_i_int1;
  input 	sel1_i_int1;
  input [1:0]	sel2_i_int1;
  input 	sel3_i_int1;
  input [1:0]	cc_i_int1;
  input [4:0]	imm5_i_int1;
  input [3:0]	acc_sel_i_int1;
  input 	t_next_lr_i_int1;
  input 	t_next_uni_opr_i_int1;
  input [15:0]	t_next_node_i_int1;
  input 	f_next_lr_i_int1;
  input 	f_next_uni_opr_i_int1;
  input [15:0]	f_next_node_i_int1;
  input 	cppkt_i_int1;
  input 	fst_clk_i_int1;

  input [31:0]	acc00_i_int1;
  input [31:0]	acc01_i_int1;
  input [31:0]	acc02_i_int1;
  input [31:0]	acc03_i_int1;
  input [31:0]	acc04_i_int1;
  input [31:0]	acc05_i_int1;
  input [31:0]	acc06_i_int1;
  input [31:0]	acc07_i_int1;
  input [31:0]	acc08_i_int1;
  input [31:0]	acc09_i_int1;
  input [31:0]	acc10_i_int1;
  input [31:0]	acc11_i_int1;
  input [31:0]	acc12_i_int1;
  input [31:0]	acc13_i_int1;
  input [31:0]	acc14_i_int1;
  input [31:0]	acc15_i_int1;
  input [31:0]	sysreg00_i_int1;
  input [31:0]	sysreg01_i_int1;
  input [31:0]	sysreg02_i_int1;
  input [31:0]	sysreg03_i_int1;
  input [31:0]	sysreg04_i_int1;
  input [31:0]	sysreg05_i_int1;
  input [31:0]	sysreg06_i_int1;
  input [31:0]	sysreg07_i_int1;


  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  //to Mem0(Exe)
  output [31:0]	rslt_o_int1;

  output [4:0]	acc_wen_vctr_o_int1;
  output [31:0]	acc_wdata_o_int1;
  
  output 	next_lr_o_int1;
  output 	next_uni_opr_o_int1;
  output [15:0]	next_node_o_int1;

  /***********************************************************/
  /*                 DEFINITION OF WIRE                      */
  /***********************************************************/

  wire [31:0]	rslt_as_int1;
  wire [1:0]	rslt_cc_as_int1;
  wire [1:0]	rslt_cc_int1;


  /***********************************************************/
  /*                    INCLUDE AccSysreg                    */
  /***********************************************************/
  
  AccSysreg1 AccSysreg1(
  		.opr0_i_as1( opr0_i_int1 ), 
  		.imm5_i_as1( imm5_i_int1 ),
  		.acc_sel_i_as1( acc_sel_i_int1 ),
  		.sel_module_i_as1( sel_module_i_int1 ),
  		.sel1_i_as1( sel1_i_int1 ),
  		.sel2_i_as1( sel2_i_int1 ),
  		.sel3_i_as1( sel3_i_int1 ),
  		.fst_clk_i_as1( fst_clk_i_int1 ),
  
  		.acc00_i_as1( acc00_i_int1 ),
  		.acc01_i_as1( acc01_i_int1 ),
  		.acc02_i_as1( acc02_i_int1 ),
  		.acc03_i_as1( acc03_i_int1 ),
      .acc04_i_as1( acc04_i_int1 ),
      .acc05_i_as1( acc05_i_int1 ),
      .acc06_i_as1( acc06_i_int1 ),
      .acc07_i_as1( acc07_i_int1 ),
      .acc08_i_as1( acc08_i_int1 ),
      .acc09_i_as1( acc09_i_int1 ),
      .acc10_i_as1( acc10_i_int1 ),
      .acc11_i_as1( acc11_i_int1 ),
      .acc12_i_as1( acc12_i_int1 ),
      .acc13_i_as1( acc13_i_int1 ),
      .acc14_i_as1( acc14_i_int1 ),
      .acc15_i_as1( acc15_i_int1 ),
  		.sysreg00_i_as1( sysreg00_i_int1 ),
  		.sysreg01_i_as1( sysreg01_i_int1 ),
  		.sysreg02_i_as1( sysreg02_i_int1 ),
  		.sysreg03_i_as1( sysreg03_i_int1 ),
  		.sysreg04_i_as1( sysreg04_i_int1 ),
  		.sysreg05_i_as1( sysreg05_i_int1 ),
  		.sysreg06_i_as1( sysreg06_i_int1 ),
  		.sysreg07_i_as1( sysreg07_i_int1 ),
      
  		.rslt_o_as1( rslt_as_int1 ),
  		.rslt_cc_o_as1( rslt_cc_as_int1 ),
  
  		.acc_wen_vctr_o_as1( acc_wen_vctr_o_int1 ),
  		.acc_wdata_o_as1( acc_wdata_o_int1 )
   	);


  /*  alu include end  ****************************************/

  wire 		as_ins_int1;
  assign 	as_ins_int1 = (sel_module_i_int1 == 3'b101)? 1'b1: 1'b0;

  assign 	rslt_o_int1 = as_ins_int1? rslt_as_int1: opr0_i_int1;
  
  wire 		tf_int1;
  assign 	tf_int1 = branch_tf_int1(cc_i_int1, rslt_cc_as_int1);
  
  function branch_tf_int1;
    input [1:0] cc;
    input [1:0] rslt_cc;
    case(cc)
      2'b00: branch_tf_int1 = 1'b1;
      2'b01: branch_tf_int1 = ~rslt_cc[0];
      2'b10: branch_tf_int1 = ~rslt_cc[1];
      2'b11: branch_tf_int1 = 1'b1;
    endcase // case(imm5)
  endfunction // sysreg_sel

  assign 	next_lr_o_int1 = ((~tf_int1 & (as_ins_int1 & ~sel1_i_int1
  				  & ~(sel2_i_int1[1] & ~sel2_i_int1[0])))
  				  | cppkt_i_int1)?
  					f_next_lr_i_int1: t_next_lr_i_int1;
  assign 	next_uni_opr_o_int1 = ((~tf_int1 & (as_ins_int1 & ~sel1_i_int1)) | cppkt_i_int1)?
  					 f_next_uni_opr_i_int1: t_next_uni_opr_i_int1;
  assign 	next_node_o_int1 = ((~tf_int1 & (as_ins_int1 & ~sel1_i_int1)) | cppkt_i_int1)?
  					f_next_node_i_int1: t_next_node_i_int1;


endmodule // AccSysInt
