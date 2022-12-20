`timescale 1ps/1ps
module AccSysreg1(
  opr0_i_as1, 
  imm5_i_as1,
  acc_sel_i_as1,
  sel_module_i_as1,
  sel1_i_as1,
  sel2_i_as1,
  sel3_i_as1,
  fst_clk_i_as1,
  
  acc00_i_as1,
  acc01_i_as1,
  acc02_i_as1,
  acc03_i_as1,
  acc04_i_as1,
  acc05_i_as1,
  acc06_i_as1,
  acc07_i_as1,
  acc08_i_as1,
  acc09_i_as1,
  acc10_i_as1,
  acc11_i_as1,
  acc12_i_as1,
  acc13_i_as1,
  acc14_i_as1,
  acc15_i_as1,
  sysreg00_i_as1,
  sysreg01_i_as1,
  sysreg02_i_as1,
  sysreg03_i_as1,
  sysreg04_i_as1,
  sysreg05_i_as1,
  sysreg06_i_as1,
  sysreg07_i_as1,


  rslt_o_as1,
  rslt_cc_o_as1,

  acc_wen_vctr_o_as1,
  acc_wdata_o_as1


  );
  
  
  //********************************
  input [31:0]	opr0_i_as1;
  input [4:0]	imm5_i_as1;
  input [3:0]	acc_sel_i_as1;
  input [2:0]	sel_module_i_as1;
  input 	sel1_i_as1; // 0:acc/1:sysreg
  input [1:0] 	sel2_i_as1; // acc	00:add/01:sub/10:set/11:cmp
  		            // sysreg	0x:read/1x:write
  input 	sel3_i_as1; // 0:imm/1:oprL
  input 	fst_clk_i_as1;
  
  input [31:0]	acc00_i_as1;
  input [31:0]	acc01_i_as1;
  input [31:0]	acc02_i_as1;
  input [31:0]	acc03_i_as1;
  input [31:0]	acc04_i_as1;
  input [31:0]	acc05_i_as1;
  input [31:0]	acc06_i_as1;
  input [31:0]	acc07_i_as1;
  input [31:0]	acc08_i_as1;
  input [31:0]	acc09_i_as1;
  input [31:0]	acc10_i_as1;
  input [31:0]	acc11_i_as1;
  input [31:0]	acc12_i_as1;
  input [31:0]	acc13_i_as1;
  input [31:0]	acc14_i_as1;
  input [31:0]	acc15_i_as1; 
  input [31:0]	sysreg00_i_as1;
  input [31:0]	sysreg01_i_as1;
  input [31:0]	sysreg02_i_as1;
  input [31:0]	sysreg03_i_as1;
  input [31:0]	sysreg04_i_as1;
  input [31:0]	sysreg05_i_as1;
  input [31:0]	sysreg06_i_as1;
  input [31:0]	sysreg07_i_as1;
  
  
  output [31:0]	rslt_o_as1;
  output [1:0] 	rslt_cc_o_as1;
  
  output [4:0] 	acc_wen_vctr_o_as1;
  output [31:0]	acc_wdata_o_as1;
  //********************************

  wire 		acc_ins_as1;
  wire [31:0]	imm_as1;
  wire [31:0] 	selected_acc_as1;
  wire [31:0] 	selected_oprb_tmp_as1;
  wire [31:0] 	selected_oprb_as1;
  wire [32:0] 	acc_tmp_as1;
  wire [32:0] 	acc_rslt_tmp_as1;
  
  wire [31:0] 	selected_sysreg_as1;
  wire [31:0] 	sysreg_rslt_tmp_as1;
  wire 		zero_as1;
  wire 		overflow_as1;
  
    
  //acc************************************************************************
  
  assign acc_ins_as1 = ((sel_module_i_as1 == 3'b101) & ~sel1_i_as1)? 1'b1: 1'b0;
  
  assign selected_acc_as1 = acc_selector( acc00_i_as1,
  				      acc01_i_as1,
  				      acc02_i_as1,
  				      acc03_i_as1,
                acc04_i_as1,
                acc05_i_as1,
                acc06_i_as1,
                acc07_i_as1,
                acc08_i_as1,
                acc09_i_as1,
                acc10_i_as1,
                acc11_i_as1,
                acc12_i_as1,
                acc13_i_as1,
                acc14_i_as1,
                acc15_i_as1,
  				      acc_sel_i_as1
  				    );
  
  function [31:0] acc_selector;
    input [31:0] acc00;
    input [31:0] acc01;
    input [31:0] acc02;
    input [31:0] acc03;
    input [31:0] acc04;
    input [31:0] acc05;
    input [31:0] acc06;
    input [31:0] acc07;
    input [31:0] acc08;
    input [31:0] acc09; 
    input [31:0] acc10;
    input [31:0] acc11;
    input [31:0] acc12;
    input [31:0] acc13;
    input [31:0] acc14;
    input [31:0] acc15;
    input [3:0]  acc_sel;
    case(acc_sel)//sysnopsys parallel_case
      4'd00: acc_selector = acc00;
      4'd01: acc_selector = acc01;
      4'd02: acc_selector = acc02;
      4'd03: acc_selector = acc03;
      4'd04: acc_selector = acc04;
      4'd05: acc_selector = acc05;
      4'd06: acc_selector = acc06;
      4'd07: acc_selector = acc07;
      4'd08: acc_selector = acc08;
      4'd09: acc_selector = acc09;
      4'd10: acc_selector = acc10;
      4'd11: acc_selector = acc11;
      4'd12: acc_selector = acc12;
      4'd13: acc_selector = acc13;
      4'd14: acc_selector = acc14;
      4'd15: acc_selector = acc15;
   endcase // case(acc_sel)
  endfunction // acc_selector

  assign imm_as1 = {27'b0,imm5_i_as1};
  assign selected_oprb_tmp_as1 = (sel3_i_as1)? opr0_i_as1: imm_as1;
  assign selected_oprb_as1 = (sel2_i_as1[0])? ~selected_oprb_tmp_as1:
  					      selected_oprb_tmp_as1;
  assign acc_tmp_as1 = selected_acc_as1 + selected_oprb_as1 + sel2_i_as1[0];
  
  
  assign acc_wdata_o_as1 = acc_wdata_selector( opr0_i_as1,
  					       acc_tmp_as1[31:0],
  					       selected_acc_as1,
  					       sel2_i_as1
  					     );
 
  function[31:0] acc_wdata_selector;
    input [31:0] opr0;
    input [31:0] acc_tmp;
    input [31:0] selected_acc;
    input [1:0] sel2;
    casex(sel2)//sysnopsys parallel_case
      2'b0x: acc_wdata_selector = acc_tmp;
      2'b10: acc_wdata_selector = opr0;
      2'b11: acc_wdata_selector = selected_acc;
    endcase // case(sel2)
  endfunction // acc_wdata_selector
  
   
  assign acc_rslt_tmp_as1 = (sel2_i_as1[1])? {1'b0,opr0_i_as1}: acc_tmp_as1;
   
  assign acc_wen_vctr_o_as1 = {fst_clk_i_as1 & acc_ins_as1, acc_sel_i_as1};


  //acc end********************************************************************
    
  //sysreg*********************************************************************
  
  assign selected_sysreg_as1 = sysreg_sel(sysreg00_i_as1,
				      sysreg01_i_as1,
				      sysreg02_i_as1,
				      sysreg03_i_as1,
				      sysreg04_i_as1,
				      sysreg05_i_as1,
				      sysreg06_i_as1,
				      sysreg07_i_as1,
				      imm5_i_as1[2:0]);
  
  function [31:0] sysreg_sel;
    input [31:0] sysreg00;
    input [31:0] sysreg01;
    input [31:0] sysreg02;
    input [31:0] sysreg03;
    input [31:0] sysreg04;
    input [31:0] sysreg05;
    input [31:0] sysreg06;
    input [31:0] sysreg07;
    input [2:0] imm5;
    case(imm5)
      3'b000: sysreg_sel = sysreg00;
      3'b001: sysreg_sel = sysreg01;
      3'b010: sysreg_sel = sysreg02;
      3'b011: sysreg_sel = sysreg03;
      3'b100: sysreg_sel = sysreg04;
      3'b101: sysreg_sel = sysreg05;
      3'b110: sysreg_sel = sysreg06;
      3'b111: sysreg_sel = sysreg07;
    endcase // case(imm5)
  endfunction // sysreg_sel
  
  
  assign sysreg_rslt_tmp_as1 = (sel2_i_as1[1])? opr0_i_as1: selected_sysreg_as1;

  //sysreg end*****************************************************************
  
  
   assign overflow_as1 =  acc_tmp_as1[31]
   			& (~|sel2_i_as1)
   			& ~opr0_i_as1[31];
   			
   assign zero_as1 = (~|acc_tmp_as1[31:0]);

   assign rslt_o_as1 = (sel1_i_as1)? sysreg_rslt_tmp_as1: acc_rslt_tmp_as1[31:0]; 
   assign rslt_cc_o_as1 = {overflow_as1, zero_as1};
  
  
endmodule //AccSysreg
