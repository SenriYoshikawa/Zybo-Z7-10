module TokensSwirling (
    clk,
    btn,
    led,
);

input clk;
input [3:0] btn;
output [3:0] led;

reg [3:0] count;
reg [3:0] preBtn;
assign led = count;
wire rst = btn[0];
wire countup = btn[1] && ~preBtn[1];
wire start = btn[2];

always @(posedge clk) begin
    preBtn <= btn;
end


always @(posedge clk) begin
    if (rst) begin
        count <= 4'd0;
    end else if (countup) begin
        count <= count + 4'd1;
    end
end

endmodule