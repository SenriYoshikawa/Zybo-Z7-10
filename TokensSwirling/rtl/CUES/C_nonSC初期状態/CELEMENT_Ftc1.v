module CELEMENT_Ftc1 (
        RESETN,
        EXBIN,
        SENDIN,
        ACKIN,
        LOPEN,
        SENDOUT,
        ACKOUT,
        CP
        );

input   RESETN;
input   EXBIN;
input   SENDIN;
input   ACKIN;
input   LOPEN;
output  SENDOUT;
output  ACKOUT;
output  CP;

wire    RESETtoCORE;
wire    ACKINtoCORE;
wire    SENDOUTfromCORE;
wire    ACKOUTfromCORE;
wire    CPfromCORE;

wire    SENDOUTpre;
wire    EXB;
wire    ACKMASK;


CCORE uCCORE (
    .RESET    (RESETtoCORE),
    .SENDIN   (SENDIN),
    .ACKIN    (ACKINtoCORE),
    .SENDOUT  (SENDOUTfromCORE),
    .ACKOUT   (ACKOUTfromCORE),
    .CP       (CPfromCORE),
    .LOPEN    (LOPEN)
    );

SCINV uRESET    (.YB(RESETtoCORE), .A(RESETN));

SENDDELAY_CELEMENT_Ftc1 uSENDDELAY (.OUT(SENDOUTpre), .IN(SENDOUTfromCORE));
ACKDELAY_CELEMENT_Ftc1  uACKDELAY  (.OUT(ACKOUT),     .IN(ACKOUTfromCORE));

SCDFFQRB uEXBLAT  (.CLK(SENDOUTfromCORE), .RB(RESETN), .DATA(EXBIN), .Q(EXB));
AND2WL   uSENDEX  (.Y(SENDOUT), .A(SENDOUTpre), .B(EXB),  .LOPEN(LOPEN));
AND2WL   uACKMASK (.Y(ACKMASK), .A(SENDOUTpre), .B(~EXB), .LOPEN(LOPEN));

SCOR2    uACKRX   (.Y(ACKINtoCORE), .A(ACKIN), .B(ACKMASK));

SCCKBUFCL uCPOUT (.Y(CP), .A(CPfromCORE));

endmodule // CELEMENT_Ftc1

module SENDDELAY_CELEMENT_Ftc1 (
    IN,
    OUT
    );

input   IN;
output  OUT;

LCELL0 uLCELL(IN, OUT); // SENDDELAY_CELEMENT_Ftc1
// assign OUT = IN;

endmodule // SENDDELAY_CELEMENT_Ftc1

module ACKDELAY_CELEMENT_Ftc1 (
    IN,
    OUT
    );

input   IN;
output  OUT;

assign OUT = IN;

endmodule // ACKDELAY_CELEMENT_Ftc1
