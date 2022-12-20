`timescale 1ps / 1ps

module CELEMENT_Exe1 (
        RESETN,
        EXBIN,
        CPYIN,
        SENDIN,
        ACKIN,
        LOPEN,
        SENDOUT,
        ACKOUT,
        FEBOUT,
        CP
        );

input   RESETN;
input   EXBIN;
input   CPYIN;
input   SENDIN;
input   ACKIN;
input   LOPEN;
output  SENDOUT;
output  ACKOUT;
output  FEBOUT;
output  CP;

wire    RESETtoCORE;
wire    SENDINtoCORE;
wire    SENDINtoCOREB;
wire    ACKINtoCOREA;
wire    ACKINtoCOREB;
wire    ACKINtoCOREAdelay;
wire    ACKINtoCOREBdelay;
wire    SENDOUTfromCOREA;
wire    SENDOUTfromCOREB;
wire    ACKOUTfromCORE;
wire    ACKOUTfromCOREB;
wire    CPfromCOREA;
wire    CPfromCOREB;

wire    SENDOUTA;
wire    SENDOUTAN;
wire    SENDOUTB;
wire    EXB;
wire    CPY;
wire    SENDCTRL;
wire    ACKMASK;
wire    ACKCTRL;
wire    ACKCTRLpre;
wire    ACKCTRLCLK;
wire    ACKCTRLRESETN;
wire    RESETDELAY;
wire    FEB;

buf #(8123, 5062) (ACKINtoCOREAdelay, ACKINtoCOREA);
buf #(7471, 4178) (ACKINtoCOREBdelay, ACKINtoCOREB);

CCORE uCCOREA (
        .RESET  (RESETtoCORE),
        .SENDIN (SENDINtoCORE),
        .ACKIN  (ACKINtoCOREAdelay),
        .SENDOUT(SENDOUTfromCOREA),
        .ACKOUT (ACKOUTfromCORE),
        .CP     (CPfromCOREA),
        .LOPEN  (LOPEN)
        );

CCORE uCCOREB (
        .RESET  (RESETtoCORE),
        .SENDIN (SENDINtoCOREB),
        .ACKIN  (ACKINtoCOREBdelay),
        .SENDOUT(SENDOUTfromCOREB),
        .ACKOUT (ACKOUTfromCOREB),
        .CP     (CPfromCOREB),
        .LOPEN  (LOPEN)
        );

SCINV uRESET  (.YB(RESETtoCORE), .A(RESETN));

SENDDELAYA_CELEMENT_Exe1 uSENDDELAYA (.OUT(SENDOUTA), .IN(SENDOUTfromCOREA));
SENDDELAYB_CELEMENT_Exe1 uSENDDELAYB (.OUT(SENDOUTB), .IN(SENDOUTfromCOREB));
ACKDELAY_CELEMENT_Exe1   uACKDELAY   (.OUT(ACKOUT),   .IN(ACKOUTfromCORE));

SCDFFQRB uEXBLAT  (.CLK(SENDOUTfromCOREA), .RB(RESETN), .DATA(EXBIN), .Q(EXB));
SCDFFQRB uCPYLAT  (.CLK(SENDOUTfromCOREA), .RB(RESETN), .DATA(CPYIN), .Q(CPY));

AND3WL  uSENDINB  (.Y(SENDINtoCOREB), .A(EXB), .B(CPY), .C(SENDOUTA), .LOPEN(LOPEN));
AND2WL  uSENDCTRL (.Y(SENDCTRL), .A(EXB), .B(SENDOUTA), .LOPEN(LOPEN));
AND2WL  uACKMASK  (.Y(ACKMASK), .A(~EXB), .B(SENDOUTA), .LOPEN(LOPEN));

SCNAND2  uACKCTRLRESETN (.YB(ACKCTRLRESETN), .A(ACKINtoCOREB), .B(ACKOUTfromCOREB));
SCNOR2   uACKCTRLCLK    (.YB(ACKCTRLCLK), .A(CPfromCOREB), .B(RESETtoCORE));
SCDFFQRB uACKCTRLLAT    (.CLK(ACKCTRLCLK), .RB(ACKCTRLRESETN), .DATA(1'b1), .Q(ACKCTRLpre));
SCOR2    uACKCTRL       (.Y(ACKCTRL), .A(~ACKCTRLpre), .B(RESETDELAY));

RESETDELAY_CELEMENT_Exe1 uRESETDELAY (.OUT(RESETDELAY), .IN(RESETtoCORE));

SCOR2 uSENDTX  (.Y(SENDOUT), .A(SENDCTRL), .B(SENDOUTB));
SCBUF uSENDBUF (.Y(SENDINtoCORE), .A(SENDIN));
SCBUF uACKBUF  (.Y(ACKINtoCOREB), .A(ACKIN));
SCOR3 uACKINA  (.Y(ACKINtoCOREA), .A(ACKINtoCOREB), .B(ACKMASK), .C(ACKCTRL));

SCCKBUFCL uCPOUT (.Y(CP), .A(CPfromCOREA));

S1R1FFP  uFEB (.QP(FEB), .S(CPfromCOREB), .R(CPfromCOREA));
FEBDELAY_CELEMENT_Exe1 uFEBOUT (.OUT(FEBOUT), .IN(FEB));

endmodule // CELEMENT_Exe1

module SENDDELAYA_CELEMENT_Exe1 (
        IN,
        OUT
        );

input   IN;
output  OUT;

LCELL8 uLCELL(IN, OUT); // SENDDELAYA_CELEMENT_Exe1
// buf #(12552, 12863) (OUT, IN);

endmodule // SENDDELAYA_CELEMENT_Exe1

module SENDDELAYB_CELEMENT_Exe1 (
        IN,
        OUT
        );

input   IN;
output  OUT;

LCELL14 uLCELL(IN, OUT); // SENDDELAYB_CELEMENT_Exe1
// buf #(5400, 5636) (OUT, IN);

endmodule // SENDDELAYB_CELEMENT_Exe1

module ACKDELAY_CELEMENT_Exe1 (
        IN,
        OUT
        );

input   IN;
output  OUT;

assign OUT = IN;

endmodule // ACKDELAY_CELEMENT_Exe1

module RESETDELAY_CELEMENT_Exe1 (
        IN,
        OUT
        );

input   IN;
output  OUT;

assign OUT = IN;

endmodule // RESETDELAY_CELEMENT_Exe1

module FEBDELAY_CELEMENT_Exe1 (
    IN,
    OUT
    );

input   IN;
output  OUT;

SCDLY04 uOUT  (.Y(OUT), .A(IN));

endmodule // FEBDELAY_CELEMENT_Exe1;
