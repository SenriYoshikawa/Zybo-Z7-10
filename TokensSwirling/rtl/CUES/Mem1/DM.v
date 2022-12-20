`timescale 1ps/1ps
module DM
  (//Input:  name_i_modulename
  //Output: name_o_modulename

  //from Mem0(Mem1)
  opr0_i_dm,				//IN
  dm_addr_i_dm,
  mem_wen_i_dm,
  dm_dopc_i_dm,

  rst,
  clk,

  b_clk,
  bist_mode_i_dm,

  //to Sw(Mem1)
  dm_data_o_dm,		//OUT
  
  bistfail_o_dm,
  bistfinish_o_dm
  
  
  );


  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  //from Mem0(Mem1)
  input [31:0]	opr0_i_dm;
  input [13:0]	dm_addr_i_dm;
  input 	mem_wen_i_dm;  
  input [1:0] 	dm_dopc_i_dm;

  input 	rst;
  input 	clk;

  input 	b_clk;
  input 	bist_mode_i_dm;

  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  //to Sw(Mem1)
  output [31:0] dm_data_o_dm;
  
  output 	bistfail_o_dm;
  output 	bistfinish_o_dm;

  /***********************************************************/
  /*         etc. etc.                                       */
  /***********************************************************/
  wire 		bypass = 1'b0;

  /***********************************************************/
  /*         Select memory clock                             */
  /***********************************************************/
  wire 		m_clk;
  assign 	m_clk = bist_mode_i_dm? b_clk: clk;

  /***********************************************************/
  /*         Connecting WIRE Bist to IMWrapper               */
  /***********************************************************/
  wire [13:0] 	b_addr_BistDM_DMWrapper;
  wire [31:0] 	b_data_BistDM_DMWrapper;
  wire 		b_wen_BistDM_DMWrapper;

  /***********************************************************/
  /*         Connecting WIRE Memory Block to DMWrapper       */
  /***********************************************************/
  wire [31:0] 	data_b0_DMWrapper;

  /***********************************************************/
  /*         Connecting WIRE Memory DMWrapper to Block       */
  /***********************************************************/
  //wire [13:0] 	addr_DMWrapper_bX;
  wire 		ce_DMWrapper_bX;
  //wire [31:0] 	data_DMWrapper_bX;
  wire 		we_DMWrapper_bX;
  wire [31:0] 	q_DMWrapper_Bist_or_Next;
  
  wire [13:0] 	addr_DMWrapper_DMD;
  wire [31:0] 	data_DMWrapper_DMD;
  wire 	 	we_DMWrapper_DMD;
  wire [13:0] 	addr_DMD_bx;
  wire [31:0] 	data_DMD_bx;
  wire 	 	we_DMD_bX;

  /***********************************************************/
  /*         Connecting WIRE DMWrapper to Bist               */
  /***********************************************************/
  wire [31:0] 	b_data_DMWrapper_BistDM;
  assign 	dm_data_o_dm = b_data_DMWrapper_BistDM;

  /***********************************************************/
  /*         DataMem                                         */
  /***********************************************************/

  DMWrapper iDMWrapper(
			.clk(m_clk),
			.rst(rst),
			.addr_i_dmw(dm_addr_i_dm), // address from Fetch
			.data_i_dmw(opr0_i_dm), // data to write IM
			.mem_wen_i_dmw(mem_wen_i_dm), //write enable from Fetch
			.dm_dopc_i_dmw(dm_dopc_i_dm),

			.bist_addr_i_dmw(b_addr_BistDM_DMWrapper), // bist address
			.bist_data_i_dmw(b_data_BistDM_DMWrapper[31:0]), // bist data
			.bist_wen_i_dmw(b_wen_BistDM_DMWrapper), // bist write enable

			.bist_mode_i_dmw(bist_mode_i_dm), // bist mode

			.q_b0_i_dmw(data_b0_DMWrapper), // data from IM block0

			.addr_o_dmw(addr_DMWrapper_DMD), // address output
			.ce_o_dmw(ce_DMWrapper_bX), // chip enable output
			.d_o_dmw(data_DMWrapper_DMD), // instruction output
			.mem_wen_o_dmw(we_DMWrapper_DMD),
			.q_o_dmw(b_data_DMWrapper_BistDM) // read data form mem
			);

  defparam iBistDM.RWIDTH = 32;
  defparam iBistDM.RDEPTH = 14;

  Bist1RW iBistDM(
		.RST(rst),
		.D(b_data_DMWrapper_BistDM),
		.CLK(m_clk),
		.WEN(b_wen_BistDM_DMWrapper),
		.A(b_addr_BistDM_DMWrapper),
		.Q(b_data_BistDM_DMWrapper),
		.BistMode(bist_mode_i_dm),
		.BistFail(bistfail_o_dm),
		.BistFinish(bistfinish_o_dm)
		);
  
  defparam DMDelay.RWIDTH = 32;
  defparam DMDelay.RDEPTH = 14;
  
  MemDelay DMDelay(
  		.I_i( data_DMWrapper_DMD ),
  		.IA_i( addr_DMWrapper_DMD ),
		.WE_i(we_DMWrapper_DMD),
  		.I_o( data_DMD_bx ),
  		.IA_o( addr_DMD_bx ),
		.WE_o(we_DMD_bX)
  		);
  
  

  RAMS32B16KW db0(
		.A(data_b0_DMWrapper),
		.I(data_DMD_bx),
		.IA(addr_DMD_bx),
		.DM({32{1'b0}}),
		.CK(m_clk),
		.CE(ce_DMWrapper_bX),
		.WE(we_DMD_bX),
		.BP(bypass)
		);


endmodule //DM
