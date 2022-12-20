module CELEMENT_Exe0 (RESETN,
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

SENDDELAY_CELEMENT_Exe0 uSENDDELAY (.OUT(SENDOUT), .IN(SENDOUTfromCORE));
ACKDELAY_CELEMENT_Exe0  uACKDELAY  (.OUT(ACKOUT),  .IN(ACKOUTfromCORE));

SCBUF uSENDBUF (.Y(SENDINtoCORE), .A(SENDIN));
SCBUF uACKBUF  (.Y(ACKINtoCORE),  .A(ACKIN));

SCCKBUFCL uCPOUT (.Y(CP), .A(CPfromCORE));

endmodule // CELEMENT_Exe0
    
module SENDDELAY_CELEMENT_Exe0 (
    IN,
    OUT
    );

input   IN;
output  OUT;

LCELL0 uLCELL(IN, OUT); // SENDDELAY_CELEMENT_Exe0
// assign OUT = IN;
    
endmodule // SENDDELAY_CELEMENT_Exe0
        
module ACKDELAY_CELEMENT_Exe0 (
    IN,
    OUT
    );
    
input   IN;
output  OUT;

assign OUT = IN;
    
endmodule // ACKDELAY_CELEMENT_Exe0
