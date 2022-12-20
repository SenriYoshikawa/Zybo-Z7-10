module IMWrapper(
		clk,
		rst,
		addr_i_imw, // address from Fetch
		inst_i_imw, // instruction to write IM
		mem_wen_i_imw, //write enable from Fetch

		bist_addr_i_imw, // bist address
		bist_data_i_imw, // bist data
		bist_wen_i_imw, // bist write enable

		bist_mode_i_imw, // bist mode

		q_b0_i_imw, // data from IM block0

		addr_o_imw, // address output
		ce_o_imw, // chip enable output
		d_o_imw, // data_output to IM
		mem_wen_o_imw, // write enable
		q_o_imw // data output to Bist & Next Stage
		);
  input clk, rst;
  
  input [13:0]	addr_i_imw; // address from Fetch
  input [33:0]	inst_i_imw; // instruction to write IM
  input [1:0]	mem_wen_i_imw; //write enable from Fetch

  input [13:0]	bist_addr_i_imw; // bist address
  input [33:0]	bist_data_i_imw; // bist data
  input 	bist_wen_i_imw;

  input 	bist_mode_i_imw; // bist mode

  input [33:0]	q_b0_i_imw; // data from IM block0
  
  output [13:0]	addr_o_imw; // address output
  output 	ce_o_imw; // chip enable output
  output [33:0]	d_o_imw;//  data_output to IM
  output 	mem_wen_o_imw;
  output [33:0]	q_o_imw; // data output to Bist & Next Stage


  wire 	 	ce_tmp_imw = 1'b0;
	 
  
  assign 	addr_o_imw	= bist_mode_i_imw? bist_addr_i_imw: addr_i_imw;
  assign 	ce_o_imw	= ce_tmp_imw;
  assign 	d_o_imw		= bist_mode_i_imw? bist_data_i_imw: inst_i_imw;
  assign 	mem_wen_o_imw	= bist_mode_i_imw? bist_wen_i_imw: ((mem_wen_i_imw == 2'b10)? 1'b0: 1'b1);

  assign 	q_o_imw		= q_b0_i_imw;

endmodule

   

