`timescale 1ps/1ps

module CELEMENT_Mer(RESETN,
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

SENDOUTDELAY_CELEMENT_M_A uSENDDELAYA (.OUT(SENDOUTA), .IN(SENDOUTfromCOREA));
SENDOUTDELAY_CELEMENT_M_B uSENDDELAYB (.OUT(SENDOUTB), .IN(SENDOUTfromCOREB));
ACKINDELAY_CELEMENT_M_A  uACKINDELAYA (.OUT(ACKINtoCOREA),  .IN(ACKIN));
ACKINDELAY_CELEMENT_M_B  uACKINDELAYB (.OUT(ACKINtoCOREB),  .IN(ACKIN));
ACKOUTDELAY_CELEMENT_M_A  uACKDELAYA  (.OUT(ACKOUTA),  .IN(ACKOUTfromCOREA));
ACKOUTDELAY_CELEMENT_M_B  uACKDELAYB  (.OUT(ACKOUTB),  .IN(ACKOUTfromCOREB));
G_DElAY_CELEMENT_M        uGDELAYA    (.OUT(GINAdelay), .IN(GINA));
G_DElAY_CELEMENT_M        uGDELAYB    (.OUT(GINBdelay), .IN(GINB));

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
    
module SENDOUTDELAY_CELEMENT_M_A (
    IN,
    OUT
    );
    
input   IN;
output  OUT;

LCELL0 uLCELL(IN, OUT); // SENDOUTDELAY_CELEMENT_M_A
// buf #(5838, 8896) (OUT, IN); 

endmodule // SENDOUTDELAY_CELEMENT_M_A

module SENDOUTDELAY_CELEMENT_M_B (
    IN,
    OUT
    );
    
input   IN;
output  OUT;

LCELL0 uLCELL(IN, OUT); // SENDOUTDELAY_CELEMENT_M_B
// buf #(5867, 9085) (OUT, IN); 
    
endmodule // SENDOUTDELAY_CELEMENT_M_B

module ACKINDELAY_CELEMENT_M_A (
    IN,
    OUT
    );
    
input   IN;
output  OUT;
buf #(7796, 3754) (OUT, IN); // ACKINDELAY_CELEMENT_M_A

endmodule // ACKINDELAY_CELEMENT_M_A

module ACKINDELAY_CELEMENT_M_B (
    IN,
    OUT
    );
    
input   IN;
output  OUT;
buf #(7527, 3935) (OUT, IN); // ACKINDELAY_CELEMENT_M_B

endmodule // ACKINDELAY_CELEMENT_M_B

module ACKOUTDELAY_CELEMENT_M_A (
    IN,
    OUT
    );

input   IN;
output  OUT;
// LCELL1 uLCELL(IN, OUT); // ACKOUTDELAY_CELEMENT_M_A
assign OUT = IN;

endmodule // ACKOUTDELAY_CELEMENT_M_A

module ACKOUTDELAY_CELEMENT_M_B (
    IN,
    OUT
    );
    
input   IN;
output  OUT;

// LCELL1 uLCELL(IN, OUT); // ACKOUTDELAY_CELEMENT_M_B
assign OUT = IN;
    
endmodule // ACKOUTDELAY_CELEMENT_M_B
            
module AEB (
    RESET,
    CPA,
    CPB,
    AEB
    );
    
input   RESET;
input   CPA;
input   CPB;
output  AEB;

LUT4 #(
    .INIT(16'b0000000011010100)
) AEB_inst (
    .O(AEB),
    .I0(CPA),
    .I1(CPB),
    .I2(AEB),
    .I3(RESET)
);
    
endmodule // AEB
   
module ARB (
    RESET,
    CIA,
    ROA,
    CPA,
    CIB,
    ROB,
    CPB,
    LOPEN,
    GA,
    GB
    );

input   RESET;
input   CIA;
input   ROA;
input   CPA;
input   CIB;
input   ROB;
input   CPB;
input   LOPEN;
output  GA;
output  GB;

wire    arb_a0;
wire    arb_b0;
wire    arb_a1;
wire    arb_b1;
wire    arb_a2;
wire    arb_b2;
wire    arb_a3;
wire    arb_b3;

S2R2FFP uRS1A (.QP(arb_a0), .S0(CIA), .S1(ROA), .R0(CPA), .MR(RESET));
S2R2FFP uRS1B (.QP(arb_b0), .S0(CIB), .S1(ROB), .R0(CPB), .MR(RESET));

LDCE #(.INIT(1'b0)) LDCE_inst1a (.Q(arb_a1), .CLR(1'b0), .D(arb_a0), .G(LOPEN), .GE(1'b1));
LDCE #(.INIT(1'b0)) LDCE_inst1b (.Q(arb_b1), .CLR(1'b0), .D(arb_b0), .G(LOPEN), .GE(1'b1));

SCNOR2 uARB2a(.YB(arb_a2), .A(arb_a1), .B(arb_b2));
SCNOR3 uARB2b(.YB(arb_b2), .A(arb_b1), .B(arb_a2), .C(RESET));
SCNOR2 uARB3a(.YB(arb_a3), .A(arb_a2), .B(arb_b3));
SCNOR2 uARB3b(.YB(arb_b3), .A(arb_b2), .B(arb_a3));

assign GA = arb_a3;
assign GB = arb_b3;

endmodule // ARB

module ARB_IN_DELAY (
    IN,
    OUT 
    );
    
input   IN;
output  OUT;

assign OUT = IN;
    
endmodule // ARB_IN_DELAY

module G_DElAY_CELEMENT_M (
    IN,
    OUT
    );
    
input   IN;
output  OUT;

buf #(1000, 1000) (OUT, IN);
endmodule // G_DElAY_CELEMENT_M