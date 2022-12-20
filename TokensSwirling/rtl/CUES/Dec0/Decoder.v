module Decoder
  (
   //Input:  name_pipe_from_in_modulename
   //Output: name_pipe_to_out_modulename

   //from Ftc1(Dec)
   opecode_i_dcdr,			//IN


   //to Exe(Dec)
   dopc_o_dcdr				//OUT

   
   );

  /***********************************************************/
  /*                 DEFINITION OF INPUT                     */
  /***********************************************************/

  input [6:0]	opecode_i_dcdr;


  /***********************************************************/
  /*                 DEFINITION OF OUTPUT                    */
  /***********************************************************/

  output [9:0]	dopc_o_dcdr;


  /********************************************************************/
  /*                       Decode Opecode                             */
  /********************************************************************/

  assign		dopc_o_dcdr = dopc_dcdr(opecode_i_dcdr);

  
  function [9:0]	dopc_dcdr;
    input [6:0]		opecode_dcdr;

    case (opecode_dcdr) //synopsys parallel_case
      //(0) 000_0000 -> 000_0111
      7'b000_0000: dopc_dcdr = 10'b000_0_0_0_0_1_0_1;//0 : add
      7'b000_0001: dopc_dcdr = 10'b000_0_1_0_0_1_0_1;//1 : sub
      7'b000_0010: dopc_dcdr = 10'b001_0_1_0_0_1_1_1;//2 : mul
      7'b000_0011: dopc_dcdr = 10'b111_1_1_1_1_1_1_1;//3 : div
      7'b000_0100: dopc_dcdr = 10'b000_0_0_1_0_1_0_1;//4 : add_sat
      7'b000_0101: dopc_dcdr = 10'b000_0_1_1_0_1_0_1;//5 : sub_sat
      7'b000_0110: dopc_dcdr = 10'b001_0_1_1_0_1_1_1;//6 : mul_sat
      7'b000_0111: dopc_dcdr = 10'b000_0_1_0_0_1_1_1;//7 : compare

      //(1) 000_1000 -> 000_1111
      7'b000_1000: dopc_dcdr = 10'b010_001_0_11_1;//8 : and
      7'b000_1001: dopc_dcdr = 10'b010_010_0_11_1;//9 : or
      7'b000_1010: dopc_dcdr = 10'b010_011_1_11_1;//10 : not
      7'b000_1011: dopc_dcdr = 10'b010_100_0_11_1;//11 : exclusive or
      7'b000_1100: dopc_dcdr = 10'b010_101_1_11_1;//12 : reduction xor
      7'b000_1101: dopc_dcdr = 10'b010_110_1_11_1;//13 : leading zero
      7'b000_1110: dopc_dcdr = 10'b111_111_1_11_1;//14 : 
      7'b000_1111: dopc_dcdr = 10'b111_111_1_11_1;//15 : 

      //(2) 001_0000 -> 001_0111
      7'b001_0000: dopc_dcdr = 10'b011_00_0_0_00_1;//16 : shift right
      7'b001_0001: dopc_dcdr = 10'b011_00_1_0_00_1;//17 : shift left
      7'b001_0010: dopc_dcdr = 10'b011_01_0_0_00_1;//18 : rotate right
      7'b001_0011: dopc_dcdr = 10'b011_01_1_0_00_1;//19 : rotate left
      7'b001_0100: dopc_dcdr = 10'b011_11_1_0_00_1;//20 : alithmetic shift
      7'b001_0101: dopc_dcdr = 10'b111_11_1_1_11_1;//21 : 
      7'b001_0110: dopc_dcdr = 10'b111_11_1_1_11_1;//22 : 
      7'b001_0111: dopc_dcdr = 10'b111_11_1_1_11_1;//23 : 

      //(3) 001_1000 -> 001_1111
      7'b001_1000: dopc_dcdr = 10'b000_1_0_0_0_1_1_1;//24 : tag add
      7'b001_1001: dopc_dcdr = 10'b000_1_1_0_0_1_1_1;//25 : tag sub
      7'b001_1010: dopc_dcdr = 10'b001_1_0_0_0_1_1_1;//26 : tag mul
      7'b001_1011: dopc_dcdr = 10'b111_1_1_1_1_1_1_1;//27 : 
      7'b001_1100: dopc_dcdr = 10'b111_1_1_1_1_1_1_1;//28 : 
      7'b001_1101: dopc_dcdr = 10'b010_000_1_1_1_0;//29 : tag get
      7'b001_1110: dopc_dcdr = 10'b000_1_0_1_0_1_1_0;//30 : tag set
      7'b001_1111: dopc_dcdr = 10'b000_1_1_1_0_1_1_1;//31 : tag compare

      //(4) 010_0000 -> 010_0111
      7'b010_0000: dopc_dcdr = 10'b100_111_0_01_1;//32 : out
      7'b010_0001: dopc_dcdr = 10'b100_001_1_11_0;//33 : out eos
      7'b010_0010: dopc_dcdr = 10'b100_010_1_11_0;//34 : out core r
      7'b010_0011: dopc_dcdr = 10'b100_011_1_11_0;//35 : out load r
      7'b010_0100: dopc_dcdr = 10'b100_100_1_11_0;//36 : out core w
      7'b010_0101: dopc_dcdr = 10'b100_101_1_11_0;//37 : out load w
      7'b010_0110: dopc_dcdr = 10'b111_11_1_11_1_1;//38 : 
      7'b010_0111: dopc_dcdr = 10'b111_11_1_11_1_1;//39 : mm entry config

      //(5) 010_1000 -> 010_1111
      7'b010_1000: dopc_dcdr = 10'b101_0_00_1_1_1_1;//40 : add accumlator opr
      7'b010_1001: dopc_dcdr = 10'b101_0_01_1_1_1_1;//41 : sub accumlator opr
      7'b010_1010: dopc_dcdr = 10'b101_0_00_1_0_1_1;//42 : add accumlator opr sel imm
      7'b010_1011: dopc_dcdr = 10'b101_0_01_1_0_1_1;//43 : sub accumlator opr sel imm
      7'b010_1100: dopc_dcdr = 10'b111_1_11_1_1_1_1;//44 :
      7'b010_1101: dopc_dcdr = 10'b101_0_11_1_0_1_1;//45 : cmp accumlator opr sel imm
      7'b010_1110: dopc_dcdr = 10'b101_0_10_1_0_1_0;//46 : set accumlator sel imm
      7'b010_1111: dopc_dcdr = 10'b101_0_11_1_1_1_1;//47 : cmp accumlator opr

      //(6) 011_0000 -> 011_0111
      7'b011_0000: dopc_dcdr = 10'b100_010_0_00_0;//48 : gate
      7'b011_0001: dopc_dcdr = 10'b111_111_11_11;//49 : 
      7'b011_0010: dopc_dcdr = 10'b100_001_0_11_0;//50 : jump
      7'b011_0011: dopc_dcdr = 10'b100_011_0_11_0;//51 : jump absolute
      7'b011_0100: dopc_dcdr = 10'b100_101_0_01_1;//52 : multi-P. jump
      7'b011_0101: dopc_dcdr = 10'b100_111_0_01_1;//53 : multi-P. jump absolute
      7'b011_0110: dopc_dcdr = 10'b111_111_1_11_1;//54 : PE out test
      7'b011_0111: dopc_dcdr = 10'b100_110_0_10_1;//55 : no operation

      //(7) 011_1000 -> 011_1111
      7'b011_1000: dopc_dcdr = 10'b101_1_01_11_1_0;//56 : read system register
      7'b011_1001: dopc_dcdr = 10'b101_1_11_11_1_0;//57 : write system register
      7'b011_1010: dopc_dcdr = 10'b111_11_1_11_1_1;//58 : 
      7'b011_1011: dopc_dcdr = 10'b111_11_1_11_1_1;//59 : 
      7'b011_1100: dopc_dcdr = 10'b111_11_1_11_1_1;//60 : 
      7'b011_1101: dopc_dcdr = 10'b111_11_1_11_1_1;//61 : 
      7'b011_1110: dopc_dcdr = 10'b111_11_1_11_1_1;//62 : 
      7'b011_1111: dopc_dcdr = 10'b111_11_1_11_1_1;//63 : 

      //(8) 100_0000 -> 100_0111
      7'b100_0000: dopc_dcdr = 10'b000_0_0_0_1_1_0_1;//64 : add immediate
      7'b100_0001: dopc_dcdr = 10'b000_0_1_0_1_1_0_1;//65 : sub immediate
      7'b100_0010: dopc_dcdr = 10'b001_0_1_0_1_1_1_1;//66 : mul immediate1
      7'b100_0011: dopc_dcdr = 10'b111_1_1_1_1_1_1_1;//67 : div immediate
      7'b100_0100: dopc_dcdr = 10'b000_1_0_1_1_1_00;//68 : absolute
      7'b100_0101: dopc_dcdr = 10'b111_1_1_1_11_1_1;//69 : 
      7'b100_0110: dopc_dcdr = 10'b111_1_1_1_11_1_1;//70 : 
      7'b100_0111: dopc_dcdr = 10'b000_0_1_0_1_1_1_1;//71 : compare immediate

      //(9) 100_1000 -> 100_1111
      7'b100_1000: dopc_dcdr = 10'b101_0_00_0_1_1_1;//72 : add accumlator imm
      7'b100_1001: dopc_dcdr = 10'b101_0_01_0_1_1_1;//73 : sub accumlator imm
      7'b100_1010: dopc_dcdr = 10'b111_11_1_11_1_1;//74 : 
      7'b100_1011: dopc_dcdr = 10'b111_11_1_11_1_1;//75 : 
      7'b100_1100: dopc_dcdr = 10'b011_00_0_1_01_1;//76 : shift right AND
      7'b100_1101: dopc_dcdr = 10'b011_00_1_1_01_1;//77 : shift left AND
      7'b100_1110: dopc_dcdr = 10'b101_0_10_1_1_1_0;//78 : set accumlator
      7'b100_1111: dopc_dcdr = 10'b101_0_11_0_1_1_1;//79 : compare accumlator imm

      //(10) 101_0000 -> 101_0111
      7'b101_0000: dopc_dcdr = 10'b011_00_0_1_00_1;//80 : shift right immediate
      7'b101_0001: dopc_dcdr = 10'b011_00_1_1_00_1;//81 : shift left immediate
      7'b101_0010: dopc_dcdr = 10'b011_01_0_1_00_1;//82 : rotate right immediate
      7'b101_0011: dopc_dcdr = 10'b011_01_1_1_00_1;//83 : rotate left immediate
      7'b101_0100: dopc_dcdr = 10'b011_11_1_1_00_1;//84 : alithmetic shift immediate
      7'b101_0101: dopc_dcdr = 10'b111_11_1_1_11_1;//85 : 
      7'b101_0110: dopc_dcdr = 10'b011_00_0_1_11_1;//86 : shift right OR
      7'b101_0111: dopc_dcdr = 10'b011_00_1_1_11_1;//87 : shift left OR

      //(11) 101_1000 -> 101_1111
      7'b101_1000: dopc_dcdr = 10'b000_1_0_0_1_1_1_1;//88 : tag add immediate
      7'b101_1001: dopc_dcdr = 10'b000_1_1_0_1_1_1_1;//89 : tag sub immediate
      7'b101_1010: dopc_dcdr = 10'b001_1_0_0_1_1_1_1;//90 : tag mul immediate
      7'b101_1011: dopc_dcdr = 10'b111_11_11_1_1_1;//91 : 
      7'b101_1100: dopc_dcdr = 10'b111_11_11_1_1_1;//92 : 
      7'b101_1101: dopc_dcdr = 10'b111_11_11_1_1_1;//93 : 
      7'b101_1110: dopc_dcdr = 10'b000_1_0_1_1_1_1_0;//94 : tag set immediate
      7'b101_1111: dopc_dcdr = 10'b000_1_1_1_1_1_1_1;//95 : tag compare immediate

      //(12) 110_0000 -> 110_0111
      7'b110_0000: dopc_dcdr = 10'b000_0_0_0_1_0_0_0;//96 : add long immediate
      7'b110_0001: dopc_dcdr = 10'b000_0_1_0_1_0_0_0;//97 : sub long  immediate
      7'b110_0010: dopc_dcdr = 10'b001_0_1_0_1_0_1_0;//98 : mul long immediate
      7'b110_0011: dopc_dcdr = 10'b111_11_1_11_1_1;//99 : div long immediate
      7'b110_0100: dopc_dcdr = 10'b000_0_0_1_1_0_0_0;//100 : add sat immediate
      7'b110_0101: dopc_dcdr = 10'b000_0_1_1_1_0_0_0;//101 : sub sat immediate
      7'b110_0110: dopc_dcdr = 10'b001_0_1_1_1_0_1_0;//102 : mul sat immediate
      7'b110_0111: dopc_dcdr = 10'b111_11_1_11_1_1;//103 : 

      //(13) 110_1000 -> 110_1111
      7'b110_1000: dopc_dcdr = 10'b010_001_1_11_0;//104 : and immediate
      7'b110_1001: dopc_dcdr = 10'b010_010_1_11_0;//105 : or immediate
      7'b110_1010: dopc_dcdr = 10'b111_111_1_11_1;//106 : 
      7'b110_1011: dopc_dcdr = 10'b010_100_1_11_0;//107 : exclusive or immediate
      7'b110_1100: dopc_dcdr = 10'b111_111_1_11_1;//108 : 
      7'b110_1101: dopc_dcdr = 10'b111_111_1_11_1;//109 : 
      7'b110_1110: dopc_dcdr = 10'b010_111_1_11_0;//110 : constant
      7'b110_1111: dopc_dcdr = 10'b111_111_1_11_1;//111 : 

      //(14) 111_0000 -> 111_0111
      7'b111_0000: dopc_dcdr = 10'b111_0_0_0_1110;//112 : load
      7'b111_0001: dopc_dcdr = 10'b111_0_1_0_1110;//113 : store
      7'b111_0010: dopc_dcdr = 10'b111_1_1_1_1111;//114 : 
      7'b111_0011: dopc_dcdr = 10'b111_0_1_1_1110;//115 : store and teminate
      7'b111_0100: dopc_dcdr = 10'b111_1_1_1_1111;//116 : 
      7'b111_0101: dopc_dcdr = 10'b111_1_1_1_1110;//117 : write
      7'b111_0110: dopc_dcdr = 10'b111_1_1_0_1111;//118 : 
      7'b111_0111: dopc_dcdr = 10'b111_1_1_1_1110;//119 : write terminate

      //(15) 111_1000 -> 111_1111
      7'b111_1000: dopc_dcdr = 10'b111_1_1_1_1111;//120 : 
      7'b111_1001: dopc_dcdr = 10'b111_1_1_1_1111;//121 : 
      7'b111_1010: dopc_dcdr = 10'b111_1_1_1_1111;//122 : 
      7'b111_1011: dopc_dcdr = 10'b111_1_1_1_1111;//123 : 
      7'b111_1100: dopc_dcdr = 10'b111_1_1_1_1111;//124 : 
      7'b111_1101: dopc_dcdr = 10'b111_1_1_1_1111;//125 : 
      7'b111_1110: dopc_dcdr = 10'b111_1_1_1_1111;//126 : 
      7'b111_1111: dopc_dcdr = 10'b111_1_1_1_1111;//127 : 
      //default: dopc_dcdr = 10'b1; //gomi
    endcase // case (opcode_dcdr)
  endfunction // dopc_dcdr
endmodule // Decoder

