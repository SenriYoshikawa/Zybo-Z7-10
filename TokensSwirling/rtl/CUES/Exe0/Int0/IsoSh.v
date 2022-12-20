module IsoSh(
  	sh_rslt,
  	sh_rslt_cc, 
  	pg_sh,
  
  	iso_sh_rslt,
  	iso_sh_rslt_cc
  );

  input [31:0]	sh_rslt;
  input [1:0]	sh_rslt_cc;
  input 	pg_sh;
  
  output [31:0]	iso_sh_rslt; 
  output [1:0]	iso_sh_rslt_cc; 

  assign iso_sh_rslt = sh_rslt & {32{pg_sh}};
  assign iso_sh_rslt_cc = sh_rslt_cc & {2{pg_sh}};

endmodule