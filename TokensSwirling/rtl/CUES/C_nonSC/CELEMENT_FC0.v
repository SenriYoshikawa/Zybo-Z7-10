module CELEMENT_FC0 (RESETN,
                 SENDIN,
                 ACKIN,
                 LOPEN,
                 SENDOUT,
                 ACKOUT,
                 CP);

input   RESETN;
input   SENDIN;
input   ACKIN;
input   LOPEN;
output  SENDOUT;
output  ACKOUT;
output  CP;

wire    RESETtoCORE;
wire    SENDINtoCORE;
wire    ACKINtoCORE;
wire    SENDOUTfromCORE;
wire    ACKOUTfromCORE;
wire    CPfromCORE;


CCORE uCCORE (
    .RESET  (RESETtoCORE),
    .SENDIN (SENDINtoCORE),
    .ACKIN  (ACKINtoCORE),
    .SENDOUT(SENDOUTfromCORE),
    .ACKOUT (ACKOUTfromCORE),
    .CP     (CPfromCORE),
    .LOPEN  (LOPEN)
);

SCINV uRESET (.YB(RESETtoCORE), .A(RESETN));

SENDDELAY_CELEMENT_FC0 uSENDDELAY (.OUT(SENDOUT), .IN(SENDOUTfromCORE));
ACKDELAY_CELEMENT_FC0  uACKDELAY  (.OUT(ACKOUT),  .IN(ACKOUTfromCORE));

SCBUF uSENDBUF (.Y(SENDINtoCORE), .A(SENDIN));
SCBUF uACKBUF  (.Y(ACKINtoCORE),  .A(ACKIN));

SCCKBUFCL uCPOUT (.Y(CP), .A(CPfromCORE));

endmodule // CELEMENT_FC0
    
module SENDDELAY_CELEMENT_FC0 (
    IN,
    OUT
    );

input   IN;
output  OUT;

LCELL12 uLCELL(IN, OUT); // SENDDELAY_CELEMENT_FC0
// assign OUT = IN;
    
endmodule // SENDDELAY_CELEMENT_FC0
        
module ACKDELAY_CELEMENT_FC0 (
    IN,
    OUT
    );
    
input   IN;
output  OUT;

assign OUT = IN;
    
endmodule // ACKDELAY_CELEMENT_FC0
