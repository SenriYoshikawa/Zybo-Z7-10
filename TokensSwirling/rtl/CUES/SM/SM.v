module SM
  (//Input:  name_i_modulename
   //Output: name_o_modulename

  //from SB
  node_sb_i_sm,        //IN
  gen_sb_i_sm,
  opr_sb_i_sm,
  mem_wen_sb_i_sm,
  
  //from FC1
  node_fc1_i_sm,
  gen_fc1_i_sm,
  opr0_fc1_i_sm,
  opr1_fc1_i_sm,
  mem_wen_fc1_i_sm,
  
  rst,
  clka,
  clkb,
  aeb_cm_sm,


  //to Ftc0
  node_o_sm,        //OUT
  gen_o_sm,
  opr0_o_sm,
  opr1_o_sm,
  mem_wen_o_sm
  );


  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  //from SB
  input [15:0]  node_sb_i_sm;
  input [11:0]  gen_sb_i_sm;
  input [31:0]  opr_sb_i_sm;
  input [1:0]  mem_wen_sb_i_sm;
  //from FC1
  input [15:0]  node_fc1_i_sm;
  input [11:0]  gen_fc1_i_sm;
  input [31:0]  opr0_fc1_i_sm;
  input [31:0]  opr1_fc1_i_sm;
  input [1:0]  mem_wen_fc1_i_sm;

  input   rst;
  input   clka;
  input   clkb;
  input   aeb_cm_sm;


  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  //to Ftc0
  output [15:0] node_o_sm;
  output [11:0] gen_o_sm;
  output [31:0] opr0_o_sm;
  output [31:0] opr1_o_sm;
  output [1:0]  mem_wen_o_sm;


  /***********************************************************/
  /*                 DEFINITION OF REGISTER                  */
  /***********************************************************/

  //Pipeline Register at SM/Ftc0
  reg [15:0]   node_sb_reg_sm;
  reg [11:0]   gen_sb_reg_sm;
  reg [31:0]   opr0_sb_reg_sm;
  reg [31:0]   opr1_sb_reg_sm;
  reg [1:0]   mem_wen_sb_reg_sm;
  
  reg [15:0]   node_fc1_reg_sm;
  reg [11:0]   gen_fc1_reg_sm;
  reg [31:0]   opr0_fc1_reg_sm;
  reg [31:0]   opr1_fc1_reg_sm;
  reg [1:0]   mem_wen_fc1_reg_sm;


  /***********************************************************/
  /*              PipeLine Register (SM/Ftc0)                */
  /***********************************************************/

  always @(posedge clka  or  negedge rst) begin
    if (rst == 1'b0) begin
   node_sb_reg_sm    <= {16{1'b0}};
   gen_sb_reg_sm     <= {12{1'b0}};
   opr0_sb_reg_sm   <= {32{1'b0}};
   opr1_sb_reg_sm   <= {32{1'b0}};
   mem_wen_sb_reg_sm  <= {2{1'b0}};
    end else begin
   node_sb_reg_sm    <= node_sb_i_sm;
   gen_sb_reg_sm     <= gen_sb_i_sm;
   opr0_sb_reg_sm   <= opr_sb_i_sm;
   mem_wen_sb_reg_sm  <= mem_wen_sb_i_sm;
    end
  end
  
  always @(posedge clkb  or  negedge rst) begin
    if (rst == 1'b0) begin
   node_fc1_reg_sm  <= {16{1'b0}};
   gen_fc1_reg_sm   <= {12{1'b0}};
   opr0_fc1_reg_sm   <= {32{1'b0}};
   opr1_fc1_reg_sm   <= {32{1'b0}};
   mem_wen_fc1_reg_sm  <= {2{1'b0}};
    end else begin
   node_fc1_reg_sm  <= node_fc1_i_sm;
   gen_fc1_reg_sm   <= gen_fc1_i_sm;
   opr0_fc1_reg_sm   <= opr0_fc1_i_sm;
   opr1_fc1_reg_sm   <= opr1_fc1_i_sm;
   mem_wen_fc1_reg_sm  <= mem_wen_fc1_i_sm;
    end
  end

  
  /***********************************************************/
  /*                       INCLUDE MUX                       */
  /***********************************************************/
  
  RSel RSel(
       //input
     .node_pkta_i_rsel( node_sb_reg_sm ),
     .gen_pkta_i_rsel( gen_sb_reg_sm ),
     .opr0_pkta_i_rsel( opr0_sb_reg_sm ),
     .opr1_pkta_i_rsel( opr1_sb_reg_sm ),
     .mem_wen_pkta_i_rsel( mem_wen_sb_reg_sm ),
     .node_pktb_i_rsel( node_fc1_reg_sm ),
     .gen_pktb_i_rsel( gen_fc1_reg_sm ),
     .opr0_pktb_i_rsel( opr0_fc1_reg_sm ),
     .opr1_pktb_i_rsel( opr1_fc1_reg_sm ),
     .mem_wen_pktb_i_rsel( mem_wen_fc1_reg_sm ),
     .aeb_i_rsel( aeb_cm_sm ),

     //output
     .node_o_rsel( node_o_sm ),
     .gen_o_rsel( gen_o_sm ),
     .opr0_o_rsel( opr0_o_sm ),
     .opr1_o_rsel( opr1_o_sm ),
     .mem_wen_o_rsel( mem_wen_o_sm )
     );


endmodule //SM
