`timescale 1ps / 1ps

module CCORE (RESET,
              SENDIN,
              ACKIN,
              SENDOUT,
              ACKOUT,
              CP,
              LOPEN
              );
    
input   RESET;
input   SENDIN;
input   ACKIN;
input   LOPEN;
output  SENDOUT;
output  ACKOUT;
output  CP;
wire start;
wire beforestart;
wire beforecp;
assign ACKOUT = beforestart;

S1R2FFLP uISRP(.l(LOPEN), .s(SENDIN), .r(start), .mr(RESET), .q(beforestart));

NOR4L uSTARTGATE(.l(LOPEN), .a(~beforestart), .b(ACKIN), .c(SENDOUT), .d(SENDIN), .q(start));

S1R2FFLP uOSRP(.l(LOPEN), .s(start), .r(ACKIN), .mr(RESET), .q(SENDOUT), .pq(beforecp));

LDCE #(
    .INIT(1'b0)   // Initial value of latch (1'b0 or 1'b1)
) LDCE_inst (
    .Q(CP),       // Data output
    .CLR(1'b0),   // Asynchronous clear/reset input
    .D(beforecp), // Data input
    .G(LOPEN),    // Gate input
    .GE(1'b1)     // Gate enable input
);

endmodule // CCORE

module CCOREG (G,
              RESET,
              SENDIN,
              ACKIN,
              SENDOUT,
              ACKOUT,
              CP,
              LOPEN
              );
    
input   G;
input   RESET;
input   SENDIN;
input   ACKIN;
input   LOPEN;
output  SENDOUT;
output  ACKOUT;
output  CP;
wire start;
wire beforestart;
wire beforecp;
assign ACKOUT = beforestart;

S1R2FFLP uISRP(.l(LOPEN), .s(SENDIN), .r(start), .mr(RESET), .q(beforestart));

NOR5L uSTARTGATE(.l(LOPEN), .a(~beforestart), .b(G), .c(ACKIN), .d(SENDOUT), .e(SENDIN), .q(start));

S1R2FFLP uOSRP(.l(LOPEN), .s(start), .r(ACKIN), .mr(RESET), .q(SENDOUT), .pq(beforecp));

LDCE #(
    .INIT(1'b0)   // Initial value of latch (1'b0 or 1'b1)
) LDCE_inst (
    .Q(CP),       // Data output
    .CLR(1'b0),   // Asynchronous clear/reset input
    .D(beforecp), // Data input
    .G(LOPEN),    // Gate input
    .GE(1'b1)     // Gate enable input
);

endmodule // CCORE
