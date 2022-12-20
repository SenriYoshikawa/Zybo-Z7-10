module InsPGCtrlr
 (//Input:  name_i_modulename
  //Output: name_o_modulename

  opecode_i_ipgc,					//IN
    
  mul_ins_o_ipgc,				//OUT
  sh_ins_o_ipgc	

  );


  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  //from Ftc0
  input	[6:0]	opecode_i_ipgc;


  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  //to Exe0
  output 	mul_ins_o_ipgc;
  output 	sh_ins_o_ipgc;
  


  /***********************************************************/
  /*                        OUT                              */ 
  /***********************************************************/

  wire 		sh_ins_tmp0;
  wire 		sh_ins_tmp1;
  wire 		sh_ins_tmp2;
  assign 	sh_ins_tmp0 =   ~opecode_i_ipgc[5]
  			      & opecode_i_ipgc[4]
  			      & ~opecode_i_ipgc[3]
  			      & sh_pg_gen( opecode_i_ipgc[2:0] );
  
  function sh_pg_gen;
    input [2:0]  opecode;
    casex(opecode)//sysnopsys parallel_case
	3'b0xx: sh_pg_gen = 1'b1;
	3'b100: sh_pg_gen = 1'b1;
	default: sh_pg_gen = 1'b0;
    endcase // casex()
  endfunction 

  assign 	sh_ins_tmp1 = (opecode_i_ipgc[6:1] == 6'b100110)? 1'b1: 1'b0;
  assign 	sh_ins_tmp2 = (opecode_i_ipgc[6:1] == 6'b101011)? 1'b1: 1'b0;
  assign 	sh_ins_o_ipgc = sh_ins_tmp0 | sh_ins_tmp1 | sh_ins_tmp2;


  wire 		mul_ins_tmp0;
  wire 		mul_ins_tmp1;
  wire 		mul_ins_tmp2;
  assign 	mul_ins_tmp0 = (opecode_i_ipgc[4:0] == 5'b00010)?
  			       ~(~opecode_i_ipgc[6] & opecode_i_ipgc[5]): 1'b0;
  assign 	mul_ins_tmp1 = (opecode_i_ipgc[5:0] == 6'b011010)? 1'b1: 1'b0;
  assign 	mul_ins_tmp2 = (opecode_i_ipgc[4:0] == 5'b00110)?
  				~(opecode_i_ipgc[6]^opecode_i_ipgc[5]): 1'b0;
  assign 	mul_ins_o_ipgc =   mul_ins_tmp0
  				 | mul_ins_tmp1
  				 | mul_ins_tmp2;





endmodule //InsPGCtrlr