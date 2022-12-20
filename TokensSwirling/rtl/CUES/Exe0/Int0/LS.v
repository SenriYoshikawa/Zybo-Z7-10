module LS(
	  sel_module_i_ls,
	  node_i_ls,
	  opr1_i_ls,
	  mem_wen_i_ls,
	  imm16_i_ls,
	  sel1_i_ls,
	  sel_ls_i_ls,
	  terminate_i_ls,
	  
	  dm_dopc_o_ls,
	  dm_addr_o_ls

	  );
  
  
  //********************************
  input [2:0]	sel_module_i_ls;
  input [13:0]	node_i_ls;
  input [13:0]	opr1_i_ls;
  input 	mem_wen_i_ls;
  input [13:0]	imm16_i_ls;
  input 	sel1_i_ls; // 0:LS/1:write
  input 	sel_ls_i_ls;
  input 	terminate_i_ls;
  
  output [2:0]	dm_dopc_o_ls;
  output [13:0]	dm_addr_o_ls;

  //********************************

  wire 	 	ls_valid;
  wire 	 	terminate_ls;
  wire [14:0]	dm_addr_tmp;
  
  assign 	ls_valid = (&sel_module_i_ls) & ~sel1_i_ls;
  assign 	terminate_ls = (&sel_module_i_ls) & terminate_i_ls;
  assign 	dm_dopc_o_ls = {ls_valid,sel_ls_i_ls,terminate_ls};
  
  assign 	dm_addr_tmp = opr1_i_ls + imm16_i_ls;
  assign 	dm_addr_o_ls = (mem_wen_i_ls)? node_i_ls: dm_addr_tmp[13:0];

   
endmodule //LS
