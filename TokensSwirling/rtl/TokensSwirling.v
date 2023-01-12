module TokensSwirling (
    input clk,
    input [3:0] btn,
    input [3:0] sw,
    output [3:0] led,
    output led6_r,
    output led6_g,
    output led6_b,
    output [7:0] je
);

// Wire for ddp
wire        send_i_ddp;
wire        ack_o_ddp;
wire        send_o_ddp;
wire        ack_i_ddp;
wire [61:0] token_i_ddp;
wire [61:0] token_o_ddp;
wire        mm_overflow_pe;
wire        sendo_o_smem1;
assign ack_i_ddp = send_o_ddp; // 出力データをどこにも使わないのでそのまま返す

// wire for Program writer
wire        send_o_pw;
wire [61:0] token_o_pw;
wire        write_program_done;

// wire for DataSender
wire        send_o_ds;
wire [61:0] token_o_ds;
wire        send_token_done;

// peripherals
reg led_on;
reg pre_btn_3;
wire rst = btn[0];
wire program_write_start = btn[1];
wire data_send_start = btn[2];
wire [3:0] token_num = sw[3:0];
wire led_toggle = btn[3] & ~pre_btn_3;
wire prob1;
wire prob2;
assign led6_r = led_on ? mm_overflow_pe : 1'b0;
assign led6_g = led_on ? write_program_done : 1'b0;
assign led6_b = led_on ? send_token_done : 1'b0;

// led_on
always @(posedge clk) begin
    if (rst) begin
        led_on = 1'b1;
    end else if (led_toggle) begin
        led_on = ~led_on;
    end
end

// pre_btn_3
always @(posedge clk) begin
    pre_btn_3 <= btn[3];
end

assign send_i_ddp = write_program_done ? send_o_ds : send_o_pw;
assign token_i_ddp = write_program_done ? token_o_ds : token_o_pw;
assign led = led_on ? sw : 4'd0;
assign je = {4'b0000, write_program_done, send_token_done, prob2, prob1};


CUES uCUES(
    .lr_i(token_i_ddp[61]),
    .uni_opr_i(token_i_ddp[60]),
    .mem_wen_i(token_i_ddp[59:58]),
    .node_i(token_i_ddp[57:44]),
    .gen_i(token_i_ddp[43:32]),
    .opr_i(token_i_ddp[31:0]),

    .nInterC_S_sICN_uC_sMer_uCM(send_i_ddp),
    .nInterC_A_sICN_uC_sSw_uCB(ack_i_ddp),
    
    .lopen(~program_write_start),
    .rstn(~rst),


    .nInterC_A_sMer_uCM_sICN_uC(ack_o_ddp),
    .nInterC_S_sSw_uCB_sICN_uC(send_o_ddp),

    .lr_ssw_to_icn(token_o_ddp[61]),
    .uni_opr_ssw_to_icn(token_o_ddp[60]),
    .mem_w_ssw_to_icn(token_o_ddp[59:58]),
    .node_ssw_to_icn(token_o_ddp[57:44]),
    .gen_ssw_to_icn(token_o_ddp[43:32]),
    .opr_ssw_to_icn(token_o_ddp[31:0]),

    .mm_overflow_o_pe(mm_overflow_pe),
    .prob1(prob1),
    .prob2(prob2)
);

ProgramWriter uProgramWriter(
    .clk(clk),
    .rst(rst),
    .scpen_i_pw(1'b0),
    .start_i_pw(program_write_start),
    .ack_i_pw(ack_o_ddp),
    .send_o_pw(send_o_pw),
    .token_o_pw(token_o_pw),
    .write_done_o_pw(write_program_done)
);

DataSender uDataSender(
    .clk(clk),
    .rst(rst),
    .start_i_ds(data_send_start),
    .token_num_i_ds(token_num),
    .full_loop_i_ds(1'b0),
    .ack_i_ds(ack_o_ddp),
    .send_o_ds(send_o_ds),
    .token_o_ds(token_o_ds),
    .send_done_o_ds(send_token_done)
);

endmodule