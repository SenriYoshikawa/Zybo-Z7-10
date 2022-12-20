////////////////////////////////////////////////////////////////////////////////
//
//  (c) Copyright 2010 AIL Co., Ltd.
//      ALL RIGHTS RESERVED
//
//  Filename : MM_Cell.v
//  Date     : Wed Jun 16 08:57:25 JST 2010
//
//  $Date: 2010/06/17 13:12:48 $
//  $Revision: 1.3 $
//  $Id: MM_Cell.v,v 1.3 2010/06/17 13:12:48 konishi Exp $
//  $Status$
//  
////////////////////////////////////////////////////////////////////////////////
//  Purpose : One matchign memory cell
//            
//            
//            
//            
////////////////////////////////////////////////////////////////////////////////

module MM_Cell (
		key,
		data0,
		w_en,
		clk,
		rst,
		mmc_valid,
		mmc_data,
		mmc_mtch_rslt);

input  [27:0] key;           // 28-b TAG key
input  [31:0] data0;         // 32-b data
input         w_en;          // High active write enable
input         clk;           // clock
input         rst;           // low active reset
input         mmc_valid;     // valid bit output
output [31:0] mmc_data;      // matching data
output        mmc_mtch_rslt; // match or not flag

reg [27:0] mmc_key;
reg [31:0] mmc_data;

always @ (posedge clk) begin
  if (w_en) begin
    mmc_key  <= key;
    mmc_data <= data0;
  end
end

assign mmc_mtch_rslt = mmc_valid & (key == mmc_key);

endmodule
