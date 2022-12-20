`timescale 1ps/1ps
module Mer
  (//Input:  name_i_modulename
   //Output: name_o_modulename

   //from Sw
   lr_sw_i_mer,				//IN
   node_sw_i_mer,
   gen_sw_i_mer,
   opr_sw_i_mer,
   uni_opr_sw_i_mer,
  
   //from ICN
   lr_icn_i_mer,
   node_icn_i_mer,
   gen_icn_i_mer,
   opr_icn_i_mer,
   uni_opr_icn_i_mer,
   mem_wen_icn_i_mer,
  
   rst,
   clka,
   clkb,
   aeb_cm_mer,


   //to TC0
   lr_o_mer,				//OUT
   node_o_mer,
   gen_o_mer,
   opr_o_mer,
   uni_opr_o_mer,
   mem_wen_o_mer
   );


   /***********************************************************/
   /*           DEFINITION OF INPUT SIGNALS                   */
   /***********************************************************/

   //from Sw
   input        lr_sw_i_mer;
   input [15:0] node_sw_i_mer;
   input [11:0] gen_sw_i_mer;
   input [31:0] opr_sw_i_mer;
   input 	uni_opr_sw_i_mer;
   //from IFIFO
   input 	lr_icn_i_mer;
   input [15:0] node_icn_i_mer;
   input [11:0] gen_icn_i_mer;
   input [31:0] opr_icn_i_mer;
   input 	uni_opr_icn_i_mer;
   input [1:0] 	mem_wen_icn_i_mer;

   input 	rst;
   input 	clka;
   input 	clkb;
   input 	aeb_cm_mer;


   /***********************************************************/
   /*           DEFINITION OF OUTPUT SIGNALS                  */
   /***********************************************************/

   //to TC0
   output 	 lr_o_mer;
   output [15:0] node_o_mer;
   output [11:0] gen_o_mer;
   output [31:0] opr_o_mer;
   output 	 uni_opr_o_mer;
   output [1:0]  mem_wen_o_mer;


   /***********************************************************/
   /*                 DEFINITION OF REGISTER                  */
   /***********************************************************/

   //Pipeline Register at Mer/TC0
   reg 		 lr_sw_reg_mer;
   reg [15:0] 	 node_sw_reg_mer;
   reg [11:0] 	 gen_sw_reg_mer;
   reg [31:0] 	 opr_sw_reg_mer;
   reg 		 uni_opr_sw_reg_mer;
   reg [1:0] 	 mem_wen_sw_reg_mer;
   reg 		 lr_icn_reg_mer;
   reg [15:0] 	 node_icn_reg_mer;
   reg [11:0] 	 gen_icn_reg_mer;
   reg [31:0] 	 opr_icn_reg_mer;
   reg 		 uni_opr_icn_reg_mer;
   reg [1:0] 	 mem_wen_icn_reg_mer;


   /***********************************************************/
   /*              PipeLine Register (Mer/TC0)                */
   /***********************************************************/

   always @(posedge clka  or  negedge rst) begin
      if (rst == 1'b0) begin
	 lr_sw_reg_mer		<= 1'b0;
	 node_sw_reg_mer	<= {16{1'b0}};
	 gen_sw_reg_mer 	<= {12{1'b0}};
	 opr_sw_reg_mer 	<= {32{1'b0}};
	 uni_opr_sw_reg_mer 	<= 1'b0;
	 mem_wen_sw_reg_mer	<= {2{1'b0}};
      end else begin
	 lr_sw_reg_mer		<= lr_sw_i_mer;
	 node_sw_reg_mer	<= node_sw_i_mer;
	 gen_sw_reg_mer 	<= gen_sw_i_mer;
	 opr_sw_reg_mer 	<= opr_sw_i_mer;
	 uni_opr_sw_reg_mer 	<= uni_opr_sw_i_mer;
      end
   end
   
   always @(posedge clkb  or  negedge rst) begin
      if (rst == 1'b0) begin
	 lr_icn_reg_mer		<= 1'b0;
	 node_icn_reg_mer	<= {16{1'b0}};
	 gen_icn_reg_mer 	<= {12{1'b0}};
	 opr_icn_reg_mer 	<= {32{1'b0}};
	 uni_opr_icn_reg_mer 	<= 1'b0;
	 mem_wen_icn_reg_mer	<= {2{1'b0}};
      end else begin
	 lr_icn_reg_mer		<= lr_icn_i_mer;
	 node_icn_reg_mer	<= node_icn_i_mer;
	 gen_icn_reg_mer 	<= gen_icn_i_mer;
	 opr_icn_reg_mer 	<= opr_icn_i_mer;
	 uni_opr_icn_reg_mer 	<= uni_opr_icn_i_mer;
	 mem_wen_icn_reg_mer	<= mem_wen_icn_i_mer;
      end
   end

   
   /***********************************************************/
   /*                       INCLUDE MUX                       */
   /***********************************************************/
   
   PktSel PktSel(
  		 //input
  		 .lr_pkta_i_pktsel( lr_sw_reg_mer ),
		 .node_pkta_i_pktsel( node_sw_reg_mer ),
		 .gen_pkta_i_pktsel( gen_sw_reg_mer ),
		 .opr_pkta_i_pktsel( opr_sw_reg_mer ),
		 .uni_opr_pkta_i_pktsel( uni_opr_sw_reg_mer ),
		 .mem_wen_pkta_i_pktsel( mem_wen_sw_reg_mer ),
		 .lr_pktb_i_pktsel( lr_icn_reg_mer ),
		 .node_pktb_i_pktsel( node_icn_reg_mer ),
		 .gen_pktb_i_pktsel( gen_icn_reg_mer ),
		 .opr_pktb_i_pktsel( opr_icn_reg_mer ),
		 .uni_opr_pktb_i_pktsel( uni_opr_icn_reg_mer ),
		 .mem_wen_pktb_i_pktsel( mem_wen_icn_reg_mer ),
		 .aeb_i_pktsel( aeb_cm_mer ),
      
		 //output
  		 .lr_o_pktsel( lr_o_mer ),
		 .node_o_pktsel( node_o_mer ),
		 .gen_o_pktsel( gen_o_mer ),
		 .opr_o_pktsel( opr_o_mer ),
		 .uni_opr_o_pktsel( uni_opr_o_mer ),
		 .mem_wen_o_pktsel( mem_wen_o_mer )
		 );


endmodule //Mer
