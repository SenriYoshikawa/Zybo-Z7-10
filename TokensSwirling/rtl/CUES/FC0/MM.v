////////////////////////////////////////////////////////////////////////////////
//
//  (c) Copyright 2010 AIL Co., Ltd.
//      ALL RIGHTS RESERVED
//
//  Filename : MM.v
//  Date     : Wed Jun 16 08:57:20 JST 2010
//
//  $Date: 2010/06/16 23:03:42 $
//  $Revision: 1.2 $
//  $Id: MM.v,v 1.2 2010/06/16 23:03:42 konishi Exp $
//  $Status$
//  
////////////////////////////////////////////////////////////////////////////////
//  Purpose : 
//            
//            
//            
//            
////////////////////////////////////////////////////////////////////////////////

module MM (
		key,
		data0,
		uni_opr_flg,
		mm16,
		pg_mmu0,
		pg_mmu1,
		clk,
		rst,
		mtch_data,
		mtch_rslt,
		mm_full,
		mmu0_mm_full,
		mmu0_mm_empty,
		mmu1_mm_empty,
		next_mmu0_w,
		next_mmu1_w,
		mmu0_next_empty,
		mmu1_next_empty
		);

input  [27:0] key;
input  [31:0] data0;
input         uni_opr_flg;
input         mm16;
input         pg_mmu0;
input         pg_mmu1;
input         clk;
input         rst;
output [31:0] mtch_data;
output        mtch_rslt;
output        mm_full;
output        mmu0_mm_full;
output        mmu0_mm_empty;
output        mmu1_mm_empty;
output        next_mmu0_w;
output        next_mmu1_w;
output        mmu0_next_empty;
output        mmu1_next_empty;

wire [15:0]   mmu0_mmc_valid;
wire [15:0]   mmu1_mmc_valid;
wire [15:0]   mmu0_w_en;
wire [15:0]   mmu1_w_en;

wire [31:0]   mmu0_mtch_data;
wire [31:0]   mmu1_mtch_data;
wire          mmu0_mtch_rslt;
wire          mmu1_mtch_rslt;
wire [15:0]   mmu0_mmc_mtch_rslt;
wire [15:0]   mmu1_mmc_mtch_rslt;

wire [31:0]   mmu0_mtch_data_to_iso;
wire [31:0]   mmu1_mtch_data_to_iso;
wire          mmu0_mtch_rslt_to_iso;
wire          mmu1_mtch_rslt_to_iso;
wire [15:0]   mmu0_mmc_mtch_rslt_to_iso;
wire [15:0]   mmu1_mmc_mtch_rslt_to_iso;

wire [31:0]   iso_mmu0_mtch_data;
wire [31:0]   iso_mmu1_mtch_data;
wire          iso_mmu0_mtch_rslt;
wire          iso_mmu1_mtch_rslt;
wire [15:0]   iso_mmu0_mmc_mtch_rslt;
wire [15:0]   iso_mmu1_mmc_mtch_rslt;


assign        mmu0_mm_full = (&mmu0_mmc_valid);
assign        mm_full = mm16? mmu0_mm_full: mmu0_mm_full&(&mmu1_mmc_valid);

assign        mmu0_mm_empty = ~(|mmu0_mmc_valid);
assign        mmu1_mm_empty = ~(|mmu1_mmc_valid);

MM_Manager uMM_Manager (
			.uni_opr_flg    (uni_opr_flg),
			.mm16           (mm16),
			.clk( clk ),
			.rst( rst ),
			.mmu0_mtch_rslt (mmu0_mtch_rslt),
			.mmu1_mtch_rslt (mmu1_mtch_rslt),
			.mmu0_mmc_mtch_rslt (mmu0_mmc_mtch_rslt),
			.mmu1_mmc_mtch_rslt (mmu1_mmc_mtch_rslt),
			.mmu0_mmc_valid (mmu0_mmc_valid),
			.mmu1_mmc_valid (mmu1_mmc_valid),
			.mmu0_w_en      (mmu0_w_en),
			.mmu1_w_en      (mmu1_w_en),
			.next_mmu0_w     (next_mmu0_w),
			.next_mmu1_w     (next_mmu1_w),
			.mmu0_next_empty (mmu0_next_empty),
			.mmu1_next_empty (mmu1_next_empty),
			.pg_mmu0( pg_mmu0 ),
			.pg_mmu1( pg_mmu1 ));

MM_Unit uMM_Unit0 (	.key( key ),
			.data0( data0 ),
			.mmc_valid( mmu0_mmc_valid ),
			.w_en( mmu0_w_en ),
			.clk( clk ),
			.rst( rst ),
			.mtch_data( mmu0_mtch_data_to_iso ),
			.mtch_rslt( mmu0_mtch_rslt_to_iso ),
			.mmc_mtch_rslt( mmu0_mmc_mtch_rslt_to_iso ));

MM_Unit uMM_Unit1 (	.key( key ),
			.data0( data0 ),
			.mmc_valid( mmu1_mmc_valid ),
			.w_en( mmu1_w_en ),
			.clk( clk ),
			.rst( rst ),
			.mtch_data( mmu1_mtch_data_to_iso ),
			.mtch_rslt( mmu1_mtch_rslt_to_iso ),
			.mmc_mtch_rslt( mmu1_mmc_mtch_rslt_to_iso ));

IsoMMU uIsoMMU (	.mm0_mtch_data( mmu0_mtch_data_to_iso ),
			.mm1_mtch_data( mmu1_mtch_data_to_iso ),
			.mm0_mtch_rslt( mmu0_mtch_rslt_to_iso ),
			.mm1_mtch_rslt( mmu1_mtch_rslt_to_iso ),
			.mm0_mmc_mtch_rslt( mmu0_mmc_mtch_rslt_to_iso ),
			.mm1_mmc_mtch_rslt( mmu1_mmc_mtch_rslt_to_iso ),
			.pg_mmu0( pg_mmu0 ),
			.pg_mmu1( pg_mmu1 ),
			
			.mm0_iso_mtch_data( iso_mmu0_mtch_data ),
			.mm1_iso_mtch_data( iso_mmu1_mtch_data ),
			.mm0_iso_mtch_rslt( iso_mmu0_mtch_rslt ),
			.mm1_iso_mtch_rslt( iso_mmu1_mtch_rslt ),
			.mm0_iso_mmc_mtch_rslt( iso_mmu0_mmc_mtch_rslt ),
			.mm1_iso_mmc_mtch_rslt( iso_mmu1_mmc_mtch_rslt ));

///////////////////////////////////////////////////////////////////////////////

assign        mmu0_mtch_rslt = pg_mmu0_mtch_rslt_sel(
					     pg_mmu0,
					     pg_mmu1,
					     iso_mmu0_mtch_rslt);

function pg_mmu0_mtch_rslt_sel;
  input        pg_mmu0;
  input        pg_mmu1;
  input        iso_mmu0_mtch_rslt;
  case({pg_mmu0,pg_mmu1})
    2'b00:  pg_mmu0_mtch_rslt_sel = 1'b1;
    2'b10:  pg_mmu0_mtch_rslt_sel = iso_mmu0_mtch_rslt;
    2'b11:  pg_mmu0_mtch_rslt_sel = iso_mmu0_mtch_rslt;
    default: pg_mmu0_mtch_rslt_sel = 1'b1;
  endcase
endfunction

assign        mmu1_mtch_rslt = pg_mmu1_mtch_rslt_sel(
					     pg_mmu0,
					     pg_mmu1,
					     iso_mmu1_mtch_rslt);

function pg_mmu1_mtch_rslt_sel;
  input        pg_mmu0;
  input        pg_mmu1;
  input        iso_mmu1_mtch_rslt;
  case({pg_mmu0,pg_mmu1})
    2'b00:  pg_mmu1_mtch_rslt_sel = 1'b1;
    2'b10:  pg_mmu1_mtch_rslt_sel = 1'b0;
    2'b11:  pg_mmu1_mtch_rslt_sel = iso_mmu1_mtch_rslt;
    default: pg_mmu1_mtch_rslt_sel = 1'b1;
  endcase
endfunction

///////////////////////////////////////////////////////////////////////////////

assign        mmu0_mtch_data = pg_mmu0_mtch_data_sel(
					     pg_mmu0,
					     pg_mmu1,
					     iso_mmu0_mtch_data);

function [31:0] pg_mmu0_mtch_data_sel;
  input              pg_mmu0;
  input              pg_mmu1;
  input [31:0]       iso_mmu0_mtch_data;
  casex({pg_mmu0,pg_mmu1})
    2'b00:  pg_mmu0_mtch_data_sel = {32{1'b1}};
    2'b10:  pg_mmu0_mtch_data_sel = iso_mmu0_mtch_data;
    2'b11:  pg_mmu0_mtch_data_sel = iso_mmu0_mtch_data;
    default: pg_mmu0_mtch_data_sel = {32{1'b0}};
  endcase
endfunction

assign        mmu1_mtch_data = pg_mmu1_mtch_data_sel(
					     pg_mmu0,
					     pg_mmu1,
					     iso_mmu1_mtch_data);

function [31:0] pg_mmu1_mtch_data_sel;
  input              pg_mmu0;
  input              pg_mmu1;
  input [31:0]       iso_mmu1_mtch_data;
  casex({pg_mmu0,pg_mmu1})
    2'b00:  pg_mmu1_mtch_data_sel = {32{1'b1}};
    2'b10:  pg_mmu1_mtch_data_sel = {32{1'b0}};
    2'b11:  pg_mmu1_mtch_data_sel = iso_mmu1_mtch_data;
    default: pg_mmu1_mtch_data_sel = {32{1'b0}};
  endcase
endfunction

///////////////////////////////////////////////////////////////////////////////

assign        mmu0_mmc_mtch_rslt = pg_mmu0_mmc_mtch_rslt_sel(
					     pg_mmu0,
					     pg_mmu1,
					     iso_mmu0_mmc_mtch_rslt);

function [15:0] pg_mmu0_mmc_mtch_rslt_sel;
  input              pg_mmu0;
  input              pg_mmu1;
  input [15:0]       iso_mmu0_mmc_mtch_rslt;
  casex({pg_mmu0,pg_mmu1})
    2'b00:  pg_mmu0_mmc_mtch_rslt_sel = {16{1'b1}};
    2'b10:  pg_mmu0_mmc_mtch_rslt_sel = iso_mmu0_mmc_mtch_rslt;
    2'b11:  pg_mmu0_mmc_mtch_rslt_sel = iso_mmu0_mmc_mtch_rslt;
    default: pg_mmu0_mmc_mtch_rslt_sel = {16{1'b0}};
  endcase
endfunction

assign        mmu1_mmc_mtch_rslt = pg_mmu1_mmc_mtch_rslt_sel(
					     pg_mmu0,
					     pg_mmu1,
					     iso_mmu1_mmc_mtch_rslt);

function [15:0] pg_mmu1_mmc_mtch_rslt_sel;
  input              pg_mmu0;
  input              pg_mmu1;
  input [15:0]       iso_mmu1_mmc_mtch_rslt;
  casex({pg_mmu0,pg_mmu1})
    2'b00:  pg_mmu1_mmc_mtch_rslt_sel = {16{1'b1}};
    2'b10:  pg_mmu1_mmc_mtch_rslt_sel = {16{1'b0}};
    2'b11:  pg_mmu1_mmc_mtch_rslt_sel = iso_mmu1_mmc_mtch_rslt;
    default: pg_mmu1_mmc_mtch_rslt_sel = {16{1'b0}};
  endcase
endfunction

///////////////////////////////////////////////////////////////////////////////

assign        mtch_rslt = (mmu0_mtch_rslt & pg_mmu0) | (mmu1_mtch_rslt & pg_mmu1);
assign        mtch_data = selected_rslt_data(uni_opr_flg,
					     mmu0_mtch_rslt,
					     (mmu1_mtch_rslt & pg_mmu1),
					     mmu0_mtch_data,
					     mmu1_mtch_data );

function[31:0] selected_rslt_data;
  input        uni_opr_flg;
  input        mmu0_mtch_rslt;
  input        mmu1_mtch_rslt;
  input [31:0] mmu0_mtch_data;
  input [31:0] mmu1_mtch_data;
  casex({uni_opr_flg,mmu1_mtch_rslt,mmu0_mtch_rslt})
    3'b001:  selected_rslt_data = mmu0_mtch_data;
    3'b010:  selected_rslt_data = mmu1_mtch_data;
    default: selected_rslt_data = {32{1'b0}};
  endcase
endfunction

endmodule
