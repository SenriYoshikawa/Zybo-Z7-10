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

module MM_Unit (
		key,
		data0,
		mmc_valid,
		w_en,
		clk,
		rst,
		mtch_data,
		mtch_rslt,
		mmc_mtch_rslt);

input  [27:0] key;
input  [31:0] data0;
input  [15:0] mmc_valid;
input  [15:0] w_en;
input         clk;
input         rst;
output [31:0] mtch_data;
output        mtch_rslt;
output [15:0] mmc_mtch_rslt;


wire [31:0] mmc_data [15:0];
wire [15:0] mmc_mtch_rslt;
wire [15:0] mmc_valid;



MM_MUX uMM_MUX (.mmc_data15      (mmc_data[15]),
		.mmc_data14      (mmc_data[14]),
		.mmc_data13      (mmc_data[13]),
		.mmc_data12      (mmc_data[12]),
		.mmc_data11      (mmc_data[11]),
		.mmc_data10      (mmc_data[10]),
		.mmc_data9       (mmc_data[9]),
		.mmc_data8       (mmc_data[8]),
		.mmc_data7       (mmc_data[7]),
		.mmc_data6       (mmc_data[6]),
		.mmc_data5       (mmc_data[5]),
		.mmc_data4       (mmc_data[4]),
		.mmc_data3       (mmc_data[3]),
		.mmc_data2       (mmc_data[2]),
		.mmc_data1       (mmc_data[1]),
		.mmc_data0       (mmc_data[0]),
		.mmc_mtch_rslt15 (mmc_mtch_rslt[15]),
		.mmc_mtch_rslt14 (mmc_mtch_rslt[14]),
		.mmc_mtch_rslt13 (mmc_mtch_rslt[13]),
		.mmc_mtch_rslt12 (mmc_mtch_rslt[12]),
		.mmc_mtch_rslt11 (mmc_mtch_rslt[11]),
		.mmc_mtch_rslt10 (mmc_mtch_rslt[10]),
		.mmc_mtch_rslt9  (mmc_mtch_rslt[9]),
		.mmc_mtch_rslt8  (mmc_mtch_rslt[8]),
		.mmc_mtch_rslt7  (mmc_mtch_rslt[7]),
		.mmc_mtch_rslt6  (mmc_mtch_rslt[6]),
		.mmc_mtch_rslt5  (mmc_mtch_rslt[5]),
		.mmc_mtch_rslt4  (mmc_mtch_rslt[4]),
		.mmc_mtch_rslt3  (mmc_mtch_rslt[3]),
		.mmc_mtch_rslt2  (mmc_mtch_rslt[2]),
		.mmc_mtch_rslt1  (mmc_mtch_rslt[1]),
		.mmc_mtch_rslt0  (mmc_mtch_rslt[0]),
		
		.mmc_data        (mtch_data));


assign mtch_rslt = (|mmc_mtch_rslt);

generate
genvar i;
for (i = 0; i < 16; i=i+1) begin : MM_CellGen

  MM_Cell uMM_Cell (
		    .key (key),
		    .data0 (data0),
                    .w_en(w_en[i]),
		    .clk (clk),
		    .rst (rst),
                    .mmc_valid (mmc_valid[i]),
		    .mmc_data (mmc_data[i]),
		    .mmc_mtch_rslt (mmc_mtch_rslt[i])
		    );

end
endgenerate

endmodule
