`timescale 1ps/1ps
module Ftc1
  (//Input:  name_i_modulename
   //Output: name_o_modulename

   //from Ftc0
   node_i_ftc1,				//IN
   gen_i_ftc1,
   opr0_i_ftc1,
   opr1_i_ftc1,
   mem_wen_i_ftc1,

   rst,
   clk,

   b_clk,
   bist_mode_i_ftc1,
  
   //to Dec0
   node_o_ftc1,				//OUT
   gen_o_ftc1,
   opr0_o_ftc1,
   opr1_o_ftc1,
   mem_wen_o_ftc1,
   ins_o_ftc1,

   // bist output
   bistfail_o_ftc1,
   bistfinish_o_ftc1
   );


   /***********************************************************/
   /*         DEFINITION OF INPUT SIGNALS                     */
   /***********************************************************/

   //from Ftc0
   input [15:0]		node_i_ftc1;
   input [11:0] 	gen_i_ftc1;
   input [31:0] 	opr0_i_ftc1;
   input [31:0] 	opr1_i_ftc1;
   input [1:0] 		mem_wen_i_ftc1;  

   input 		rst;
   input 		clk;

   input 		b_clk;
   input 		bist_mode_i_ftc1;

   /***********************************************************/
   /*         DEFINITION OF OUTPUT SIGNALS                    */
   /***********************************************************/

   //to Dec0
   output [15:0] 	node_o_ftc1;
   output [11:0] 	gen_o_ftc1;
   output [31:0] 	opr0_o_ftc1;
   output [31:0] 	opr1_o_ftc1;
   output 		   mem_wen_o_ftc1;
   output [33:0] 	ins_o_ftc1;

   output 		   bistfail_o_ftc1;
   output 		   bistfinish_o_ftc1;

   /***********************************************************/
   /*         Pipeline  REGISTERs                             */
   /***********************************************************/

   //Pipeline Register at Ftc1/Dec0
   reg [15:0] 		node_reg_ftc1;
   reg [11:0] 		gen_reg_ftc1;
   reg [31:0] 		opr0_reg_ftc1;
   reg [31:0] 		opr1_reg_ftc1;
   reg			      mem_wen_reg_ftc1;
   

   /***********************************************************/
   /*         Output                                          */ 
   /***********************************************************/

   assign 		node_o_ftc1 = node_reg_ftc1;
   assign 		gen_o_ftc1 = gen_reg_ftc1;
   assign 		opr0_o_ftc1 = opr0_reg_ftc1;
   assign 		opr1_o_ftc1 = opr1_reg_ftc1;
   assign 		mem_wen_o_ftc1 = mem_wen_reg_ftc1;


   /***********************************************************/
   /*         Latch PipeLine Register                         */
   /***********************************************************/

  always @(posedge clk  or  negedge rst) begin
    if (rst == 1'b0) begin
      node_reg_ftc1	<= {16{1'b0}};
      gen_reg_ftc1 	<= {12{1'b0}};
      opr0_reg_ftc1 	<= {32{1'b0}};
      opr1_reg_ftc1 	<= {32{1'b0}};
      mem_wen_reg_ftc1 <= 1'b0;
    end else begin
      node_reg_ftc1	<= node_i_ftc1;
      gen_reg_ftc1 	<= gen_i_ftc1;
      opr0_reg_ftc1	<= opr0_i_ftc1;
      opr1_reg_ftc1	<= opr1_i_ftc1;
      mem_wen_reg_ftc1 <= mem_wen_i_ftc1[0];
    end
  end
   
   
   /***********************************************************/
   /*                     INCLUDE IM                          */
   /***********************************************************/
   
  IM IM(
    //input
    .node_i_im( node_i_ftc1[13:0] ),
    .opr0_i_im( opr0_i_ftc1 ),
    .tf_uni_opr_i_im( gen_i_ftc1[1:0] ),
    .mem_wen_i_im( mem_wen_i_ftc1 ),
    
    .rst( rst ),
    .clk( clk ),

    .b_clk(b_clk), // bist clock
    .bist_mode_i_im(bist_mode_i_ftc1),

    //output
    .ins_o_im( ins_o_ftc1 ),


    .bistfail_o_im(bistfail_o_ftc1),
    .bistfinish_o_im(bistfinish_o_ftc1)
  );


endmodule //Ftc1
