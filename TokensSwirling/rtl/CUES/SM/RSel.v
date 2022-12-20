module RSel(
  node_pkta_i_rsel,
  gen_pkta_i_rsel,
  opr0_pkta_i_rsel,
  opr1_pkta_i_rsel,
  mem_wen_pkta_i_rsel,
  node_pktb_i_rsel,
  gen_pktb_i_rsel,
  opr0_pktb_i_rsel,
  opr1_pktb_i_rsel,
  mem_wen_pktb_i_rsel,
  aeb_i_rsel,


  node_o_rsel,
  gen_o_rsel,
  opr0_o_rsel,
  opr1_o_rsel,
  mem_wen_o_rsel
  
  );
  
  
  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  input [15:0]  node_pkta_i_rsel;
  input [11:0]  gen_pkta_i_rsel;
  input [31:0]  opr0_pkta_i_rsel;
  input [31:0]  opr1_pkta_i_rsel;
  input [1:0]   mem_wen_pkta_i_rsel;
  input [15:0]  node_pktb_i_rsel;
  input [11:0]  gen_pktb_i_rsel;
  input [31:0]  opr0_pktb_i_rsel;
  input [31:0]  opr1_pktb_i_rsel;
  input [1:0]   mem_wen_pktb_i_rsel;
  input         aeb_i_rsel;


  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  output [15:0]	node_o_rsel;
  output [11:0]	gen_o_rsel;
  output [31:0]	opr0_o_rsel;
  output [31:0]	opr1_o_rsel;
  output [1:0]	mem_wen_o_rsel;
  
  
  /***********************************************************/
  /*                        OUT                              */ 
  /***********************************************************/

  assign 	node_o_rsel = aeb_i_rsel? node_pktb_i_rsel: node_pkta_i_rsel;
  assign 	gen_o_rsel = aeb_i_rsel? gen_pktb_i_rsel: gen_pkta_i_rsel;
  assign 	opr0_o_rsel = aeb_i_rsel? opr0_pktb_i_rsel: opr0_pkta_i_rsel;
  assign 	opr1_o_rsel = aeb_i_rsel? opr1_pktb_i_rsel: opr1_pkta_i_rsel;
  assign 	mem_wen_o_rsel = aeb_i_rsel? mem_wen_pktb_i_rsel: mem_wen_pkta_i_rsel;


endmodule // RSel
