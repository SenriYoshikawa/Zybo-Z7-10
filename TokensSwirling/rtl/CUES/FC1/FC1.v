module FC1
 (//Input:  name_i_modulename
  //Output: name_o_modulename

  //from FC0
  lr_i_fc1,					//OUT
  node_i_fc1,
  gen_i_fc1,
  opr_i_fc1,
  mem_wen_i_fc1,
  mtch_data_i_fc1,
  
  rst,
  clk,


  //to CPMer
  node_o_fc1,				//OUT
  gen_o_fc1,
  opr0_o_fc1,
  opr1_o_fc1,
  mem_wen_o_fc1

  );


  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  //from FC0
  input		lr_i_fc1;
  input	[15:0]	node_i_fc1;
  input	[11:0]	gen_i_fc1;
  input	[31:0]	opr_i_fc1;
  input	[1:0]	mem_wen_i_fc1;
  input	[31:0]	mtch_data_i_fc1;

  input		rst;
  input		clk;


  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  //to CPMer
  output [15:0]	node_o_fc1;
  output [11:0]	gen_o_fc1;
  output [31:0]	opr0_o_fc1;
  output [31:0]	opr1_o_fc1;
  output [1:0]	mem_wen_o_fc1;


  /***********************************************************/
  /*                 DEFINITION OF REGISTER                  */
  /***********************************************************/

  //Pipeline Register at FC1/Ftc0
  reg [15:0]	lr_reg_fc1;
  reg [15:0]	node_reg_fc1;
  reg [11:0]	gen_reg_fc1;
  reg [31:0]	opr_reg_fc1;
  reg [1:0]	mem_wen_reg_fc1;
  reg [31:0]	mtch_data_reg_fc1;


  /***********************************************************/
  /*                        OUT                              */ 
  /***********************************************************/

  assign 	node_o_fc1 = node_reg_fc1;
  assign 	gen_o_fc1 = gen_reg_fc1;
  assign 	mem_wen_o_fc1 = mem_wen_reg_fc1;
  
  assign 	opr0_o_fc1 = (lr_reg_fc1)? mtch_data_reg_fc1: opr_reg_fc1;
  assign 	opr1_o_fc1 = (lr_reg_fc1)? opr_reg_fc1: mtch_data_reg_fc1;


  /***********************************************************/
  /*              PipeLine Register (FC0/FC1)                */
  /***********************************************************/

  always @(posedge clk  or  negedge rst) begin
    if (rst == 1'b0) begin
      lr_reg_fc1	<= 1'b0;
      node_reg_fc1	<= {16{1'b0}};
      gen_reg_fc1	<= {12{1'b0}};
      opr_reg_fc1	<= {32{1'b0}};
      mem_wen_reg_fc1	<= {2{1'b0}};
      mtch_data_reg_fc1	<= {32{1'b0}};
    end else begin
      lr_reg_fc1	<= lr_i_fc1;
      node_reg_fc1	<= node_i_fc1;
      gen_reg_fc1	<= gen_i_fc1;
      opr_reg_fc1	<= opr_i_fc1;
      mem_wen_reg_fc1	<= mem_wen_i_fc1;
      mtch_data_reg_fc1	<= mtch_data_i_fc1;
    end
  end


endmodule //FC1
