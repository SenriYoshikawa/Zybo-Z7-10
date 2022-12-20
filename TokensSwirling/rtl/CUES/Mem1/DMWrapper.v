`timescale 1ps/1ps
module DMWrapper(
		clk,
		rst,
		addr_i_dmw, // address from Fetch
		data_i_dmw, // data to write IM
		mem_wen_i_dmw, //write enable from Fetch
		dm_dopc_i_dmw,

		bist_addr_i_dmw, // bist address
		bist_data_i_dmw, // bist data
		bist_wen_i_dmw, // bist write enable

		bist_mode_i_dmw, // bist mode

		q_b0_i_dmw, // data from IM block0

		addr_o_dmw, // address output
		ce_o_dmw, // chip enable output
		d_o_dmw, // data_output to IM
		mem_wen_o_dmw, // write enable
		q_o_dmw // data output to Bist & Next Stage
		);
  input clk, rst;
  
  input [13:0]	addr_i_dmw; // address from Fetch
  input [31:0]	data_i_dmw; // data to write IM
  input 	mem_wen_i_dmw; //write enable from Fetch
  input [1:0]	dm_dopc_i_dmw;

  input [13:0]	bist_addr_i_dmw; // bist address
  input [31:0]	bist_data_i_dmw; // bist data
  input 	bist_wen_i_dmw;

  input 	bist_mode_i_dmw; // bist mode

  input [31:0]	q_b0_i_dmw; // data from IM block0
  
  output [13:0]	addr_o_dmw; // address output
  output 	ce_o_dmw; // chip enable output
  output [31:0]	d_o_dmw;//  data_output to IM
  output 	mem_wen_o_dmw;
  output [31:0]	q_o_dmw; // data output to Bist & Next Stage

  wire [3:0] 	ce_tmp_dmw = 1'b0;
	 
  
  assign 	addr_o_dmw    = bist_mode_i_dmw? bist_addr_i_dmw: addr_i_dmw;
  assign 	ce_o_dmw      = ce_tmp_dmw;
  assign 	d_o_dmw       = bist_mode_i_dmw? bist_data_i_dmw: data_i_dmw;
  assign 	mem_wen_o_dmw = bist_mode_i_dmw?
	 bist_wen_i_dmw:
	 (((mem_wen_i_dmw == 1'b1)|(dm_dopc_i_dmw[1]&dm_dopc_i_dmw[0]))? 1'b0: 1'b1);


  assign 	 q_o_dmw       = q_b0_i_dmw;


endmodule

   

