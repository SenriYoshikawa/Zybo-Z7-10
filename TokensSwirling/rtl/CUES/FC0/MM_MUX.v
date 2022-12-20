////////////////////////////////////////////////////////////////////////////////
//
//  (c) Copyright 2010 AIL Co., Ltd.
//      ALL RIGHTS RESERVED
//
//  Filename : MM_MUX.v
//  Date     : Wed Jun 16 08:57:30 JST 2010
//
//  $Date: 2010/06/16 07:49:02 $
//  $Revision: 1.1 $
//  $Id: MM_MUX.v,v 1.1 2010/06/16 07:49:02 konishi Exp $
//  $Status$
//  
////////////////////////////////////////////////////////////////////////////////
//  Purpose : 
//            
//            
//            
//            
////////////////////////////////////////////////////////////////////////////////

module MM_MUX ( 	   mmc_data15,
			   mmc_data14,
			   mmc_data13,
			   mmc_data12,
			   mmc_data11,
			   mmc_data10,
			   mmc_data9,
			   mmc_data8,
			   mmc_data7,
			   mmc_data6,
			   mmc_data5,
			   mmc_data4,
			   mmc_data3,
			   mmc_data2,
			   mmc_data1,
			   mmc_data0,
	           mmc_mtch_rslt15,
	           mmc_mtch_rslt14,
	           mmc_mtch_rslt13,
	           mmc_mtch_rslt12,
	           mmc_mtch_rslt11,
	           mmc_mtch_rslt10,
	           mmc_mtch_rslt9,
	           mmc_mtch_rslt8,
	           mmc_mtch_rslt7,
	           mmc_mtch_rslt6,
	           mmc_mtch_rslt5,
	           mmc_mtch_rslt4,
	           mmc_mtch_rslt3,
	           mmc_mtch_rslt2,
	           mmc_mtch_rslt1,
	           mmc_mtch_rslt0,
			   mmc_data);


input  [31:0] mmc_data15;
input  [31:0] mmc_data14;
input  [31:0] mmc_data13;
input  [31:0] mmc_data12;
input  [31:0] mmc_data11;
input  [31:0] mmc_data10;
input  [31:0] mmc_data9;
input  [31:0] mmc_data8;
input  [31:0] mmc_data7;
input  [31:0] mmc_data6;
input  [31:0] mmc_data5;
input  [31:0] mmc_data4;
input  [31:0] mmc_data3;
input  [31:0] mmc_data2;
input  [31:0] mmc_data1;
input  [31:0] mmc_data0;


input         mmc_mtch_rslt15;
input         mmc_mtch_rslt14;
input         mmc_mtch_rslt13;
input         mmc_mtch_rslt12;
input         mmc_mtch_rslt11;
input         mmc_mtch_rslt10;
input         mmc_mtch_rslt9;
input         mmc_mtch_rslt8;
input         mmc_mtch_rslt7;
input         mmc_mtch_rslt6;
input         mmc_mtch_rslt5;
input         mmc_mtch_rslt4;
input         mmc_mtch_rslt3;
input         mmc_mtch_rslt2;
input         mmc_mtch_rslt1;
input         mmc_mtch_rslt0;

output [31:0] mmc_data;

reg    [31:0] mmc_data;

wire [15:0] mmc_mtch_rslt_wired;

assign mmc_mtch_rslt_wired = {    mmc_mtch_rslt15,
	                          mmc_mtch_rslt14,
	                          mmc_mtch_rslt13,
	                          mmc_mtch_rslt12,
	                          mmc_mtch_rslt11,
	                          mmc_mtch_rslt10,
	                          mmc_mtch_rslt9,
	                          mmc_mtch_rslt8,
	                          mmc_mtch_rslt7,
	                          mmc_mtch_rslt6,
	                          mmc_mtch_rslt5,
	                          mmc_mtch_rslt4,
	                          mmc_mtch_rslt3,
	                          mmc_mtch_rslt2,
	                          mmc_mtch_rslt1,
	                          mmc_mtch_rslt0};


  always @ (*) begin
    case (mmc_mtch_rslt_wired)
      16'h8000 : mmc_data <= mmc_data15;
      16'h4000 : mmc_data <= mmc_data14;
      16'h2000 : mmc_data <= mmc_data13;
      16'h1000 : mmc_data <= mmc_data12;
      16'h0800 : mmc_data <= mmc_data11;
      16'h0400 : mmc_data <= mmc_data10;
      16'h0200 : mmc_data <= mmc_data9;
      16'h0100 : mmc_data <= mmc_data8;
      16'h0080 : mmc_data <= mmc_data7;
      16'h0040 : mmc_data <= mmc_data6;
      16'h0020 : mmc_data <= mmc_data5;
      16'h0010 : mmc_data <= mmc_data4;
      16'h0008 : mmc_data <= mmc_data3;
      16'h0004 : mmc_data <= mmc_data2;
      16'h0002 : mmc_data <= mmc_data1;
      16'h0001 : mmc_data <= mmc_data0;
      default  : mmc_data <= {32{1'bx}};
    endcase
  end

endmodule
