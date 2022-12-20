`timescale 1ps / 1ps

module CELEMENT_SM(RESETN,
                   SENDINA,
                   SENDINB,
                   ACKIN,
                   LOPEN,
                   SENDOUT,
                   ACKOUTA,
                   ACKOUTB,
                   AEBOUT,
                   CPA,
                   CPB);

input   RESETN;
input   SENDINA;
input   SENDINB;
input   ACKIN;
input   LOPEN;
output  SENDOUT;
output  ACKOUTA;
output  ACKOUTB;
output  AEBOUT;
output  CPA;
output  CPB;

wire    RESETtoCORE;
wire    ACKINtoCOREA;
wire    ACKINtoCOREB;
wire    SENDINtoCOREA;
wire    SENDOUTfromCOREA;
wire    ACKOUTfromCOREA;
wire    CPfromCOREA;
wire    SENDINtoCOREB;
wire    SENDOUTfromCOREB;
wire    ACKOUTfromCOREB;
wire    CPfromCOREB;

wire    SENDOUTA;
wire    SENDOUTB;
wire    GA;
wire    GINA;
wire    GINAdelay;
wire    GB;
wire    GINB;
wire    GINBdelay;
wire    CPAdelay;
wire    CPBdelay;

CCOREG uCCOREA (
    .G      (GINAdelay),
    .RESET  (RESETtoCORE),
    .SENDIN (SENDINtoCOREA),
    .ACKIN  (ACKINtoCOREA),
    .SENDOUT(SENDOUTfromCOREA),
    .ACKOUT (ACKOUTfromCOREA),
    .CP     (CPfromCOREA),
    .LOPEN  (LOPEN)
);

CCOREG uCCOREB (
    .G      (GINBdelay),
    .RESET  (RESETtoCORE),
    .SENDIN (SENDINtoCOREB),
    .ACKIN  (ACKINtoCOREB),
    .SENDOUT(SENDOUTfromCOREB),
    .ACKOUT (ACKOUTfromCOREB),
    .CP     (CPfromCOREB),
    .LOPEN  (LOPEN)
);

ARB_IN_DELAY uARB_IN_DELAY_A (.IN(SENDOUTfromCOREA), .OUT(CPAdelay));
ARB_IN_DELAY uARB_IN_DELAY_B (.IN(SENDOUTfromCOREB), .OUT(CPBdelay));

ARB uARB (
    .RESET  (RESETtoCORE),
    .CIA    (SENDINtoCOREA),
    .ROA    (ACKOUTfromCOREA),
    .CPA    (CPAdelay),
    .CIB    (SENDINtoCOREB),
    .ROB    (ACKOUTfromCOREB),
    .CPB    (CPBdelay),
    .GA     (GA),
    .GB     (GB),
    .LOPEN  (LOPEN)
);

SCINV uRESET (.YB(RESETtoCORE), .A(RESETN));

SENDOUTDELAY_CELEMENT_SM_A uSENDDELAYA (.OUT(SENDOUTA), .IN(SENDOUTfromCOREA));
SENDOUTDELAY_CELEMENT_SM_B uSENDDELAYB (.OUT(SENDOUTB), .IN(SENDOUTfromCOREB));
ACKINDELAY_CELEMENT_SM_A   uACKINDELAYA (.OUT(ACKINtoCOREA), .IN(ACKIN));
ACKINDELAY_CELEMENT_SM_B   uACKINDELAYB (.OUT(ACKINtoCOREB), .IN(ACKIN));
ACKOUTDELAY_CELEMENT_SM_A  uACKDELAYA (.OUT(ACKOUTA), .IN(ACKOUTfromCOREA));
ACKOUTDELAY_CELEMENT_SM_B  uACKDELAYB (.OUT(ACKOUTB), .IN(ACKOUTfromCOREB));
G_DElAY_CELEMENT_M         uGDELAYA (.OUT(GINAdelay), .IN(GINA));
G_DElAY_CELEMENT_M         uGDELAYB (.OUT(GINBdelay), .IN(GINB));

SCOR2 uSENDTX   (.Y(SENDOUT), .A(SENDOUTA), .B(SENDOUTB));

SCBUF uSENDBUFA (.Y(SENDINtoCOREA), .A(SENDINA));
SCBUF uSENDBUFB (.Y(SENDINtoCOREB), .A(SENDINB));

SCCKBUFCL uCPOUTA (.Y(CPA), .A(CPfromCOREA));
SCCKBUFCL uCPOUTB (.Y(CPB), .A(CPfromCOREB));

SCNAND2 uGINA (.YB(GINA), .A(GA), .B(~SENDOUTfromCOREB));
SCNAND2 uGINB (.YB(GINB), .A(GB), .B(~SENDOUTfromCOREA));

AEB uAEB (
    .RESET  (RESETtoCORE),
    .CPA    (CPfromCOREA),
    .CPB    (CPfromCOREB),
    .AEB    (AEBOUT)
);

endmodule // CELEMENT_M
    
module SENDOUTDELAY_CELEMENT_SM_A (
    IN,
    OUT
    );
    
input   IN;
output  OUT;

LCELL0 uLCELL(IN, OUT); // SENDOUTDELAY_CELEMENT_SM_A
// buf #(5891, 9109) (OUT, IN);
    
endmodule // SENDOUTDELAY_CELEMENT_SM_A

module SENDOUTDELAY_CELEMENT_SM_B (
    IN,
    OUT
    );
    
input   IN;
output  OUT;

LCELL0 uLCELL(IN, OUT); // SENDOUTDELAY_CELEMENT_SM_B
// buf #(5907, 9101) (OUT, IN);

endmodule // SENDOUTDELAY_CELEMENT_SM_B

module ACKINDELAY_CELEMENT_SM_A (
    IN,
    OUT
    );
    
input   IN;
output  OUT;
buf #(9042, 4528) (OUT, IN); // ACKINDELAY_CELEMENT_SM_A

endmodule // ACKINDELAY_CELEMENT_SM_A

module ACKINDELAY_CELEMENT_SM_B (
    IN,
    OUT
    );
    
input   IN;
output  OUT;
buf #(8174, 4082) (OUT, IN); // ACKINDELAY_CELEMENT_SM_B

endmodule // ACKINDELAY_CELEMENT_SM_B

module ACKOUTDELAY_CELEMENT_SM_A (
    IN,
    OUT
    );
    
input   IN;
output  OUT;
assign OUT = IN;

endmodule // ACKOUTDELAY_CELEMENT_SM_A

module ACKOUTDELAY_CELEMENT_SM_B (
    IN,
    OUT
    );
    
input   IN;
output  OUT;

assign OUT = IN;
    
endmodule // ACKOUTDELAY_CELEMENT_SM_B
