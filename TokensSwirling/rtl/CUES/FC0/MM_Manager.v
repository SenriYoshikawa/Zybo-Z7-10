////////////////////////////////////////////////////////////////////////////////
//
//  (c) Copyright 2010 AIL Co., Ltd.
//      ALL RIGHTS RESERVED
//
//  Filename : MM_Manager.v
//  Date     : Wed Jun 16 08:57:35 JST 2010
//
//  $Date: 2010/06/16 07:49:02 $
//  $Revision: 1.1 $
//  $Id: MM_Manager.v,v 1.1 2010/06/16 07:49:02 konishi Exp $
//  $Status$
//  
////////////////////////////////////////////////////////////////////////////////
//  Purpose : 
//            
//            
//            
//            
////////////////////////////////////////////////////////////////////////////////

module MM_Manager (
		   uni_opr_flg,
		   mm16,
		   clk,
		   rst,
		   mmu0_mtch_rslt,
		   mmu1_mtch_rslt,
		   mmu0_mmc_mtch_rslt,
		   mmu1_mmc_mtch_rslt,
		   mmu0_mmc_valid,
		   mmu1_mmc_valid,
                   mmu0_w_en,
                   mmu1_w_en,
                   next_mmu0_w,
                   next_mmu1_w,
                   mmu0_next_empty,
                   mmu1_next_empty,
                   pg_mmu0,
                   pg_mmu1);

input         uni_opr_flg;
input         mm16;
input         clk;
input         rst;
input         mmu0_mtch_rslt;
input         mmu1_mtch_rslt;
input  [15:0] mmu0_mmc_mtch_rslt;
input  [15:0] mmu1_mmc_mtch_rslt;
input         pg_mmu0;
input         pg_mmu1;
output [15:0] mmu0_mmc_valid;
output [15:0] mmu1_mmc_valid;
output [15:0] mmu0_w_en;
output [15:0] mmu1_w_en;
output        next_mmu0_w;
output        next_mmu1_w;
output        mmu0_next_empty;
output        mmu1_next_empty;

reg    [15:0] mmu0_mmc_valid;
reg    [15:0] mmu1_mmc_valid;

reg           first_clk;
wire   [15:0] mmu0_w_en;
wire   [15:0] mmu1_w_en;
wire          next_w;
reg           mmu0_last_pkt;
reg           mmu1_last_pkt;
assign        mmu0_next_empty = mmu0_last_pkt & mmu0_mtch_rslt;
assign        mmu1_next_empty = mmu1_last_pkt & mmu1_mtch_rslt;
reg    [31:0] w_en;
assign        mmu0_w_en = w_en[15:0];
assign        mmu1_w_en = w_en[31:16];
assign        next_mmu0_w = |mmu0_w_en;
assign        next_mmu1_w = |mmu1_w_en;

always @ (*) begin
  w_en = {32{1'b0}};
  if (uni_opr_flg | mmu0_mtch_rslt | (mmu1_mtch_rslt & pg_mmu1) | ~first_clk) begin
    w_en = {32{1'b0}};
  end
  else begin
    if      (mmu0_mmc_valid[0]  == 1'b0) w_en[0]  = 1'b1;
    else if (mmu0_mmc_valid[1]  == 1'b0) w_en[1]  = 1'b1;
    else if (mmu0_mmc_valid[2]  == 1'b0) w_en[2]  = 1'b1;
    else if (mmu0_mmc_valid[3]  == 1'b0) w_en[3]  = 1'b1;
    else if (mmu0_mmc_valid[4]  == 1'b0) w_en[4]  = 1'b1;
    else if (mmu0_mmc_valid[5]  == 1'b0) w_en[5]  = 1'b1;
    else if (mmu0_mmc_valid[6]  == 1'b0) w_en[6]  = 1'b1;
    else if (mmu0_mmc_valid[7]  == 1'b0) w_en[7]  = 1'b1;
    else if (mmu0_mmc_valid[8]  == 1'b0) w_en[8]  = 1'b1;
    else if (mmu0_mmc_valid[9]  == 1'b0) w_en[9]  = 1'b1;
    else if (mmu0_mmc_valid[10] == 1'b0) w_en[10] = 1'b1;
    else if (mmu0_mmc_valid[11] == 1'b0) w_en[11] = 1'b1;
    else if (mmu0_mmc_valid[12] == 1'b0) w_en[12] = 1'b1;
    else if (mmu0_mmc_valid[13] == 1'b0) w_en[13] = 1'b1;
    else if (mmu0_mmc_valid[14] == 1'b0) w_en[14] = 1'b1;
    else if (mmu0_mmc_valid[15] == 1'b0) w_en[15] = 1'b1;
    else if (mmu1_mmc_valid[0]  == 1'b0) w_en[16] = ~mm16 & pg_mmu1;
    else if (mmu1_mmc_valid[1]  == 1'b0) w_en[17] = ~mm16 & pg_mmu1;
    else if (mmu1_mmc_valid[2]  == 1'b0) w_en[18] = ~mm16 & pg_mmu1;
    else if (mmu1_mmc_valid[3]  == 1'b0) w_en[19] = ~mm16 & pg_mmu1;
    else if (mmu1_mmc_valid[4]  == 1'b0) w_en[20] = ~mm16 & pg_mmu1;
    else if (mmu1_mmc_valid[5]  == 1'b0) w_en[21] = ~mm16 & pg_mmu1;
    else if (mmu1_mmc_valid[6]  == 1'b0) w_en[22] = ~mm16 & pg_mmu1;
    else if (mmu1_mmc_valid[7]  == 1'b0) w_en[23] = ~mm16 & pg_mmu1;
    else if (mmu1_mmc_valid[8]  == 1'b0) w_en[24] = ~mm16 & pg_mmu1;
    else if (mmu1_mmc_valid[9]  == 1'b0) w_en[25] = ~mm16 & pg_mmu1;
    else if (mmu1_mmc_valid[10] == 1'b0) w_en[26] = ~mm16 & pg_mmu1;
    else if (mmu1_mmc_valid[11] == 1'b0) w_en[27] = ~mm16 & pg_mmu1;
    else if (mmu1_mmc_valid[12] == 1'b0) w_en[28] = ~mm16 & pg_mmu1;
    else if (mmu1_mmc_valid[13] == 1'b0) w_en[29] = ~mm16 & pg_mmu1;
    else if (mmu1_mmc_valid[14] == 1'b0) w_en[30] = ~mm16 & pg_mmu1;
    else if (mmu1_mmc_valid[15] == 1'b0) w_en[31] = ~mm16 & pg_mmu1;
    else                                 w_en     = {32{1'b0}};
  end
end

always @ (*) begin
  case (mmu0_mmc_valid)
    16'h8000 : mmu0_last_pkt = 1'b1;
    16'h4000 : mmu0_last_pkt = 1'b1;
    16'h2000 : mmu0_last_pkt = 1'b1;
    16'h1000 : mmu0_last_pkt = 1'b1;
    16'h0800 : mmu0_last_pkt = 1'b1;
    16'h0400 : mmu0_last_pkt = 1'b1;
    16'h0200 : mmu0_last_pkt = 1'b1;
    16'h0100 : mmu0_last_pkt = 1'b1;
    16'h0080 : mmu0_last_pkt = 1'b1;
    16'h0040 : mmu0_last_pkt = 1'b1;
    16'h0020 : mmu0_last_pkt = 1'b1;
    16'h0010 : mmu0_last_pkt = 1'b1;
    16'h0008 : mmu0_last_pkt = 1'b1;
    16'h0004 : mmu0_last_pkt = 1'b1;
    16'h0002 : mmu0_last_pkt = 1'b1;
    16'h0001 : mmu0_last_pkt = 1'b1;
    default  : mmu0_last_pkt = 1'b0;
  endcase
end

always @ (*) begin
  case (mmu1_mmc_valid)
    16'h8000 : mmu1_last_pkt = 1'b1;
    16'h4000 : mmu1_last_pkt = 1'b1;
    16'h2000 : mmu1_last_pkt = 1'b1;
    16'h1000 : mmu1_last_pkt = 1'b1;
    16'h0800 : mmu1_last_pkt = 1'b1;
    16'h0400 : mmu1_last_pkt = 1'b1;
    16'h0200 : mmu1_last_pkt = 1'b1;
    16'h0100 : mmu1_last_pkt = 1'b1;
    16'h0080 : mmu1_last_pkt = 1'b1;
    16'h0040 : mmu1_last_pkt = 1'b1;
    16'h0020 : mmu1_last_pkt = 1'b1;
    16'h0010 : mmu1_last_pkt = 1'b1;
    16'h0008 : mmu1_last_pkt = 1'b1;
    16'h0004 : mmu1_last_pkt = 1'b1;
    16'h0002 : mmu1_last_pkt = 1'b1;
    16'h0001 : mmu1_last_pkt = 1'b1;
    default  : mmu1_last_pkt = 1'b0;
  endcase
end

always @ (posedge clk or negedge rst) begin
  if (~rst) begin
    mmu0_mmc_valid <= {16{1'b0}};
    mmu1_mmc_valid <= {16{1'b0}};
    first_clk      <= 1'b0;
  end
  else if (~first_clk) begin
    first_clk      <= 1'b1;
  end
  else if ((mmu0_mtch_rslt | mmu1_mtch_rslt) & ~uni_opr_flg) begin
    if (mmu0_mmc_mtch_rslt[0])  mmu0_mmc_valid[0]   <= 1'b0;
    if (mmu0_mmc_mtch_rslt[1])  mmu0_mmc_valid[1]   <= 1'b0;
    if (mmu0_mmc_mtch_rslt[2])  mmu0_mmc_valid[2]   <= 1'b0;
    if (mmu0_mmc_mtch_rslt[3])  mmu0_mmc_valid[3]   <= 1'b0;
    if (mmu0_mmc_mtch_rslt[4])  mmu0_mmc_valid[4]   <= 1'b0;
    if (mmu0_mmc_mtch_rslt[5])  mmu0_mmc_valid[5]   <= 1'b0;
    if (mmu0_mmc_mtch_rslt[6])  mmu0_mmc_valid[6]   <= 1'b0;
    if (mmu0_mmc_mtch_rslt[7])  mmu0_mmc_valid[7]   <= 1'b0;
    if (mmu0_mmc_mtch_rslt[8])  mmu0_mmc_valid[8]   <= 1'b0;
    if (mmu0_mmc_mtch_rslt[9])  mmu0_mmc_valid[9]   <= 1'b0;
    if (mmu0_mmc_mtch_rslt[10]) mmu0_mmc_valid[10]  <= 1'b0;
    if (mmu0_mmc_mtch_rslt[11]) mmu0_mmc_valid[11]  <= 1'b0;
    if (mmu0_mmc_mtch_rslt[12]) mmu0_mmc_valid[12]  <= 1'b0;
    if (mmu0_mmc_mtch_rslt[13]) mmu0_mmc_valid[13]  <= 1'b0;
    if (mmu0_mmc_mtch_rslt[14]) mmu0_mmc_valid[14]  <= 1'b0;
    if (mmu0_mmc_mtch_rslt[15]) mmu0_mmc_valid[15]  <= 1'b0;
    if (~pg_mmu1) begin
      mmu1_mmc_valid <= {16{1'b0}};
    end
    else begin
      if (mmu1_mmc_mtch_rslt[0])  mmu1_mmc_valid[0]   <= 1'b0;
      if (mmu1_mmc_mtch_rslt[1])  mmu1_mmc_valid[1]   <= 1'b0;
      if (mmu1_mmc_mtch_rslt[2])  mmu1_mmc_valid[2]   <= 1'b0;
      if (mmu1_mmc_mtch_rslt[3])  mmu1_mmc_valid[3]   <= 1'b0;
      if (mmu1_mmc_mtch_rslt[4])  mmu1_mmc_valid[4]   <= 1'b0;
      if (mmu1_mmc_mtch_rslt[5])  mmu1_mmc_valid[5]   <= 1'b0;
      if (mmu1_mmc_mtch_rslt[6])  mmu1_mmc_valid[6]   <= 1'b0;
      if (mmu1_mmc_mtch_rslt[7])  mmu1_mmc_valid[7]   <= 1'b0;
      if (mmu1_mmc_mtch_rslt[8])  mmu1_mmc_valid[8]   <= 1'b0;
      if (mmu1_mmc_mtch_rslt[9])  mmu1_mmc_valid[9]   <= 1'b0;
      if (mmu1_mmc_mtch_rslt[10]) mmu1_mmc_valid[10]  <= 1'b0;
      if (mmu1_mmc_mtch_rslt[11]) mmu1_mmc_valid[11]  <= 1'b0;
      if (mmu1_mmc_mtch_rslt[12]) mmu1_mmc_valid[12]  <= 1'b0;
      if (mmu1_mmc_mtch_rslt[13]) mmu1_mmc_valid[13]  <= 1'b0;
      if (mmu1_mmc_mtch_rslt[14]) mmu1_mmc_valid[14]  <= 1'b0;
      if (mmu1_mmc_mtch_rslt[15]) mmu1_mmc_valid[15]  <= 1'b0;
    end
  end
  else if (next_mmu0_w | next_mmu1_w) begin
    if (mmu0_w_en[0])  mmu0_mmc_valid[0]   <= 1'b1;
    if (mmu0_w_en[1])  mmu0_mmc_valid[1]   <= 1'b1;
    if (mmu0_w_en[2])  mmu0_mmc_valid[2]   <= 1'b1;
    if (mmu0_w_en[3])  mmu0_mmc_valid[3]   <= 1'b1;
    if (mmu0_w_en[4])  mmu0_mmc_valid[4]   <= 1'b1;
    if (mmu0_w_en[5])  mmu0_mmc_valid[5]   <= 1'b1;
    if (mmu0_w_en[6])  mmu0_mmc_valid[6]   <= 1'b1;
    if (mmu0_w_en[7])  mmu0_mmc_valid[7]   <= 1'b1;
    if (mmu0_w_en[8])  mmu0_mmc_valid[8]   <= 1'b1;
    if (mmu0_w_en[9])  mmu0_mmc_valid[9]   <= 1'b1;
    if (mmu0_w_en[10]) mmu0_mmc_valid[10]  <= 1'b1;
    if (mmu0_w_en[11]) mmu0_mmc_valid[11]  <= 1'b1;
    if (mmu0_w_en[12]) mmu0_mmc_valid[12]  <= 1'b1;
    if (mmu0_w_en[13]) mmu0_mmc_valid[13]  <= 1'b1;
    if (mmu0_w_en[14]) mmu0_mmc_valid[14]  <= 1'b1;
    if (mmu0_w_en[15]) mmu0_mmc_valid[15]  <= 1'b1;
    if (mmu1_w_en[0])  mmu1_mmc_valid[0]   <= ~mm16;
    if (mmu1_w_en[1])  mmu1_mmc_valid[1]   <= ~mm16;
    if (mmu1_w_en[2])  mmu1_mmc_valid[2]   <= ~mm16;
    if (mmu1_w_en[3])  mmu1_mmc_valid[3]   <= ~mm16;
    if (mmu1_w_en[4])  mmu1_mmc_valid[4]   <= ~mm16;
    if (mmu1_w_en[5])  mmu1_mmc_valid[5]   <= ~mm16;
    if (mmu1_w_en[6])  mmu1_mmc_valid[6]   <= ~mm16;
    if (mmu1_w_en[7])  mmu1_mmc_valid[7]   <= ~mm16;
    if (mmu1_w_en[8])  mmu1_mmc_valid[8]   <= ~mm16;
    if (mmu1_w_en[9])  mmu1_mmc_valid[9]   <= ~mm16;
    if (mmu1_w_en[10]) mmu1_mmc_valid[10]  <= ~mm16;
    if (mmu1_w_en[11]) mmu1_mmc_valid[11]  <= ~mm16;
    if (mmu1_w_en[12]) mmu1_mmc_valid[12]  <= ~mm16;
    if (mmu1_w_en[13]) mmu1_mmc_valid[13]  <= ~mm16;
    if (mmu1_w_en[14]) mmu1_mmc_valid[14]  <= ~mm16;
    if (mmu1_w_en[15]) mmu1_mmc_valid[15]  <= ~mm16;
  end
end

endmodule
