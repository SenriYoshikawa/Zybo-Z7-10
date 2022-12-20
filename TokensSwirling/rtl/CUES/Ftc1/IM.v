module IM
  (//Input:  name_i_modulename
  //Output: name_o_modulename

  //from Ftc0(Ftc1)
  node_i_im,			//IN
  opr0_i_im,
  tf_uni_opr_i_im,
  mem_wen_i_im,

  rst,
  clk,

  b_clk, // bist clock
  bist_mode_i_im,

  //to Dec0(Ftc1)
  ins_o_im,				//OUT

  bistfail_o_im,
  bistfinish_o_im

  );


  /***********************************************************/
  /*           INPUT SIGNALS                                 */
  /***********************************************************/

  //from Ftc0(Ftc1)
  input [13:0]	node_i_im;
  input [31:0] 	opr0_i_im;
  input [1:0] 	tf_uni_opr_i_im;
  input [1:0] 	mem_wen_i_im;

  input 	rst;
  input 	clk;
  input 	b_clk;
  input 	bist_mode_i_im;

  /***********************************************************/
  /*           OUTPUT SIGNALS                                */
  /***********************************************************/

  //to Dec0(Ftc1)
  output [33:0] ins_o_im;
  output 	bistfail_o_im;
  output 	bistfinish_o_im;

  /***********************************************************/
  /*         etc. etc.                                       */
  /***********************************************************/

  wire 		bypass = 1'b0;

  /***********************************************************/
  /*         Select memory clock                             */
  /***********************************************************/
  wire 		m_clk;
  assign 	m_clk = bist_mode_i_im? b_clk: clk;
  
  /***********************************************************/
  /*         Connecting WIRE Bist to IMWrapper               */
  /***********************************************************/
  wire [13:0] 	b_addr_BistIM_IMWrapper;
  wire [33:0] 	b_data_BistIM_IMWrapper;
  wire 		b_wen_BistIM_IMWrapper;

  /***********************************************************/
  /*         Connecting WIRE Memory Block to IMWrapper       */
  /***********************************************************/
  wire [33:0] 	data_b0_IMWrapper;
  
  /***********************************************************/
  /*         Connecting WIRE Memory IMWrapper to Block       */
  /***********************************************************/
  wire  	ce_IMWrapper_bX;
  wire 		we_IMWrapper_bX;
  wire [33:0] 	q_IMWrapper_Bist_or_Next;
  
  wire [13:0] 	addr_IMWrapper_IMD;
  wire [33:0] 	data_IMWrapper_IMD;
  wire 	 	we_IMWrapper_IMD;
  wire [13:0] 	addr_IMD_bx;
  wire [33:0] 	data_IMD_bx;
  wire 	 	we_IMD_bX;
  /***********************************************************/
  /*         Connecting WIRE IMWrapper to Bist               */
  /***********************************************************/
  wire [33:0] 	b_data_IMWrapper_BistIM;
  assign	ins_o_im = b_data_IMWrapper_BistIM;

  IMWrapper iIMWrapper(
		.clk(m_clk),
		.rst(rst),
		.addr_i_imw(node_i_im), // address from Fetch
		.inst_i_imw({opr0_i_im[31:25],tf_uni_opr_i_im,opr0_i_im[24:0]}), // instruction to write IM
		.mem_wen_i_imw(mem_wen_i_im), //write enable from Fetch

		.bist_addr_i_imw(b_addr_BistIM_IMWrapper), // bist address
		.bist_data_i_imw(b_data_BistIM_IMWrapper), // bist data
		.bist_wen_i_imw(b_wen_BistIM_IMWrapper), // bist write enable

		.bist_mode_i_imw(bist_mode_i_im), // bist mode

		.q_b0_i_imw(data_b0_IMWrapper), // data from IM block0

		.addr_o_imw(addr_IMWrapper_IMD), // address output
		.ce_o_imw(ce_IMWrapper_bX), // chip enable output
		.d_o_imw(data_IMWrapper_IMD), // instruction output
		.mem_wen_o_imw(we_IMWrapper_IMD),
		.q_o_imw(b_data_IMWrapper_BistIM) // read data from mem
		);


  defparam iBistIM.RWIDTH = 34;
  defparam iBistIM.RDEPTH = 14;

  Bist1RW iBistIM(
		.RST(rst),
		.D(b_data_IMWrapper_BistIM),
		.CLK(m_clk),
		.WEN(b_wen_BistIM_IMWrapper),
		.A(b_addr_BistIM_IMWrapper),
		.Q(b_data_BistIM_IMWrapper),
		.BistMode(bist_mode_i_im),
		.BistFail(bistfail_o_im),
		.BistFinish(bistfinish_o_im)
		);

  defparam IMDelay.RWIDTH = 34;
  defparam IMDelay.RDEPTH = 14;
  
  MemDelay IMDelay(
  		.I_i( data_IMWrapper_IMD ),
  		.IA_i( addr_IMWrapper_IMD ),
		.WE_i(we_IMWrapper_IMD),
  		.I_o( data_IMD_bx ),
  		.IA_o( addr_IMD_bx ),
		.WE_o(we_IMD_bX)
  		);
  
  //Instruction Mem
  RAMS34B16KW b0 (
		.A(data_b0_IMWrapper),
		.I(data_IMD_bx),
		.IA(addr_IMD_bx),
		.DM({34{1'b0}}),
		.CK(m_clk),
		.CE(ce_IMWrapper_bX),
		.WE(we_IMD_bX),
		.BP(bypass)
		);

endmodule //IM
