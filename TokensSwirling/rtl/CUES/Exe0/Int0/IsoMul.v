module IsoMul(
  	mul_rslt,
  	mul_rslt_cc, 
  	mul_rslt_tag,
  	pg_mul,
  
  	iso_mul_rslt,
  	iso_mul_rslt_cc,
  	iso_mul_rslt_tag
  );

  input [31:0]	mul_rslt;
  input [1:0]	mul_rslt_cc;
  input [11:0]	mul_rslt_tag;
  input 	pg_mul;
  
  output [31:0]	iso_mul_rslt; 
  output [1:0]	iso_mul_rslt_cc; 
  output [11:0]	iso_mul_rslt_tag; 

  assign iso_mul_rslt = mul_rslt & {32{pg_mul}};
  assign iso_mul_rslt_cc = mul_rslt_cc & {2{pg_mul}};
  assign iso_mul_rslt_tag = mul_rslt_tag & {12{pg_mul}};

endmodule