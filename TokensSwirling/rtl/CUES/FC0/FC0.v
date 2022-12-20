module FC0
 (//Input:  name_i_modulename
  //Output: name_o_modulename

  //from TC1
  lr_i_fc0,					//IN
  node_i_fc0,
  gen_i_fc0,
  opr_i_fc0,
  uni_opr_i_fc0,
  mem_wen_i_fc0,
  mm16_fc0,
  
  pg_mmu0_fc0,
  pg_mmu1_fc0,

  rst,
  clk,


  //to FC1
  lr_o_fc0,					//OUT
  node_o_fc0,
  gen_o_fc0,
  opr_o_fc0,
  mem_wen_o_fc0,
  mtch_data_o_fc0,
  
  uni_opr_fc0,
  mtch_rslt_cex_o_fc0,
  mm_full_fc0,
  mmu0_mm_full_fc0,
  mmu0_mm_empty_fc0,
  mmu1_mm_empty_fc0,
  next_mmu0_w_fc0,
  next_mmu1_w_fc0,
  mmu0_next_empty_fc0,
  mmu1_next_empty_fc0


  );


  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  //from TC1
  input		lr_i_fc0;
  input	[15:0]	node_i_fc0;
  input	[11:0]	gen_i_fc0;
  input	[31:0]	opr_i_fc0;
  input		uni_opr_i_fc0;
  input	[1:0]	mem_wen_i_fc0;
  input 	mm16_fc0;
  
  input 	pg_mmu0_fc0;
  input 	pg_mmu1_fc0;

  input		rst;
  input		clk;


  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  //to FC1
  output 	lr_o_fc0;
  output [15:0]	node_o_fc0;
  output [11:0]	gen_o_fc0;
  output [31:0]	opr_o_fc0;
  output [1:0]	mem_wen_o_fc0;
  output [31:0]	mtch_data_o_fc0;
  
  output 	mtch_rslt_cex_o_fc0;
  
  output 	uni_opr_fc0;
  output	mm_full_fc0;
  output	mmu0_mm_full_fc0;
  output	mmu0_mm_empty_fc0;
  output	mmu1_mm_empty_fc0;
  output 	next_mmu0_w_fc0;
  output 	next_mmu1_w_fc0;
  output 	mmu0_next_empty_fc0;
  output 	mmu1_next_empty_fc0;


  /***********************************************************/
  /*                 DEFINITION OF REGISTER                  */
  /***********************************************************/

  //Pipeline Register at FC0/FC1
  reg 		lr_reg_fc0;
  reg [15:0]	node_reg_fc0;
  reg [11:0]	gen_reg_fc0;
  reg [31:0]	opr_reg_fc0;
  reg 		uni_opr_reg_fc0;
  reg [1:0]	mem_wen_reg_fc0;
  


  /***********************************************************/
  /*                 DEFINITION OF WIRE                      */
  /***********************************************************/

  wire	[27:0]	mm_key_fc0;
  assign	mm_key_fc0 = {node_reg_fc0, gen_reg_fc0};
  
  wire		mtch_rslt_fc0;


  /***********************************************************/
  /*                        OUT                              */ 
  /***********************************************************/

  assign 	lr_o_fc0 = lr_reg_fc0;
  assign 	node_o_fc0 = node_reg_fc0;
  assign 	gen_o_fc0 = gen_reg_fc0;
  assign 	opr_o_fc0 = opr_reg_fc0;
  assign 	mem_wen_o_fc0 = mem_wen_reg_fc0;
  
  assign 	mtch_rslt_cex_o_fc0 = mtch_rslt_fc0 | uni_opr_reg_fc0;
  
  assign 	uni_opr_fc0 = uni_opr_reg_fc0;
  
  
  /***********************************************************/
  /*              PipeLine Register (FC0/FC1)                */
  /***********************************************************/

  always @(posedge clk  or  negedge rst) begin
    if (rst == 1'b0) begin
      lr_reg_fc0		<= 1'b0;
      node_reg_fc0		<= {16{1'b0}};
      gen_reg_fc0		<= {12{1'b0}};
      opr_reg_fc0		<= {32{1'b0}};
      uni_opr_reg_fc0		<= 1'b0;
      mem_wen_reg_fc0		<= {2{1'b0}};
    end else begin
      lr_reg_fc0		<= lr_i_fc0;
      node_reg_fc0		<= node_i_fc0;
      gen_reg_fc0		<= gen_i_fc0;
      opr_reg_fc0		<= opr_i_fc0;
      uni_opr_reg_fc0		<= uni_opr_i_fc0;
      mem_wen_reg_fc0		<= mem_wen_i_fc0;
    end
  end
  
  
  /***********************************************************/
  /*                  INCLUDE TypeMem                        */
  /***********************************************************/
   
  MM MM(
		.key( mm_key_fc0 ),
		.data0( opr_reg_fc0 ),
		.uni_opr_flg( uni_opr_reg_fc0 ),
		.mm16( mm16_fc0 ),
		.pg_mmu0( pg_mmu0_fc0 ),
		.pg_mmu1( pg_mmu1_fc0 ),
		.clk( clk ),
		.rst( rst ),
		.mtch_data( mtch_data_o_fc0 ),
		.mtch_rslt( mtch_rslt_fc0 ),
		.mm_full( mm_full_fc0 ),
		.mmu0_mm_full( mmu0_mm_full_fc0 ),
		.mmu0_mm_empty( mmu0_mm_empty_fc0 ),
		.mmu1_mm_empty( mmu1_mm_empty_fc0 ),
		.next_mmu0_w( next_mmu0_w_fc0 ),
		.next_mmu1_w( next_mmu1_w_fc0 ),
		.mmu0_next_empty( mmu0_next_empty_fc0 ),
		.mmu1_next_empty( mmu1_next_empty_fc0 )
		);


endmodule //FC0
