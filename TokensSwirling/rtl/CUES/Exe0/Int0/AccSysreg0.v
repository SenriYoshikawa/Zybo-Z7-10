module AccSysreg0(
	gen_i_as0,
	mem_wen_i_as0,
	imm16_i_as0,
	sel_module_i_as0,
	sel1_i_as0,
	sel2_i_as0,

	sysreg_wen_vctr_o_as0,
	sysreg_w_terminate_o_as0

	);
  
  
  //********************************
  input [3:0]	gen_i_as0;
  input 	mem_wen_i_as0;
  input [2:0]	imm16_i_as0;
  input [2:0]	sel_module_i_as0;
  input 	sel1_i_as0;
  input 	sel2_i_as0;
  
  output [7:0]	sysreg_wen_vctr_o_as0;
  output 	sysreg_w_terminate_o_as0;

  //********************************

  wire 		ctrl_pkt_w_as0;
  assign 	ctrl_pkt_w_as0 = (mem_wen_i_as0 & gen_i_as0[3])? 1'b1: 1'b0;

  wire 		sysreg_ins_as0;
  assign 	sysreg_ins_as0 = (sel_module_i_as0 == 3'b101)? 1'b1: 1'b0;
  
  wire 		sysreg_wen_as0;
  assign 	sysreg_wen_as0 =   ctrl_pkt_w_as0
  				 | (sysreg_ins_as0 & sel1_i_as0 & sel2_i_as0);

  wire [2:0] 	sysreg_num_as0;
  assign 	sysreg_num_as0 = ctrl_pkt_w_as0? gen_i_as0[2:0]: imm16_i_as0;

  assign 	sysreg_wen_vctr_o_as0 = sysreg_wen_vctr_gen( sysreg_wen_as0,
  							     sysreg_num_as0);
  function [7:0] sysreg_wen_vctr_gen;
    input 	 sysreg_wen;
    input [2:0]  sysreg_num;
    case(sysreg_num)//sysnopsys parallel_case
      3'b000: sysreg_wen_vctr_gen = {{7{1'b0}},sysreg_wen};
      3'b001: sysreg_wen_vctr_gen = {{6{1'b0}},sysreg_wen,{1{1'b0}}};
      3'b010: sysreg_wen_vctr_gen = {{5{1'b0}},sysreg_wen,{2{1'b0}}};
      3'b011: sysreg_wen_vctr_gen = {{4{1'b0}},sysreg_wen,{3{1'b0}}};
      3'b100: sysreg_wen_vctr_gen = {{3{1'b0}},sysreg_wen,{4{1'b0}}};
      3'b101: sysreg_wen_vctr_gen = {{2{1'b0}},sysreg_wen,{5{1'b0}}};
      3'b110: sysreg_wen_vctr_gen = {{1{1'b0}},sysreg_wen,{6{1'b0}}};
      3'b111: sysreg_wen_vctr_gen = {sysreg_wen,{7{1'b0}}};
      default: sysreg_wen_vctr_gen = 8'bxxxxxxxx;
    endcase // case(sysreg_num)
  endfunction // gen_selector

  assign 	sysreg_w_terminate_o_as0 = ctrl_pkt_w_as0;

   
endmodule //AccSysreg0
