module Dec0
 (//Input:  name_i_modulename
  //Output: name_o_modulename

  //from Ftc1
  node_i_dec0,					//IN
  gen_i_dec0,
  opr0_i_dec0,
  opr1_i_dec0,
  mem_wen_i_dec0,
  ins_i_dec0,
  
  rst,
  clk,
  
  
  //to Exe0
  node_o_dec0,					//OUT
  gen_o_dec0,
  opr0_o_dec0,
  opr1_o_dec0,
  mem_wen_o_dec0,
  dopc_o_dec0,
  ins_o_dec0,
  
  mul_ins_o_dec0,
  sh_ins_o_dec0


  );


  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  //from Ftc0
  input	[15:0]	node_i_dec0;
  input	[11:0]	gen_i_dec0;
  input	[31:0]	opr0_i_dec0;
  input	[31:0]	opr1_i_dec0;
  input		mem_wen_i_dec0;  
  input	[33:0]	ins_i_dec0;  

  input		rst;
  input		clk;


  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  //to Exe0
  output [15:0]	node_o_dec0;
  output [11:0]	gen_o_dec0;
  output [31:0]	opr0_o_dec0;
  output [31:0]	opr1_o_dec0;
  output 	      mem_wen_o_dec0;
  output [9:0]	dopc_o_dec0;
  output [26:0]	ins_o_dec0;
  output 	      mul_ins_o_dec0;
  output 	      sh_ins_o_dec0;
  

  /***********************************************************/
  /*                 DEFINITION OF REGISTER                  */
  /***********************************************************/

  //Pipeline Register at Dec0/Exe0
  reg [15:0]	node_reg_dec0;
  reg [11:0]	gen_reg_dec0;
  reg [31:0]	opr0_reg_dec0;
  reg [31:0]	opr1_reg_dec0;
  reg		      mem_wen_reg_dec0;
  reg [6:0]	  opecode_reg_dec0;
  reg [26:0]	ins_reg_dec0;


  /***********************************************************/
  /*                        OUT                              */ 
  /***********************************************************/

  assign 	node_o_dec0 = node_reg_dec0;
  assign 	gen_o_dec0 = gen_reg_dec0;
  assign 	opr0_o_dec0 = opr0_reg_dec0;
  assign 	opr1_o_dec0 = opr1_reg_dec0;
  assign 	mem_wen_o_dec0 = mem_wen_reg_dec0;
  assign 	ins_o_dec0 = ins_reg_dec0;
  

  /***********************************************************/
  /*              PipeLine Register (Dec0/Exe0)                */
  /***********************************************************/

  always @(posedge clk  or  negedge rst) begin
    if (rst == 1'b0) begin
      node_reg_dec0		<= {16{1'b0}};
      gen_reg_dec0 		<= {12{1'b0}};
      opr0_reg_dec0 		<= {32{1'b0}};
      opr1_reg_dec0 		<= {32{1'b0}};
      mem_wen_reg_dec0		<= 1'b0;
      opecode_reg_dec0		<= {7{1'b0}};
      ins_reg_dec0		<= {27{1'b0}};
    end else begin
      node_reg_dec0		<= node_i_dec0;
      gen_reg_dec0 		<= gen_i_dec0;
      opr0_reg_dec0 		<= opr0_i_dec0;
      opr1_reg_dec0 		<= opr1_i_dec0;
      mem_wen_reg_dec0		<= mem_wen_i_dec0;
      if (mem_wen_i_dec0) 
        opecode_reg_dec0	<= 7'b111_0011;
      else 
        opecode_reg_dec0	<= ins_i_dec0[33:27];
      if (!mem_wen_i_dec0) 
        ins_reg_dec0		<= ins_i_dec0[26:0];
      else
        ins_reg_dec0		<= {27{1'b0}};
    end
  end
  
  
  /***********************************************************/
  /*                    INCLUDE Decoder                      */
  /***********************************************************/
   
  Decoder Decoder(
  		//input
		.opecode_i_dcdr		( opecode_reg_dec0 ),

		 //output
		.dopc_o_dcdr		( dopc_o_dec0 )
		
		
		);

  /***********************************************************/
  /*                    INCLUDE Decoder                      */
  /***********************************************************/
   
  InsPGCtrlr InsPGCtrlr(
  		//input
		.opecode_i_ipgc		( opecode_reg_dec0 ),

		//output
		.mul_ins_o_ipgc 	( mul_ins_o_dec0 ),
		.sh_ins_o_ipgc  	( sh_ins_o_dec0 )
		
		
		);

endmodule //Dec0