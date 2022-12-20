module Jump(
	sel_module_i_jmp,
	opr0_i_jmp,
	opr1_i_jmp,
	ins_i_jmp,
	sel_jmp_i_jmp,
	ld_ctrl_i_jmp,


	rslt_cc_o_jmp,
	pe_out_o_jmp,
	pe_num_o_jmp,
	pe_lr_o_jmp,
	f_mem_w_o_jmp,
	jmp_dst_valid_o_jmp,
	jmp_dst_o_jmp,
	gate_o_jmp


  );
  

  //********************************
  input [2:0]	sel_module_i_jmp;
  input [31:0]	opr0_i_jmp;
  input [31:0]	opr1_i_jmp;
  input [17:0]	ins_i_jmp;
  input [2:0]	sel_jmp_i_jmp;
  input 	ld_ctrl_i_jmp;
  
  output [1:0]	rslt_cc_o_jmp;
  output	pe_out_o_jmp;
  output [2:0]	pe_num_o_jmp;
  output 	pe_lr_o_jmp;
  
  output 	f_mem_w_o_jmp;
  
  output 	jmp_dst_valid_o_jmp;
  output [16:0]	jmp_dst_o_jmp;
  output 	gate_o_jmp;

  //********************************

  wire 		jmp_ins_jmp;
  assign 	jmp_ins_jmp = (sel_module_i_jmp == 3'b100)?  1'b1: 1'b0;

  assign 	pe_out_o_jmp = jmp_ins_jmp
  		     & ((sel_jmp_i_jmp[2] & sel_jmp_i_jmp[0]) | ld_ctrl_i_jmp);
  assign 	pe_lr_o_jmp = ld_ctrl_i_jmp? 1'b0: ins_i_jmp[15];
  wire [2:0]	pe_num_tmp_jmp;
  assign 	pe_num_tmp_jmp = sel_jmp_i_jmp[1]? ins_i_jmp[9:7]:
  						   opr1_i_jmp[16:14];
  assign 	pe_num_o_jmp = ld_ctrl_i_jmp? 3'b000: pe_num_tmp_jmp;
  
  assign 	f_mem_w_o_jmp = jmp_ins_jmp & ld_ctrl_i_jmp;

  assign 	jmp_dst_valid_o_jmp =   jmp_ins_jmp
  				      & (   ~sel_jmp_i_jmp[2]
  				          | ~sel_jmp_i_jmp[1]
  				          | ld_ctrl_i_jmp);
  
  wire [16:0]	jmp_dst_tmp_jmp;
  assign 	jmp_dst_tmp_jmp = (sel_jmp_i_jmp[1])?
  			    {ins_i_jmp[17:7],ins_i_jmp[4:0]}:
  			    {{2{1'b0}},opr1_i_jmp[13:0]};
  
  assign 	jmp_dst_o_jmp = (ld_ctrl_i_jmp)?
  			     {{13{1'b0}},sel_jmp_i_jmp}: jmp_dst_tmp_jmp;

  assign 	gate_o_jmp =  jmp_ins_jmp
  			    & ~ld_ctrl_i_jmp
  			    & ~sel_jmp_i_jmp[2] 
  			    & sel_jmp_i_jmp[1] 
  			    & ~sel_jmp_i_jmp[0];
  
  
  wire 		zero_jmp;
  wire 		positive_jmp;
  assign 	zero_jmp = ~|opr1_i_jmp;
  assign 	positive_jmp = ~opr1_i_jmp[31];
  assign 	rslt_cc_o_jmp = {zero_jmp,positive_jmp};//00:n,01:p,10:z,11:-



endmodule //Jump