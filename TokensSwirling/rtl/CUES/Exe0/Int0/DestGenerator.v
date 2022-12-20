module DestGenerator(
		node_i_dsg,
		t_uni_opr_i_dsg,
		t_lr_i_dsg,
		t_dest_i_dsg,
		f_uni_opr_i_dsg,
		f_lr_i_dsg,
		f_dest_i_dsg,
		cc_i_dsg,
		
		rslt_jmp_i_dsg,
		
		rslt_cc_i_dsg,
		cc_type_i_dsg,
		pe_out_i_dsg,
		pe_lr_i_dsg,
		jmp_dst_valid_i_dsg,
		jmp_dst_i_dsg,
		gate_i_dsg,


		t_next_uni_opr_o_dsg,
		t_next_lr_o_dsg,
		t_next_node_o_dsg,
		f_next_uni_opr_o_dsg,
		f_next_lr_o_dsg,
		f_next_node_o_dsg,
		cp_o_dsg,
		terminate_o_dsg
		
		
		);

  //********************************
  input [15:0]	node_i_dsg;
  input 	t_uni_opr_i_dsg;
  input 	t_lr_i_dsg;
  input [7:0]	t_dest_i_dsg;
  input 	f_uni_opr_i_dsg;
  input 	f_lr_i_dsg;
  input [7:0]	f_dest_i_dsg;
  input [1:0]	cc_i_dsg;
  
  input 	rslt_jmp_i_dsg;
  
  input [1:0]	rslt_cc_i_dsg;
  input [2:0]	cc_type_i_dsg;
  input 	pe_out_i_dsg;
  input 	pe_lr_i_dsg;
  input 	jmp_dst_valid_i_dsg;
  input [16:0]	jmp_dst_i_dsg;
  input 	gate_i_dsg;
 
  
  output 	t_next_uni_opr_o_dsg;
  output 	t_next_lr_o_dsg;
  output [15:0]	t_next_node_o_dsg;
  output 	f_next_uni_opr_o_dsg;
  output 	f_next_lr_o_dsg;
  output [15:0]	f_next_node_o_dsg;
  output 	cp_o_dsg;
  output 	terminate_o_dsg;

  //********************************
  
  
  /*  next lr flag gen ***********************************/
  /*  next node gen ***********************************/
  /*  next uni opr gen ***********************************/
  
  wire 		tf_dsg;
  assign 	tf_dsg = ~rslt_jmp_i_dsg
  			| (rslt_jmp_i_dsg & branch_tf(cc_i_dsg, rslt_cc_i_dsg));

  function branch_tf;
    input [1:0] cc;
    input [1:0] rslt_cc;
    case (cc)
      2'b00: branch_tf = 1'b1;
      2'b01: branch_tf = rslt_cc[0]; // ? 1'b1: 1'b0;
      2'b10: branch_tf = rslt_cc[1]; // ? 1'b1: 1'b0;
      2'b11: branch_tf = 1'b1;
    endcase // case(cc)
  endfunction // branch_tf
  
  
  wire 		t_next_lr_tmp_dsg;
  assign 	t_next_lr_tmp_dsg = pe_out_i_dsg? pe_lr_i_dsg: t_lr_i_dsg;
  assign 	t_next_lr_o_dsg = (gate_i_dsg | tf_dsg)? t_next_lr_tmp_dsg:
  							 f_lr_i_dsg;
  assign 	f_next_lr_o_dsg = f_lr_i_dsg;

  wire [15:0]	t_next_node_tmp_dsg;
  wire [15:0]	f_next_node_tmp_dsg;
  assign 	t_next_node_tmp_dsg = tf_dsg?
  			      node_i_dsg + {{8{t_dest_i_dsg[7]}},t_dest_i_dsg}:
  			      f_next_node_tmp_dsg;
  assign 	t_next_node_o_dsg = jmp_dst_valid_i_dsg?
  					    jmp_dst_i_dsg: t_next_node_tmp_dsg;
  assign 	f_next_node_tmp_dsg =   node_i_dsg 
  				      + {{8{f_dest_i_dsg[7]}},f_dest_i_dsg};
  assign 	f_next_node_o_dsg = f_next_node_tmp_dsg;
  
  assign 	t_next_uni_opr_o_dsg = (gate_i_dsg | tf_dsg)? t_uni_opr_i_dsg:
  							      f_uni_opr_i_dsg;
  assign 	f_next_uni_opr_o_dsg = f_uni_opr_i_dsg;



  /*  copy flag gen ***********************************/
  
  assign 	cp_o_dsg =  ~gate_i_dsg
  			   & rslt_jmp_i_dsg
  			   & copy_gen(cc_type_i_dsg[1:0],cc_i_dsg);
  
  function copy_gen;
    input [1:0] cc_type;
    input [1:0] cc;
    case (cc_type)
      2'b00: copy_gen = &cc;
      2'b01: copy_gen = 1'b0;
      2'b10: copy_gen = cc[1] & ~cc[0];
      2'b11: copy_gen = 1'b0;
    endcase // case(cc_type)
  endfunction // copy_gen


  /*  terminate flag gen ***********************************/

  wire 		cc_terminate_dsg;
  wire 		gate_terminate_dsg;
  assign 	cc_terminate_dsg = rslt_jmp_i_dsg & (&cc_i_dsg) & (|cc_type_i_dsg[1:0]);
  assign 	gate_terminate_dsg = gate_i_dsg & ~gate_terminate_gen(cc_i_dsg,rslt_cc_i_dsg);
  assign 	terminate_o_dsg = cc_terminate_dsg | gate_terminate_dsg;

  function gate_terminate_gen;
    input [1:0] cc;
    input [1:0] rslt_cc;
    case (cc)
      2'b00: gate_terminate_gen = rslt_cc[1];
      2'b01: gate_terminate_gen = ~rslt_cc[1];
      2'b10: gate_terminate_gen = ~rslt_cc[1] & rslt_cc[0];
      2'b11: gate_terminate_gen = ~rslt_cc[1] & ~rslt_cc[0];
    endcase // case(cc)
  endfunction // gate_terminate_gen


endmodule
