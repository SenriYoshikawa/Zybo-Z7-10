module Int0( 
	node_i_int0,				//IN
	gen_i_int0,
	opr0_i_int0,
	opr1_i_int0,
	mem_wen_i_int0,
	dopc_i_int0,
	ins_i_int0,
	pg_mul_int0,
	pg_sh_int0,

	opr0_o_int0,				//OUT
	pe_out_o_int0,
	pe_num_o_int0,
	f_mem_w_o_int0,
	dm_dopc_o_int0,
	dm_addr_o_int0,
	sysreg_wen_vctr_o_int0,
	t_next_lr_o_int0,
	t_next_uni_opr_o_int0,
	t_next_node_o_int0,
	f_next_lr_o_int0,
	f_next_uni_opr_o_int0,
	f_next_node_o_int0,
	gen_o_int0,
	cp_o_int0,
	terminate_o_int0
  );


  /***********************************************************/
  /*           DEFINITION OF INPUT SIGNALS                   */
  /***********************************************************/

  //from Dec(Exe)
  input [15:0]	node_i_int0;
  input [11:0]	gen_i_int0;
  input [31:0]	opr0_i_int0;
  input [31:0]	opr1_i_int0;
  input 	      mem_wen_i_int0;
  input [9:0] 	dopc_i_int0;
  input [26:0]	ins_i_int0;
  input 	      pg_mul_int0;
  input 	      pg_sh_int0;


  /***********************************************************/
  /*           DEFINITION OF OUTPUT SIGNALS                  */
  /***********************************************************/

  //to Mem0(Exe)
  output [31:0]	opr0_o_int0; 
  output 	      pe_out_o_int0;
  output [2:0]	pe_num_o_int0;
  output 	      f_mem_w_o_int0;
  output [2:0]	dm_dopc_o_int0;
  output [13:0]	dm_addr_o_int0;
  output [7:0]	sysreg_wen_vctr_o_int0;
  output 	      t_next_lr_o_int0;
  output 	      t_next_uni_opr_o_int0;
  output [15:0]	t_next_node_o_int0;
  output 	      f_next_lr_o_int0;
  output 	      f_next_uni_opr_o_int0;
  output [15:0]	f_next_node_o_int0;
  output [11:0]	gen_o_int0;
  output 	      cp_o_int0;
  output 	      terminate_o_int0;


  /***********************************************************/
  /*                 DEFINITION OF WIRE                      */
  /***********************************************************/

  // alu rslt
  wire [31:0] 	rslt_add_int0;
  wire [31:0] 	rslt_mul_int0;
  wire [31:0] 	rslt_log_int0;
  wire [31:0] 	rslt_sh_int0;    
  
  wire [31:0] 	rslt_mul_to_iso_int0;
  wire [31:0] 	rslt_sh_to_iso_int0;
  wire [2:0]	  cc_type_int0;

  // alu rslt cc
  wire [1:0] 	rslt_cc_add_int0;
  wire [1:0] 	rslt_cc_mul_int0;
  wire [1:0] 	rslt_cc_log_int0;
  wire [1:0] 	rslt_cc_sh_int0;
  wire [1:0] 	rslt_cc_jmp_int0;

  wire [1:0] 	rslt_cc_mul_to_iso_int0;
  wire [1:0] 	rslt_cc_sh_to_iso_int0;
  
  wire [1:0] 	rslt_cc_int0;
  
  // alu rslt tag
  wire [11:0] 	rslt_tag_add_int0;
  wire [11:0] 	rslt_tag_mul_int0;
  
  wire [11:0] 	rslt_tag_mul_to_iso_int0;
  
  wire [11:0] 	rslt_gen_int0;
  
  wire 		sysreg_w_terminate_int0;
  
  /*  alu include  ********************************************/
  
  /***********************************************************/
  /*                      INCLUDE Adder                      */
  /***********************************************************/
  
  Adder Adder( 
 		.opr0_i_add( opr0_i_int0 ), 
 		.opr1_i_add( opr1_i_int0 ),
 		.imm16_i_add( ins_i_int0[15:0] ),
 		.gen_i_add( gen_i_int0 ),
 		.tag_i_add( dopc_i_int0[6] ),
 		.sub_i_add( dopc_i_int0[5] ),
 		.sat_i_add( dopc_i_int0[4] ),
 		.r_sel_i_add( dopc_i_int0[3] ),
 		.imm_sel_i_add( dopc_i_int0[2] ),
 		.rslt_sel_i_add( dopc_i_int0[1] ),
 		.jump_i_add( dopc_i_int0[0] ),
     
 		.rslt_o_add( rslt_add_int0 ), 
 		.rslt_cc_o_add( rslt_cc_add_int0 ),
 		.rslt_tag_o_add( rslt_tag_add_int0 )
 		);


  /***********************************************************/
  /*                    INCLUDE Multiplier                   */
  /***********************************************************/

  Multiplier Multiplier(
  		.opr0_i_mul( opr0_i_int0 ), 
  		.opr1_i_mul( {opr1_i_int0[31],opr1_i_int0[14:0]} ),
  		.imm16_i_mul( ins_i_int0[15:0] ),
  		.gen_i_mul( gen_i_int0 ),
  		.tag_i_mul( dopc_i_int0[6] ),
  		.sat_i_mul( dopc_i_int0[4] ),
  		.r_sel_i_mul( dopc_i_int0[3] ),
  		.imm_sel_i_mul( dopc_i_int0[2] ),
      
  		.rslt_o_mul( rslt_mul_to_iso_int0 ),
  		.rslt_cc_o_mul( rslt_cc_mul_to_iso_int0 ),
  		.rslt_tag_o_mul( rslt_tag_mul_to_iso_int0 )
  		);
  
  IsoMul IsoMul(
  		.mul_rslt( rslt_mul_to_iso_int0 ),
  		.mul_rslt_cc( rslt_cc_mul_to_iso_int0 ),
  		.mul_rslt_tag( rslt_tag_mul_to_iso_int0 ),
  		.pg_mul( pg_mul_int0 ),
  
  		.iso_mul_rslt( rslt_mul_int0 ),
  		.iso_mul_rslt_cc( rslt_cc_mul_int0 ),
  		.iso_mul_rslt_tag( rslt_tag_mul_int0 )
  		);
  
   
  /***********************************************************/
  /*                      INCLUDE Logic                      */
  /***********************************************************/
  
  Logic Logic(
  		.opr0_i_log( opr0_i_int0 ), 
  		.opr1_i_log( opr1_i_int0 ),
  		.imm16_i_log( ins_i_int0[15:0] ),
  		.gen_i_log( gen_i_int0 ),
  		.logic_sel_i_log( dopc_i_int0[6:4] ),
  		.r_sel_i_log( dopc_i_int0[3] ),
  
  		.rslt_o_log( rslt_log_int0 ),
  		.rslt_cc_o_log( rslt_cc_log_int0 )
  		);
  

  /***********************************************************/
  /*                    INCLUDE Shifter                      */
  /***********************************************************/
  
  Shifter Shifter(
  		.opr0_i_sh( opr0_i_int0 ), 
  		.opr1_i_sh( opr1_i_int0 ),
  		.imm5_i_sh( ins_i_int0[4:0] ),
  		.shift_sel_i_sh( dopc_i_int0[6:5] ),
  		.drct_sel_i_sh( dopc_i_int0[4] ),
  		.r_sel_i_sh( dopc_i_int0[3] ),
  		.option_i_sh( dopc_i_int0[2:1] ),

  		.rslt_o_sh( rslt_sh_to_iso_int0 ),
  		.rslt_cc_o_sh( rslt_cc_sh_to_iso_int0 )
  		);

  IsoSh IsoSh(
  		.sh_rslt( rslt_sh_to_iso_int0 ),
  		.sh_rslt_cc( rslt_cc_sh_to_iso_int0 ),
  		.pg_sh( pg_sh_int0 ),
  
  		.iso_sh_rslt( rslt_sh_int0 ),
  		.iso_sh_rslt_cc( rslt_cc_sh_int0 )
  		);


  /***********************************************************/
  /*                      INCLUDE Jump                       */
  /***********************************************************/
  
  wire 		pe_out_int0;
  wire 		pe_lr_int0;
  wire 		jmp_dst_valid_int0;
  wire [16:0]	jmp_dst_jmp_int0;
  wire 		gate_int0;
  
  
  Jump Jump(
 		.sel_module_i_jmp( dopc_i_int0[9:7] ),
 		.opr0_i_jmp( opr0_i_int0 ), 
 		.opr1_i_jmp( opr1_i_int0 ),
 		.ins_i_jmp( ins_i_int0[17:0] ),
 		.sel_jmp_i_jmp( dopc_i_int0[6:4] ),
 		.ld_ctrl_i_jmp( dopc_i_int0[3] ),

 		.rslt_cc_o_jmp( rslt_cc_jmp_int0 ),
 		.pe_out_o_jmp( pe_out_int0 ),
 		.pe_num_o_jmp( pe_num_o_int0 ),
 		.pe_lr_o_jmp( pe_lr_int0 ),
 		.f_mem_w_o_jmp( f_mem_w_o_int0 ),
 		.jmp_dst_valid_o_jmp( jmp_dst_valid_int0 ),
 		.jmp_dst_o_jmp( jmp_dst_jmp_int0 ),
 		.gate_o_jmp( gate_int0 )
 		);


  /***********************************************************/
  /*                   INCLUDE AccSysreg0                    */
  /***********************************************************/
  
  AccSysreg0 AccSysreg0(
  		.gen_i_as0( gen_i_int0[3:0] ),
  		.mem_wen_i_as0( mem_wen_i_int0 ),
  		.imm16_i_as0( ins_i_int0[2:0] ),
  		.sel_module_i_as0( dopc_i_int0[9:7] ),
  		.sel1_i_as0( dopc_i_int0[6] ),
  		.sel2_i_as0( dopc_i_int0[5] ),

  		.sysreg_wen_vctr_o_as0( sysreg_wen_vctr_o_int0 ),
  		.sysreg_w_terminate_o_as0( sysreg_w_terminate_int0 )

  		);
  
  /***********************************************************/
  /*                       INCLUDE LS                        */
  /***********************************************************/
  
  LS LS(
  		.sel_module_i_ls( dopc_i_int0[9:7] ),
  		.node_i_ls( node_i_int0[13:0] ),
  		.opr1_i_ls( opr1_i_int0[13:0] ),
  		.mem_wen_i_ls( mem_wen_i_int0 ),
  		.imm16_i_ls( {ins_i_int0[15],ins_i_int0[12:0]} ),
  		.sel1_i_ls( dopc_i_int0[6] ),
  		.sel_ls_i_ls( dopc_i_int0[5] ),
  		.terminate_i_ls( dopc_i_int0[4] ),

  		.dm_dopc_o_ls( dm_dopc_o_int0 ),
  		.dm_addr_o_ls( dm_addr_o_int0 )
  		);
  
  
  /*  alu include end  ****************************************/



  /*  alu rslt select  ****************************************/

  assign opr0_o_int0 = alu_rslt_selector(
 					 dopc_i_int0[9:7],
 					 rslt_add_int0,
 					 rslt_mul_int0,
 					 rslt_log_int0,
					 rslt_sh_int0,
					 opr0_i_int0
					 );

  function [31:0] alu_rslt_selector;
    input [2:0]  sel_module;
    input [31:0] rslt_add_int0;
    input [31:0] rslt_mul_int0;
    input [31:0] rslt_log_int0;
    input [31:0] rslt_sh_int0;
    input [31:0] opr0;
    casex(sel_module)//sysnopsys parallel_case
      3'b000: alu_rslt_selector = rslt_add_int0;
      3'b001: alu_rslt_selector = rslt_mul_int0;
      3'b010: alu_rslt_selector = rslt_log_int0;
      3'b011: alu_rslt_selector = rslt_sh_int0;
      3'b1xx: alu_rslt_selector = opr0;//jump,acc/sysreg,ls
      default: alu_rslt_selector = {32{1'bx}};
    endcase // casex(sel_module)
  endfunction // alu_rslt_selector


  /*  cc type gen  ***********************************/

  assign cc_type_int0 = cc_type_gen(dopc_i_int0[9:7],dopc_i_int0[2:1]);

  function [2:0] cc_type_gen;
    input [2:0] sel_module;
    input [1:0] jmp_cc;
    case(sel_module)//sysnopsys parallel_case
      3'b100: cc_type_gen = {1'b1,jmp_cc};
      3'b101: cc_type_gen = 3'b011;
      default: cc_type_gen = {3{1'b0}};
    endcase // case(sel_module)
  endfunction // cc_type_gen


  /*  alu rslt cc select  ***********************************/

  assign rslt_cc_int0 = alu_rslt_cc_selector(dopc_i_int0[9:7],
  					     rslt_cc_add_int0,
  					     rslt_cc_mul_int0,
  					     rslt_cc_log_int0,
					     rslt_cc_sh_int0,
					     rslt_cc_jmp_int0
					     );

  function [1:0] alu_rslt_cc_selector;
    input [2:0] sel_module;
    input [1:0] rslt_cc_add_int0;
    input [1:0] rslt_cc_mul_int0;
    input [1:0] rslt_cc_log_int0;
    input [1:0] rslt_cc_sh_int0;
    input [1:0] rslt_cc_jmp_int0;
    case(sel_module)//sysnopsys parallel_case
      3'b000: alu_rslt_cc_selector = rslt_cc_add_int0;
      3'b001: alu_rslt_cc_selector = rslt_cc_mul_int0;
      3'b010: alu_rslt_cc_selector = rslt_cc_log_int0;
      3'b011: alu_rslt_cc_selector = rslt_cc_sh_int0;
      3'b100: alu_rslt_cc_selector = rslt_cc_jmp_int0;
      default: alu_rslt_cc_selector = {2{1'b0}};
    endcase // case(sel_module)
  endfunction // alu_rslt_cc_selector
  
  /*  gen select  ***********************************/

  assign gen_o_int0 = rslt_gen_int0;

  assign rslt_gen_int0 = gen_selector( dopc_i_int0[9:7],
 				       rslt_tag_add_int0,
	 			       rslt_tag_mul_int0,
 				       gen_i_int0
				       );

  function [11:0] gen_selector;
    input [2:0]  sel_module;
    input [11:0] rslt_tag_add_int0;
    input [11:0] rslt_tag_mul_int0;
    input [11:0] gen_int0;
    case(sel_module)//sysnopsys parallel_case
      3'b000: gen_selector = rslt_tag_add_int0;
      3'b001: gen_selector = rslt_tag_mul_int0;
      default: gen_selector = gen_int0;
    endcase // case(sel_module)
  endfunction // gen_selector
  
  
  /***********************************************************/
  /*                   INCLUDE DestGenerator                 */
  /***********************************************************/

  wire 		t_lr_int0;
  wire 		t_uni_opr_int0;
  wire [7:0]	t_dest_int0;
  wire 		f_lr_int0;
  wire 		f_uni_opr_int0;
  wire [7:0]	f_dest_int0;
  wire [1:0]	cc_int0;
  wire 		rslt_jmp_int0;
  
  assign 	t_lr_int0 = ins_i_int0[24];
  assign 	t_uni_opr_int0 = ins_i_int0[26];
  assign 	t_dest_int0 = ins_i_int0[23:16];
  assign 	f_lr_int0 = ins_i_int0[15];
  assign 	f_uni_opr_int0 = ins_i_int0[25];
  assign 	f_dest_int0 = ins_i_int0[14: 7];
  assign 	cc_int0 = ins_i_int0[6: 5];
  assign 	rslt_jmp_int0 = dopc_i_int0[0];
  
  assign 	pe_out_o_int0 = pe_out_int0;
  
  wire 		rslt_terminate_int0;
  assign 	terminate_o_int0 = rslt_terminate_int0 | sysreg_w_terminate_int0;
  
  DestGenerator DestGenerator(
		.node_i_dsg( node_i_int0 ),
		.t_uni_opr_i_dsg( t_uni_opr_int0 ),
		.t_lr_i_dsg( t_lr_int0 ),
		.t_dest_i_dsg( t_dest_int0 ),
		.f_uni_opr_i_dsg( f_uni_opr_int0 ),
		.f_lr_i_dsg( f_lr_int0 ),
		.f_dest_i_dsg( f_dest_int0 ),
		.cc_i_dsg( cc_int0 ),
		.rslt_jmp_i_dsg( rslt_jmp_int0 ),
		.rslt_cc_i_dsg( rslt_cc_int0 ),
 		.pe_out_i_dsg( pe_out_int0 ),
		.pe_lr_i_dsg( pe_lr_int0 ),
		.cc_type_i_dsg( cc_type_int0 ),
		.jmp_dst_valid_i_dsg( jmp_dst_valid_int0 ),
		.jmp_dst_i_dsg( jmp_dst_jmp_int0 ),
		.gate_i_dsg( gate_int0 ),


		.t_next_uni_opr_o_dsg( t_next_uni_opr_o_int0 ),
		.t_next_lr_o_dsg( t_next_lr_o_int0 ),
		.t_next_node_o_dsg( t_next_node_o_int0 ),
		.f_next_uni_opr_o_dsg( f_next_uni_opr_o_int0 ),
		.f_next_lr_o_dsg( f_next_lr_o_int0 ),
		.f_next_node_o_dsg( f_next_node_o_int0 ),
		.cp_o_dsg( cp_o_int0 ),
		.terminate_o_dsg( rslt_terminate_int0 )
		);

endmodule // Int0
