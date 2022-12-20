module CELEMENT_Sw (
        RESETN,
        BRIN,
        SENDIN,
        ACKINA,
        ACKINB,
        LOPEN,
        SENDOUTA,
        SENDOUTB,
        ACKOUT,
        CP
        );

input   RESETN;
input   BRIN;
input   SENDIN;
input   ACKINA;
input   ACKINB;
input   LOPEN;
output  SENDOUTA;
output  SENDOUTB;
output  ACKOUT;
output  CP;

wire    RESETtoCORE;
wire    SENDINtoCORE;
wire    ACKINtoCORE;
wire    SENDOUTfromCORE;
wire    ACKOUTfromCORE;
wire    CPfromCORE;

wire    SENDOUT;
wire    BR;


CCORE uCCORE (
    .RESET  (RESETtoCORE),
    .SENDIN (SENDINtoCORE),
    .ACKIN  (ACKINtoCORE),
    .SENDOUT(SENDOUTfromCORE),
    .ACKOUT (ACKOUTfromCORE),
    .CP     (CPfromCORE),
    .LOPEN  (LOPEN)
    );

SCINV uRESET  (.YB(RESETtoCORE), .A(RESETN));

SENDDELAY_CELEMENT_Sw uSENDDELAY (.OUT(SENDOUT), .IN(SENDOUTfromCORE));
ACKDELAY_CELEMENT_Sw  uACKDELAY  (.OUT(ACKOUT),  .IN(ACKOUTfromCORE));

SCDFFQRB uBRLAT   (.CLK(SENDOUTfromCORE), .RB(RESETN), .DATA(BRIN), .Q(BR));
AND2WL   uSENDTXA (.Y(SENDOUTA), .A(SENDOUT), .B(~BR), .LOPEN(LOPEN));
AND2WL   uSENDTXB (.Y(SENDOUTB), .A(SENDOUT), .B(BR),  .LOPEN(LOPEN));

SCBUF    uSENDBUF (.Y(SENDINtoCORE), .A(SENDIN));
SCOR2    uACKRX   (.Y(ACKINtoCORE),  .A(ACKINA), .B(ACKINB));

SCCKBUFCL uCPOUT (.Y(CP), .A(CPfromCORE));

endmodule // CELEMENT_Sw

module SENDDELAY_CELEMENT_Sw (
    IN,
    OUT
    );

input   IN;
output  OUT;

LCELL4 uLCELL(IN, OUT); // SENDDELAY_CELEMENT_Sw

endmodule // SENDDELAY_CELEMENT_Sw

module ACKDELAY_CELEMENT_Sw (
    IN,
    OUT
    );

input   IN;
output  OUT;

assign OUT = IN;

endmodule // ACKDELAY_CELEMENT_Sw
