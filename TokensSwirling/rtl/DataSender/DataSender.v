module DataSender(
    input clk,
    input rst,
    input start_i_ds,
    input [3:0] token_num_i_ds,
    input full_loop_i_ds,
    input ack_i_ds,
    output reg send_o_ds,
    output [61:0] token_o_ds,
    output send_done_o_ds
);

reg start_buf;
reg [3:0] send_count;
wire last_token = token_num_i_ds == 6'd1 | send_count == token_num_i_ds - 4'd2;
assign token_o_ds = last_token ? {1'b0, 1'b1, 2'b00, 14'd1, 12'd0,  full_loop_i_ds ? 32'h000f423f : 32'h000003e7} :// 最終トークンはnode 1へ入れる。
                                    {1'b0, 1'b1, 2'b00, 14'd1, 12'd0, send_count[0] ? 32'hFFFFFFFF : 32'h00000000}; 
wire send_count_over = send_count >= token_num_i_ds - 4'd1;
wire start_edge = ~start_buf & start_i_ds;

parameter DS_IDLE = 3'd0, DS_SEND = 3'd1, DS_WAIT_HS_READY = 3'd2, DS_WAIT_ACK_LOW = 3'd3,
             DS_WAIT_ACK_HIGH = 3'd4, DS_DONE = 3'd5;
reg [2:0] ds_state;
reg [2:0] next_ds_state;

assign send_done_o_ds = ds_state == DS_DONE;

// ds_state
always @(posedge clk) begin
    if(rst) begin
        ds_state <= DS_IDLE;
    end else begin
        ds_state <= next_ds_state;
    end
end

// next_ds_state
always @* begin
  case(ds_state)
    DS_IDLE :
    if(start_edge)                                     next_ds_state <= DS_WAIT_HS_READY;
    else                                               next_ds_state <= DS_IDLE;

    DS_WAIT_HS_READY :
    if(~send_o_ds & ~ack_i_ds)                         next_ds_state <= DS_SEND;
    else                                               next_ds_state <= DS_WAIT_HS_READY;

    DS_SEND :
    if(send_o_ds)                                      next_ds_state <= DS_WAIT_ACK_HIGH;
    else                                               next_ds_state <= DS_SEND;

    DS_WAIT_ACK_HIGH :
    if(send_o_ds & ack_i_ds)                           next_ds_state <= DS_WAIT_ACK_LOW;
    else                                               next_ds_state <= DS_WAIT_ACK_HIGH;

    DS_WAIT_ACK_LOW :
    if(~send_o_ds & ~ack_i_ds & ~send_count_over)      next_ds_state <= DS_SEND;
    else if(~send_o_ds & ~ack_i_ds & send_count_over)  next_ds_state <= DS_DONE;
    else                                               next_ds_state <= DS_WAIT_ACK_LOW;

    DS_DONE :
    next_ds_state <= DS_DONE;

    default  :
    next_ds_state <= DS_IDLE;
    endcase
end

// send_o_ds
always @(posedge clk) begin
    if(rst) begin
        send_o_ds <= 1'b0;
    end else if(ds_state == DS_SEND) begin
        send_o_ds <= 1'b1;
    end else if(ds_state == DS_WAIT_ACK_HIGH & send_o_ds & ack_i_ds) begin
        send_o_ds <= 1'b0;
    end else begin
        send_o_ds <= send_o_ds;
    end
end

// send_count
always @(posedge clk) begin
    if(rst) begin
        send_count <= 6'd0;
    end else if(start_edge) begin
        send_count <= 6'd0;
    end else if(ds_state == DS_WAIT_ACK_LOW & ~send_o_ds & ~ack_i_ds) begin
        send_count <= send_count + 6'd1;
    end else begin
        send_count <= send_count;
    end
end

// start_buf
always @(posedge clk) begin
    start_buf <= start_i_ds;
end

endmodule
