module IsoMMU(
  	mm0_mtch_data,
  	mm1_mtch_data,
	mm0_mtch_rslt,
	mm1_mtch_rslt,
	mm0_mmc_mtch_rslt,
	mm1_mmc_mtch_rslt,
	pg_mmu0,
	pg_mmu1,
	
	mm0_iso_mtch_data,
	mm1_iso_mtch_data,
	mm0_iso_mtch_rslt,
	mm1_iso_mtch_rslt,
	mm0_iso_mmc_mtch_rslt,
	mm1_iso_mmc_mtch_rslt
  );

  input [31:0]	mm0_mtch_data;
  input [31:0]	mm1_mtch_data;
  input 	mm0_mtch_rslt;
  input 	mm1_mtch_rslt;
  input [15:0]	mm0_mmc_mtch_rslt;
  input [15:0]	mm1_mmc_mtch_rslt;
  input 	pg_mmu0;
  input 	pg_mmu1;
  
  output [31:0]	mm0_iso_mtch_data;
  output [31:0]	mm1_iso_mtch_data;
  output 	mm0_iso_mtch_rslt;
  output 	mm1_iso_mtch_rslt;
  output [15:0]	mm0_iso_mmc_mtch_rslt;
  output [15:0]	mm1_iso_mmc_mtch_rslt;


  assign mm0_iso_mtch_data = mm0_mtch_data & {32{pg_mmu0}};
  assign mm0_iso_mtch_rslt = mm0_mtch_rslt & pg_mmu0;
  assign mm0_iso_mmc_mtch_rslt = mm0_mmc_mtch_rslt & {16{pg_mmu0}};

  assign mm1_iso_mtch_data = mm1_mtch_data & {32{pg_mmu1}};
  assign mm1_iso_mtch_rslt = mm1_mtch_rslt & pg_mmu1;
  assign mm1_iso_mmc_mtch_rslt = mm1_mmc_mtch_rslt & {16{pg_mmu1}};


endmodule