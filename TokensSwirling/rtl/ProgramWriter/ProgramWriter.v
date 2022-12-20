module ProgramWriter(
    input clk,
    input rst,
    input scpen_i_pw,
    input start_i_pw,
    input ack_i_pw,
    output reg send_o_pw,
    output [61:0] token_o_pw,
    output write_done_o_pw
);

wire [5:0] program_num = 6'd4;
wire [61:0] program_data[3:0];
assign program_data[0] = 62'h180000026e000000; // @0 nop.a
assign program_data[1] = 62'h1800100382010021; // @1 subi.z
assign program_data[2] = 62'h1800200040000000; // @2 out.a
// assign program_data[3] = 62'h1400000A00000000; // sysreg short path enable
// assign program_data[3] = 62'h1400000A00000001; // sysreg short path disable
assign program_data[3] = scpen_i_pw ?  62'h1400000A00000000  : 62'h1400000A00000001; // sysreg short path


reg start_buf;
wire start_edge = ~start_buf & start_i_pw;
reg [5:0] program_count;
wire program_count_over = program_count >= program_num - 6'd1;

parameter PW_IDLE = 3'd0, PW_SEND = 3'd1, PW_WAIT_HS_READY = 3'd2, PW_WAIT_ACK_LOW = 3'd3, PW_WAIT_ACK_HIGH = 3'd4, PW_DONE = 3'd5;
reg [2:0] pw_state;
reg [2:0] next_pw_state;

assign token_o_pw = program_data[program_count];
assign write_done_o_pw = pw_state == PW_DONE;

// pw_state
always @(posedge clk) begin
    if(rst) begin
        pw_state <= PW_IDLE;
    end else begin
        pw_state <= next_pw_state;
    end
end

// next_pw_state
always @* begin
  case(pw_state)
    PW_IDLE :
    if(start_edge)                                       next_pw_state <= PW_WAIT_HS_READY;
    else                                                 next_pw_state <= PW_IDLE;

    PW_WAIT_HS_READY :
    if(~send_o_pw & ~ack_i_pw)                           next_pw_state <= PW_SEND;
    else                                                 next_pw_state <= PW_WAIT_HS_READY;

    PW_SEND :
    if(send_o_pw)                                        next_pw_state <= PW_WAIT_ACK_HIGH;
    else                                                 next_pw_state <= PW_SEND;

    PW_WAIT_ACK_HIGH :
    if(send_o_pw & ack_i_pw)                             next_pw_state <= PW_WAIT_ACK_LOW;
    else                                                 next_pw_state <= PW_WAIT_ACK_HIGH;

    PW_WAIT_ACK_LOW :
    if(~send_o_pw & ~ack_i_pw & ~program_count_over)     next_pw_state <= PW_SEND;
    else if(~send_o_pw & ~ack_i_pw & program_count_over) next_pw_state <= PW_DONE;
    else                                                 next_pw_state <= PW_WAIT_ACK_LOW;

    PW_DONE :
    next_pw_state <= PW_DONE;

    default  :
    next_pw_state <= PW_IDLE;
    endcase
end

// start_buf
always @(posedge clk) begin
    start_buf <= start_i_pw;
end

// send_o_pw
always @(posedge clk) begin
    if(rst) begin
        send_o_pw <= 1'b0;
    end else if(pw_state == PW_SEND) begin
        send_o_pw <= 1'b1;
    end else if(pw_state == PW_WAIT_ACK_HIGH & send_o_pw & ack_i_pw) begin
        send_o_pw <= 1'b0;
    end else begin
        send_o_pw <= send_o_pw;
    end
end

// program_count
always @(posedge clk) begin
    if(rst) begin
        program_count <= 6'd0;
    end else if(start_edge) begin
        program_count <= 6'd0;
    end else if(pw_state == PW_WAIT_ACK_LOW & ~send_o_pw & ~ack_i_pw) begin
        program_count <= program_count + 6'd1;
    end else begin
        program_count <= program_count;
    end
end

endmodule
