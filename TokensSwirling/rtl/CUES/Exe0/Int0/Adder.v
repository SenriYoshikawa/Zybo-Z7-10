(* use_dsp48 = "yes" *) module Adder( 
  opr0_i_add, 
  opr1_i_add,
  imm16_i_add,
  gen_i_add,
  tag_i_add,
  sub_i_add,
  sat_i_add,
  r_sel_i_add,
  imm_sel_i_add,
  rslt_sel_i_add,
  jump_i_add,
  
  rslt_o_add,
  rslt_cc_o_add,
  rslt_tag_o_add
  );
  

  //********************************
  input [31:0]	opr0_i_add;
  input [31:0]	opr1_i_add;
  input [15:0]	imm16_i_add;
  input [11:0]	gen_i_add;
  input		tag_i_add;
  input 	sub_i_add;
  input 	sat_i_add; // saturation
  input 	r_sel_i_add; // 0:oprR/1:imm
  input		imm_sel_i_add;// 0:imm5/1:imm16_i_add
  input 	rslt_sel_i_add; // rslt/oprL
  input 	jump_i_add;
  
  output reg [31:0]	rslt_o_add;
  output [1:0]	rslt_cc_o_add;
  output [11:0]	rslt_tag_o_add;
  //********************************

  wire [31:0]	selected_opra;
  wire [31:0]	selected_oprb;
  wire [31:0]	imm_opr;
  wire [31:0]	tmp_oprb;
  wire [32:0]	rslt_tmp0;
  wire [32:0]	rslt_tmp1;
  wire [32:0]	rslt_tmp2;
  wire [11:0]	rslt_tag_tmp0;
  wire 		abs;
  wire [31:0]	abs_tmp;
  wire 		overflow_n;
  wire 		overflow_tag;
  wire 		zero_n;
  wire 		zero_tag_ts;
  wire 		zero_tag_oth;
  wire 		zero_tag;
  

  always@* begin
    if(~tag_i_add & ~sub_i_add & ~r_sel_i_add & ~rslt_sel_i_add & jump_i_add) begin
      if(sat_i_add & opr0_i_add + opr1_i_add > 32'h7ffffff) begin
        rslt_o_add <= 32'h7ffffff; // ADDS
      end else begin
        rslt_o_add = opr0_i_add + opr1_i_add; // ADD
      end
    end else if(~tag_i_add & sub_i_add & ~r_sel_i_add & ~rslt_sel_i_add & jump_i_add) begin
      if(sat_i_add & opr0_i_add - opr1_i_add > 32'h7ffffff) begin
        rslt_o_add <= 32'h7ffffff; // SUBS
      end else begin
        rslt_o_add <= opr0_i_add - opr1_i_add; // SUB
      end
    end else if(~tag_i_add & ~sub_i_add & ~sat_i_add & r_sel_i_add & imm_sel_i_add & ~rslt_sel_i_add & jump_i_add) begin
      rslt_o_add <= opr0_i_add + {27'b0, imm16_i_add[4:0]}; // ADDI
    end else if(~tag_i_add & sub_i_add & ~sat_i_add & r_sel_i_add & imm_sel_i_add & ~rslt_sel_i_add & jump_i_add) begin
      rslt_o_add <= opr0_i_add - {27'b0, imm16_i_add[4:0]}; // SUBI
    end else if(~tag_i_add & ~sub_i_add & ~sat_i_add & r_sel_i_add & ~imm_sel_i_add & ~rslt_sel_i_add & ~jump_i_add) begin
      rslt_o_add <= opr0_i_add + {17{imm16_i_add[15], imm16_i_add[14:0]}}; // ADDLI
    end else if(~tag_i_add & ~sub_i_add & ~sat_i_add & r_sel_i_add & ~imm_sel_i_add & ~rslt_sel_i_add & ~jump_i_add) begin
      rslt_o_add <= opr0_i_add - {17{imm16_i_add[15], imm16_i_add[14:0]}}; // SUBLI
    end else if(~tag_i_add & ~sub_i_add & sat_i_add & r_sel_i_add & ~imm_sel_i_add & ~rslt_sel_i_add & ~jump_i_add) begin
      if(opr0_i_add + {17{imm16_i_add[15], imm16_i_add[14:0]}} > 32'h7ffffff) begin
        rslt_o_add <= 32'h7ffffff; //ADDSLI
      end else begin
        rslt_o_add <= opr0_i_add + {17{imm16_i_add[15], imm16_i_add[14:0]}}; //ADDSLI
      end
    end else if(~tag_i_add & sub_i_add & sat_i_add & r_sel_i_add & ~imm_sel_i_add & ~rslt_sel_i_add & ~jump_i_add) begin
      if(opr0_i_add - {17{imm16_i_add[15], imm16_i_add[14:0]}} > 32'h7ffffff) begin
        rslt_o_add <= 32'h7ffffff; // SUBSLI
      end else begin
        rslt_o_add <= opr0_i_add - {17{imm16_i_add[15], imm16_i_add[14:0]}}; // SUBSLI
      end
    end else if(tag_i_add & ~sub_i_add & ~rslt_sel_i_add & ~jump_i_add) begin
      if(opr0_i_add[31] == 0) begin
        rslt_o_add <= opr0_i_add; // ABS
      end else begin
        rslt_o_add <= ~opr0_i_add + 1'b1; // ABS
      end
    end else begin
      rslt_o_add <= opr0_i_add;
    end
  end

  assign 	abs = tag_i_add & ~rslt_sel_i_add & ~jump_i_add;
  assign 	abs_tmp = opr0_i_add[31]? ~(opr0_i_add + {32{1'b1}}): opr0_i_add;
  
  assign	selected_opra = tag_i_add? {20'b0, gen_i_add}: opr0_i_add;
  assign 	imm_opr = imm_sel_i_add? {27'b0, imm16_i_add[4:0]}:
  				   {{17{imm16_i_add[15]}}, imm16_i_add[14:0]};
  assign 	tmp_oprb = r_sel_i_add? imm_opr: opr1_i_add;
  assign 	selected_oprb = sub_i_add? ~tmp_oprb: tmp_oprb;
  
  assign	rslt_tmp0 = selected_opra + selected_oprb + sub_i_add;
  
  assign	overflow_n =  rslt_tmp0[31]
  			    & (  (~selected_opra[31] & ~tmp_oprb[31] & ~sub_i_add)
  			       | (~selected_opra[31] & tmp_oprb[31] & sub_i_add));
  
  assign	rslt_tmp1 = (overflow_n & sat_i_add & ~tag_i_add)?
  						 {1'b0,{31{1'b1}}}: rslt_tmp0;
  assign	rslt_tmp2 = (abs)? {1'b0,abs_tmp[30:0]}: rslt_tmp1;
  
  // assign	rslt_o_add = rslt_sel_i_add? opr0_i_add: rslt_tmp2[31:0]; 
  
  assign 	zero_n =   (~|rslt_tmp1[31:0])
  			 & ~overflow_n
			 & ~(selected_opra[31] & tmp_oprb[31] & ~sub_i_add);

  
  assign	overflow_tag = (|rslt_tmp2[32:12]) & ~sub_i_add;
  						   
  assign 	zero_tag_ts = (~|tmp_oprb[4:0]);
  assign 	zero_tag_oth = (~|rslt_tmp1[11:0]) & ~overflow_tag;
  assign 	zero_tag = (tag_i_add & ~sub_i_add & sat_i_add)? zero_tag_ts:
  								 zero_tag_oth;
                               
  assign	rslt_cc_o_add = tag_i_add? {overflow_tag, zero_tag}:
  					   {overflow_n, zero_n};
  assign	rslt_tag_tmp0 = rslt_tag_selector(
  					{sat_i_add,sub_i_add} | {2{~tag_i_add}},
  					selected_oprb[11:0],
  					gen_i_add,
  					rslt_tmp2[11:0]
  					);
  
  function[11:0] rslt_tag_selector;
    input [1:0]		sel_tag;
    input [11:0] 	selected_oprb;
    input [11:0]	gen_i_add;	
    input [11:0]	rslt_tmp;
    casex(sel_tag)//sysnopsys parallel_case
      2'b0x: rslt_tag_selector = rslt_tmp;
      2'b10: rslt_tag_selector = selected_oprb;
      2'b11: rslt_tag_selector = gen_i_add;
    endcase // case(opr1_i_add)
  endfunction // rslt_tag_selector
  
  assign	rslt_tag_o_add = abs? gen_i_add: rslt_tag_tmp0;
  
  
endmodule // Adder
