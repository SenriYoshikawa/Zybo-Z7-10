module Ftc0
 (//Input:  name_i_modulename
  //Output: name_o_modulename

  //from FC1
  node_i_ftc0,				//IN
  gen_i_ftc0,
  opr0_i_ftc0,
  opr1_i_ftc0,
  mem_wen_i_ftc0,

  rst,
  clk,


  //to Ftc1 
  node_o_ftc0,				//OUT
  gen_o_ftc0,
  opr0_o_ftc0,
  opr1_o_ftc0,
  mem_wen_o_ftc0,
  w_en_cex_o_ftc0


  );


  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  //from FC1
  input	[15:0]	node_i_ftc0;
  input	[11:0]	gen_i_ftc0;
  input	[31:0]	opr0_i_ftc0;
  input	[31:0]	opr1_i_ftc0;
  input	[1:0]	mem_wen_i_ftc0;  

  input		rst;
  input		clk;


  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  //to Ftc1
  output [15:0]	node_o_ftc0;
  output [11:0]	gen_o_ftc0;
  output [31:0]	opr0_o_ftc0;
  output [31:0]	opr1_o_ftc0;
  output [1:0]	mem_wen_o_ftc0;
  output	w_en_cex_o_ftc0;


  /***********************************************************/
  /*                 DEFINITION OF REGISTER                  */
  /***********************************************************/

  //Pipeline Register at Ftc0/Ftc1
  reg	[15:0]	node_reg_ftc0;
  reg	[11:0]	gen_reg_ftc0;
  reg	[31:0]	opr0_reg_ftc0;
  reg	[31:0]	opr1_reg_ftc0;
  reg	[1:0]	mem_wen_reg_ftc0;


  /***********************************************************/
  /*                        OUT                              */ 
  /***********************************************************/

  assign 	node_o_ftc0 = node_reg_ftc0;
  assign 	gen_o_ftc0 = gen_reg_ftc0;
  assign 	opr0_o_ftc0 = opr0_reg_ftc0;
  assign 	opr1_o_ftc0 = opr1_reg_ftc0;
  assign 	mem_wen_o_ftc0 = mem_wen_reg_ftc0;

  //mem_wen
  //	2'b00 :	no writing memory
  //	2'b01 :	write data to Data Mem
  //	2'b10 :	write data to Ins Mem
  //	2'b11 :	write data to Type Mem
  assign 	w_en_cex_o_ftc0 = (mem_wen_reg_ftc0 == 2'b10)? 1'b0: 1'b1;


  /***********************************************************/
  /*              PipeLine Register (Ftc0/Ftc1)                */
  /***********************************************************/

  always @(posedge clk  or  negedge rst) begin
    if (rst == 1'b0) begin
      node_reg_ftc0		<= {16{1'b0}};
      gen_reg_ftc0 		<= {12{1'b0}};
      opr0_reg_ftc0 		<= {32{1'b0}};
      opr1_reg_ftc0 		<= {32{1'b0}};
      mem_wen_reg_ftc0		<= {2{1'b0}};
    end else begin
      node_reg_ftc0		<= node_i_ftc0;
      gen_reg_ftc0 		<= gen_i_ftc0;
      opr0_reg_ftc0 		<= opr0_i_ftc0;
      opr1_reg_ftc0 		<= opr1_i_ftc0;
      mem_wen_reg_ftc0		<= mem_wen_i_ftc0;
    end
  end


endmodule //Ftc0