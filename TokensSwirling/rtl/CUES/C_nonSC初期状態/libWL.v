`timescale 1ps / 1ps

module AND2WL (
    Y,
    A,
    B,
    LOPEN
    );

input A;
input B;
input LOPEN;
output reg Y;

always @ (A, B) begin
    if (LOPEN) begin
        Y <= (A & B);
    end else begin
        Y <= Y;
    end
end

endmodule // NAND2WL


module AND3WL (
    Y,
    A,
    B,
    C,
    LOPEN
    );

input A;
input B;
input C;
input LOPEN;
output reg Y;

always @ (A, B, C) begin
    if(LOPEN) begin
        Y <= A & B & C;
    end else begin
        Y <= Y;
    end 
end

endmodule // AND3WL

// module NAND3WL (
//     Y,
//     A,
//     B,
//     C,
//     LOPEN
//     );

// input A;
// input B;
// input C;
// input LOPEN;
// output reg Y;

// always @ (A, B, C) begin
//     if(LOPEN) begin
//         Y <= ~(A & B & C);
//     end else begin
//         Y <= Y;
//     end 
// end

// endmodule // NAND3WL

// module NAND2WL (
//     Y,
//     A,
//     B,
//     LOPEN
//     );

// input A;
// input B;
// input LOPEN;
// output reg Y;

// always @ (A, B) begin
//     if (LOPEN) begin
//         Y <= ~(A & B);
//     end else begin
//         Y <= Y;
//     end
// end

// endmodule // NAND2WL

// module OR2WL (
//     A,
//     B,
//     Y,
//     LOPEN
//     );

// input A;
// input B;
// input LOPEN;
// output reg Y;

// always @ (A, B) begin
//     if(LOPEN) begin
//         Y <= A | B;
//     end else begin
//         Y <= Y;
//     end
// end

// endmodule // OR2WL

// module OR3WL (
//     A,
//     B,
//     C,
//     Y,
//     LOPEN
//     );

// input A;
// input B;
// input C;
// input LOPEN;
// output reg Y;

// always @ (A, B, C) begin
//     if(LOPEN) begin
//         Y <= A | B | C;
//     end else begin
//         Y <= Y;
//     end
// end

// endmodule // OR2WL

// module LCELL(
// in,
// out
// );
// input in;
// output out;
// (* dont_touch = "true" *) LUT1 #(.INIT(2'b10)) LUT1_inst (.O(out), .I0(in));
// endmodule // LCELL


(* dont_touch = "true" *) module S1R2FFLP(
    l,
    s,
    r,
    mr,
    pq,
    q
);

input l;
input s;
input r;
input mr;
output pq;
output q;

LUT4 #(
    .INIT(16'b0000000010001110) // Specify LUT Contents
) S1R2FFP_inst (
    .O(pq),   // LUT general output
    .I0(pq),  // LUT input
    .I1(s),   // LUT input
    .I2(r),   // LUT input
    .I3(mr)   // LUT input
);

LDCE #(
    .INIT(1'b0) // Initial value of latch (1'b0 or 1'b1)
) LDCE_inst (
    .Q(q), // Data output
    .CLR(1'b0), // Asynchronous clear/reset input
    .D(pq), // Data input
    .G(l), // Gate input
    .GE(1'b1) // Gate enable input
);

endmodule // S1R2FFLP

module NOR4L(
    l,
    a,
    b,
    c,
    d,
    q
);

(* dont_touch = "true" *) input l;
(* dont_touch = "true" *) input a;
(* dont_touch = "true" *) input b;
(* dont_touch = "true" *) input c;
(* dont_touch = "true" *) input d;
output q;


LDCE #(
    .INIT(1'b1) // Initial value of latch (1'b0 or 1'b1)
) LDCE_inst (
    .Q(q), // Data output
    .CLR(1'b0), // Asynchronous clear/reset input
    .D(~(a | b | c | d)), // Data input
    .G(l), // Gate input
    .GE(1'b1) // Gate enable input
);

endmodule // OR4L

module NOR5L(
    l,
    a,
    b,
    c,
    d,
    e,
    q
);

(* dont_touch = "true" *) input l;
(* dont_touch = "true" *) input a;
(* dont_touch = "true" *) input b;
(* dont_touch = "true" *) input c;
(* dont_touch = "true" *) input d;
(* dont_touch = "true" *) input e;
output q;


LDCE #(
    .INIT(1'b1) // Initial value of latch (1'b0 or 1'b1)
) LDCE_inst (
    .Q(q), // Data output
    .CLR(1'b0), // Asynchronous clear/reset input
    .D(~(a | b | c | d | e)), // Data input
    .G(l), // Gate input
    .GE(1'b1) // Gate enable input
);

endmodule // OR5L

module S1R1FFP (
    S,
    R,
    QP
    );

input   S;
input   R;
output  QP;

LUT3_L #(
    .INIT(8'b10001110) // Specify LUT Contents
) S1R1FFP_inst (
    .LO(QP),   // LUT general output
    .I0(QP),   // LUT input
    .I1(S),    // LUT input
    .I2(R)     // LUT input
);

endmodule // S1R1FFP

// module S1R2FFP (
//     s,
//     r,
//     mr,
//     q
//     );

// input   s;
// input   r;
// input   mr;
// output  q;

// LUT4_L #(
//     .INIT(16'b0000000010001110) // Specify LUT Contents
// ) S1R2FFP_inst (
//     .LO(q), // LUT general output
//     .I0(q), // LUT input
//     .I1(s), // LUT input
//     .I2(r), // LUT input
//     .I3(mr) // LUT input
// );

// endmodule // S1R2FFP

module S2R2FFP(
    S0,
    S1,
    R0,
    MR,
    QP
);
input S0;
input S1;
input R0;
input MR;
output QP;

LUT5_L #(
    .INIT(32'b00000000000000000000000011111110) // Specify LUT Contents
) S2R2FFP_inst (
    .LO(QP),   // LUT general output
    .I0(QP),   // LUT input
    .I1(S0),   // LUT input
    .I2(S1),   // LUT input
    .I3(R0),   // LUT input
    .I4(MR)    // LUT input
);

endmodule // S2R2FFP


// module S2R1FFP(
//     S0,
//     S1,
//     R0,
//     QP
// );
// input S0;
// input S1;
// input R0;
// output QP;

// LUT4_L #(
//     .INIT(16'b0000000011111110) // Specify LUT Contents
// ) S2R1FFP_inst (
//     .LO(QP),   // LUT general output
//     .I0(QP),   // LUT input
//     .I1(S0),   // LUT input
//     .I2(S1),   // LUT input
//     .I3(R0)   // LUT input
// );

// endmodule // S2R1FFP

module LCELL0(input IN, output OUT);

assign OUT = IN;

endmodule


module LCELL1(input IN, output OUT);

(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst1(.O(OUT), .I0(IN));

endmodule

module LCELL2(input IN, output OUT);
wire t0;

(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst1(.O(t0), .I0(IN));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst2(.O(OUT), .I0(t0));

endmodule

module LCELL3(input IN, output OUT);
wire t0;
wire t1;

(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst1(.O(t0), .I0(IN));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst2(.O(t1), .I0(t0));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst3(.O(OUT), .I0(t1));

endmodule

module LCELL4(input IN, output OUT);
wire t0;
wire t1;
wire t2;

(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst1(.O(t0), .I0(IN));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst2(.O(t1), .I0(t0));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst3(.O(t2), .I0(t1));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst4(.O(OUT), .I0(t2));

endmodule

module LCELL5(input IN, output OUT);
wire t0;
wire t1;
wire t2;
wire t3;

(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst1(.O(t0), .I0(IN));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst2(.O(t1), .I0(t0));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst3(.O(t2), .I0(t1));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst4(.O(t3), .I0(t2));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst5(.O(OUT), .I0(t3));

endmodule

module LCELL6(input IN, output OUT);
wire t0;
wire t1;
wire t2;
wire t3;
wire t4;

(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst1(.O(t0), .I0(IN));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst2(.O(t1), .I0(t0));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst3(.O(t2), .I0(t1));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst4(.O(t3), .I0(t2));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst5(.O(t4), .I0(t3));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst6(.O(OUT), .I0(t4));

endmodule

module LCELL7(input IN, output OUT);
wire t0;
wire t1;
wire t2;
wire t3;
wire t4;
wire t5;

(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst1(.O(t0), .I0(IN));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst2(.O(t1), .I0(t0));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst3(.O(t2), .I0(t1));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst4(.O(t3), .I0(t2));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst5(.O(t4), .I0(t3));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst6(.O(t5), .I0(t4));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst7(.O(OUT), .I0(t5));

endmodule

module LCELL8(input IN, output OUT);
wire t0;
wire t1;
wire t2;
wire t3;
wire t4;
wire t5;
wire t6;

(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst1(.O(t0), .I0(IN));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst2(.O(t1), .I0(t0));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst3(.O(t2), .I0(t1));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst4(.O(t3), .I0(t2));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst5(.O(t4), .I0(t3));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst6(.O(t5), .I0(t4));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst7(.O(t6), .I0(t5));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst8(.O(OUT), .I0(t6));

endmodule

module LCELL9(input IN, output OUT);
wire t0;
wire t1;
wire t2;
wire t3;
wire t4;
wire t5;
wire t6;
wire t7;

(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst1(.O(t0), .I0(IN));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst2(.O(t1), .I0(t0));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst3(.O(t2), .I0(t1));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst4(.O(t3), .I0(t2));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst5(.O(t4), .I0(t3));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst6(.O(t5), .I0(t4));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst7(.O(t6), .I0(t5));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst8(.O(t7), .I0(t6));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst9(.O(OUT), .I0(t7));

endmodule

module LCELL10(input IN, output OUT);
wire t0;
wire t1;
wire t2;
wire t3;
wire t4;
wire t5;
wire t6;
wire t7;
wire t8;

(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst1(.O(t0), .I0(IN));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst2(.O(t1), .I0(t0));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst3(.O(t2), .I0(t1));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst4(.O(t3), .I0(t2));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst5(.O(t4), .I0(t3));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst6(.O(t5), .I0(t4));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst7(.O(t6), .I0(t5));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst8(.O(t7), .I0(t6));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst9(.O(t8), .I0(t7));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst10(.O(OUT), .I0(t8));

endmodule

module LCELL11(input IN, output OUT);
wire t0;
wire t1;
wire t2;
wire t3;
wire t4;
wire t5;
wire t6;
wire t7;
wire t8;
wire t9;

(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst1(.O(t0), .I0(IN));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst2(.O(t1), .I0(t0));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst3(.O(t2), .I0(t1));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst4(.O(t3), .I0(t2));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst5(.O(t4), .I0(t3));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst6(.O(t5), .I0(t4));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst7(.O(t6), .I0(t5));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst8(.O(t7), .I0(t6));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst9(.O(t8), .I0(t7));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst10(.O(t9), .I0(t8));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst11(.O(OUT), .I0(t9));

endmodule

module LCELL12(input IN, output OUT);
wire t0;
wire t1;
wire t2;
wire t3;
wire t4;
wire t5;
wire t6;
wire t7;
wire t8;
wire t9;
wire t10;

(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst1(.O(t0), .I0(IN));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst2(.O(t1), .I0(t0));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst3(.O(t2), .I0(t1));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst4(.O(t3), .I0(t2));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst5(.O(t4), .I0(t3));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst6(.O(t5), .I0(t4));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst7(.O(t6), .I0(t5));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst8(.O(t7), .I0(t6));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst9(.O(t8), .I0(t7));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst10(.O(t9), .I0(t8));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst11(.O(t10), .I0(t9));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst12(.O(OUT), .I0(t10));

endmodule

module LCELL13(input IN, output OUT);
wire t0;
wire t1;
wire t2;
wire t3;
wire t4;
wire t5;
wire t6;
wire t7;
wire t8;
wire t9;
wire t10;
wire t11;

(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst1(.O(t0), .I0(IN));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst2(.O(t1), .I0(t0));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst3(.O(t2), .I0(t1));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst4(.O(t3), .I0(t2));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst5(.O(t4), .I0(t3));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst6(.O(t5), .I0(t4));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst7(.O(t6), .I0(t5));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst8(.O(t7), .I0(t6));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst9(.O(t8), .I0(t7));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst10(.O(t9), .I0(t8));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst11(.O(t10), .I0(t9));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst12(.O(t11), .I0(t10));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst13(.O(OUT), .I0(t11));

endmodule

module LCELL14(input IN, output OUT);
wire t0;
wire t1;
wire t2;
wire t3;
wire t4;
wire t5;
wire t6;
wire t7;
wire t8;
wire t9;
wire t10;
wire t11;
wire t12;

(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst1(.O(t0), .I0(IN));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst2(.O(t1), .I0(t0));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst3(.O(t2), .I0(t1));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst4(.O(t3), .I0(t2));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst5(.O(t4), .I0(t3));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst6(.O(t5), .I0(t4));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst7(.O(t6), .I0(t5));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst8(.O(t7), .I0(t6));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst9(.O(t8), .I0(t7));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst10(.O(t9), .I0(t8));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst11(.O(t10), .I0(t9));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst12(.O(t11), .I0(t10));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst13(.O(t12), .I0(t11));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst14(.O(OUT), .I0(t12));

endmodule

module LCELL15(input IN, output OUT);
wire t0;
wire t1;
wire t2;
wire t3;
wire t4;
wire t5;
wire t6;
wire t7;
wire t8;
wire t9;
wire t10;
wire t11;
wire t12;
wire t13;

(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst1(.O(t0), .I0(IN));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst2(.O(t1), .I0(t0));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst3(.O(t2), .I0(t1));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst4(.O(t3), .I0(t2));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst5(.O(t4), .I0(t3));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst6(.O(t5), .I0(t4));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst7(.O(t6), .I0(t5));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst8(.O(t7), .I0(t6));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst9(.O(t8), .I0(t7));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst10(.O(t9), .I0(t8));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst11(.O(t10), .I0(t9));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst12(.O(t11), .I0(t10));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst13(.O(t12), .I0(t11));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst14(.O(t13), .I0(t12));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst15(.O(OUT), .I0(t13));

endmodule

module LCELL16(input IN, output OUT);
wire t0;
wire t1;
wire t2;
wire t3;
wire t4;
wire t5;
wire t6;
wire t7;
wire t8;
wire t9;
wire t10;
wire t11;
wire t12;
wire t13;
wire t14;

(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst1(.O(t0), .I0(IN));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst2(.O(t1), .I0(t0));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst3(.O(t2), .I0(t1));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst4(.O(t3), .I0(t2));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst5(.O(t4), .I0(t3));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst6(.O(t5), .I0(t4));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst7(.O(t6), .I0(t5));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst8(.O(t7), .I0(t6));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst9(.O(t8), .I0(t7));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst10(.O(t9), .I0(t8));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst11(.O(t10), .I0(t9));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst12(.O(t11), .I0(t10));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst13(.O(t12), .I0(t11));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst14(.O(t13), .I0(t12));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst15(.O(t14), .I0(t13));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst16(.O(OUT), .I0(t14));

endmodule

module LCELL17(input IN, output OUT);
wire t0;
wire t1;
wire t2;
wire t3;
wire t4;
wire t5;
wire t6;
wire t7;
wire t8;
wire t9;
wire t10;
wire t11;
wire t12;
wire t13;
wire t14;
wire t15;

(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst1(.O(t0), .I0(IN));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst2(.O(t1), .I0(t0));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst3(.O(t2), .I0(t1));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst4(.O(t3), .I0(t2));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst5(.O(t4), .I0(t3));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst6(.O(t5), .I0(t4));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst7(.O(t6), .I0(t5));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst8(.O(t7), .I0(t6));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst9(.O(t8), .I0(t7));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst10(.O(t9), .I0(t8));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst11(.O(t10), .I0(t9));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst12(.O(t11), .I0(t10));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst13(.O(t12), .I0(t11));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst14(.O(t13), .I0(t12));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst15(.O(t14), .I0(t13));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst16(.O(t15), .I0(t14));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst17(.O(OUT), .I0(t15));

endmodule

module LCELL18(input IN, output OUT);
wire t0;
wire t1;
wire t2;
wire t3;
wire t4;
wire t5;
wire t6;
wire t7;
wire t8;
wire t9;
wire t10;
wire t11;
wire t12;
wire t13;
wire t14;
wire t15;
wire t16;

(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst1(.O(t0), .I0(IN));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst2(.O(t1), .I0(t0));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst3(.O(t2), .I0(t1));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst4(.O(t3), .I0(t2));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst5(.O(t4), .I0(t3));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst6(.O(t5), .I0(t4));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst7(.O(t6), .I0(t5));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst8(.O(t7), .I0(t6));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst9(.O(t8), .I0(t7));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst10(.O(t9), .I0(t8));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst11(.O(t10), .I0(t9));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst12(.O(t11), .I0(t10));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst13(.O(t12), .I0(t11));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst14(.O(t13), .I0(t12));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst15(.O(t14), .I0(t13));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst16(.O(t15), .I0(t14));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst17(.O(t16), .I0(t15));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst18(.O(OUT), .I0(t16));

endmodule

module LCELL19(input IN, output OUT);
wire t0;
wire t1;
wire t2;
wire t3;
wire t4;
wire t5;
wire t6;
wire t7;
wire t8;
wire t9;
wire t10;
wire t11;
wire t12;
wire t13;
wire t14;
wire t15;
wire t16;
wire t17;

(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst1(.O(t0), .I0(IN));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst2(.O(t1), .I0(t0));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst3(.O(t2), .I0(t1));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst4(.O(t3), .I0(t2));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst5(.O(t4), .I0(t3));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst6(.O(t5), .I0(t4));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst7(.O(t6), .I0(t5));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst8(.O(t7), .I0(t6));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst9(.O(t8), .I0(t7));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst10(.O(t9), .I0(t8));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst11(.O(t10), .I0(t9));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst12(.O(t11), .I0(t10));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst13(.O(t12), .I0(t11));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst14(.O(t13), .I0(t12));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst15(.O(t14), .I0(t13));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst16(.O(t15), .I0(t14));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst17(.O(t16), .I0(t15));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst18(.O(t17), .I0(t16));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst19(.O(OUT), .I0(t17));


endmodule

module LCELL20(input IN, output OUT);
wire t0;
wire t1;
wire t2;
wire t3;
wire t4;
wire t5;
wire t6;
wire t7;
wire t8;
wire t9;
wire t10;
wire t11;
wire t12;
wire t13;
wire t14;
wire t15;
wire t16;
wire t17;
wire t18;

(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst1(.O(t0), .I0(IN));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst2(.O(t1), .I0(t0));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst3(.O(t2), .I0(t1));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst4(.O(t3), .I0(t2));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst5(.O(t4), .I0(t3));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst6(.O(t5), .I0(t4));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst7(.O(t6), .I0(t5));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst8(.O(t7), .I0(t6));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst9(.O(t8), .I0(t7));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst10(.O(t9), .I0(t8));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst11(.O(t10), .I0(t9));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst12(.O(t11), .I0(t10));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst13(.O(t12), .I0(t11));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst14(.O(t13), .I0(t12));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst15(.O(t14), .I0(t13));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst16(.O(t15), .I0(t14));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst17(.O(t16), .I0(t15));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst18(.O(t17), .I0(t16));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst19(.O(t18), .I0(t17));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst20(.O(OUT), .I0(t18));

endmodule

module LCELL21(input IN, output OUT);
wire t0;
wire t1;
wire t2;
wire t3;
wire t4;
wire t5;
wire t6;
wire t7;
wire t8;
wire t9;
wire t10;
wire t11;
wire t12;
wire t13;
wire t14;
wire t15;
wire t16;
wire t17;
wire t18;
wire t19;

(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst1(.O(t0), .I0(IN));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst2(.O(t1), .I0(t0));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst3(.O(t2), .I0(t1));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst4(.O(t3), .I0(t2));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst5(.O(t4), .I0(t3));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst6(.O(t5), .I0(t4));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst7(.O(t6), .I0(t5));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst8(.O(t7), .I0(t6));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst9(.O(t8), .I0(t7));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst10(.O(t9), .I0(t8));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst11(.O(t10), .I0(t9));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst12(.O(t11), .I0(t10));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst13(.O(t12), .I0(t11));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst14(.O(t13), .I0(t12));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst15(.O(t14), .I0(t13));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst16(.O(t15), .I0(t14));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst17(.O(t16), .I0(t15));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst18(.O(t17), .I0(t16));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst19(.O(t18), .I0(t17));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst20(.O(t19), .I0(t18));
(* dont_touch = "true" *) LUT1 #(.INIT(2'b10)) LUT1_inst21(.O(OUT), .I0(t19));

endmodule

module LCELL22(input IN, output OUT);
wire t0;
wire t1;
wire t2;
wire t3;
wire t4;
wire t5;
wire t6;
wire t7;
wire t8;
wire t9;
wire t10;
wire t11;
wire t12;
wire t13;
wire t14;
wire t15;
wire t16;
wire t17;
wire t18;
wire t19;
wire t20;

(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst1(.O(t0), .I0(IN));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst2(.O(t1), .I0(t0));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst3(.O(t2), .I0(t1));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst4(.O(t3), .I0(t2));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst5(.O(t4), .I0(t3));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst6(.O(t5), .I0(t4));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst7(.O(t6), .I0(t5));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst8(.O(t7), .I0(t6));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst9(.O(t8), .I0(t7));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst10(.O(t9), .I0(t8));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst11(.O(t10), .I0(t9));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst12(.O(t11), .I0(t10));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst13(.O(t12), .I0(t11));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst14(.O(t13), .I0(t12));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst15(.O(t14), .I0(t13));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst16(.O(t15), .I0(t14));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst17(.O(t16), .I0(t15));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst18(.O(t17), .I0(t16));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst19(.O(t18), .I0(t17));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst20(.O(t19), .I0(t18));
(* dont_touch = "true" *) LUT1 #(.INIT(2'b10)) LUT1_inst21(.O(t20), .I0(t19));
(* dont_touch = "true" *) LUT1 #(.INIT(2'b10)) LUT1_inst22(.O(OUT), .I0(t20));

endmodule

module LCELL23(input IN, output OUT);
wire t0;
wire t1;
wire t2;
wire t3;
wire t4;
wire t5;
wire t6;
wire t7;
wire t8;
wire t9;
wire t10;
wire t11;
wire t12;
wire t13;
wire t14;
wire t15;
wire t16;
wire t17;
wire t18;
wire t19;
wire t20;
wire t21;

(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst1(.O(t0), .I0(IN));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst2(.O(t1), .I0(t0));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst3(.O(t2), .I0(t1));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst4(.O(t3), .I0(t2));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst5(.O(t4), .I0(t3));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst6(.O(t5), .I0(t4));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst7(.O(t6), .I0(t5));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst8(.O(t7), .I0(t6));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst9(.O(t8), .I0(t7));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst10(.O(t9), .I0(t8));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst11(.O(t10), .I0(t9));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst12(.O(t11), .I0(t10));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst13(.O(t12), .I0(t11));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst14(.O(t13), .I0(t12));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst15(.O(t14), .I0(t13));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst16(.O(t15), .I0(t14));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst17(.O(t16), .I0(t15));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst18(.O(t17), .I0(t16));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst19(.O(t18), .I0(t17));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst20(.O(t19), .I0(t18));
(* dont_touch = "true" *) LUT1 #(.INIT(2'b10)) LUT1_inst21(.O(t20), .I0(t19));
(* dont_touch = "true" *) LUT1 #(.INIT(2'b10)) LUT1_inst22(.O(t21), .I0(t20));
(* dont_touch = "true" *) LUT1 #(.INIT(2'b10)) LUT1_inst23(.O(OUT), .I0(t21));

endmodule

module LCELL24(input IN, output OUT);
wire t0;
wire t1;
wire t2;
wire t3;
wire t4;
wire t5;
wire t6;
wire t7;
wire t8;
wire t9;
wire t10;
wire t11;
wire t12;
wire t13;
wire t14;
wire t15;
wire t16;
wire t17;
wire t18;
wire t19;
wire t20;
wire t21;
wire t22;

(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst1(.O(t0), .I0(IN));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst2(.O(t1), .I0(t0));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst3(.O(t2), .I0(t1));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst4(.O(t3), .I0(t2));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst5(.O(t4), .I0(t3));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst6(.O(t5), .I0(t4));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst7(.O(t6), .I0(t5));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst8(.O(t7), .I0(t6));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst9(.O(t8), .I0(t7));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst10(.O(t9), .I0(t8));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst11(.O(t10), .I0(t9));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst12(.O(t11), .I0(t10));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst13(.O(t12), .I0(t11));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst14(.O(t13), .I0(t12));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst15(.O(t14), .I0(t13));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst16(.O(t15), .I0(t14));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst17(.O(t16), .I0(t15));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst18(.O(t17), .I0(t16));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst19(.O(t18), .I0(t17));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst20(.O(t19), .I0(t18));
(* dont_touch = "true" *) LUT1 #(.INIT(2'b10)) LUT1_inst21(.O(t20), .I0(t19));
(* dont_touch = "true" *) LUT1 #(.INIT(2'b10)) LUT1_inst22(.O(t21), .I0(t20));
(* dont_touch = "true" *) LUT1 #(.INIT(2'b10)) LUT1_inst23(.O(t22), .I0(t21));
(* dont_touch = "true" *) LUT1 #(.INIT(2'b10)) LUT1_inst24(.O(OUT), .I0(t22));

endmodule

module LCELL25(input IN, output OUT);
wire t0;
wire t1;
wire t2;
wire t3;
wire t4;
wire t5;
wire t6;
wire t7;
wire t8;
wire t9;
wire t10;
wire t11;
wire t12;
wire t13;
wire t14;
wire t15;
wire t16;
wire t17;
wire t18;
wire t19;
wire t20;
wire t21;
wire t22;
wire t23;

(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst1(.O(t0), .I0(IN));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst2(.O(t1), .I0(t0));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst3(.O(t2), .I0(t1));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst4(.O(t3), .I0(t2));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst5(.O(t4), .I0(t3));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst6(.O(t5), .I0(t4));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst7(.O(t6), .I0(t5));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst8(.O(t7), .I0(t6));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst9(.O(t8), .I0(t7));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst10(.O(t9), .I0(t8));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst11(.O(t10), .I0(t9));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst12(.O(t11), .I0(t10));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst13(.O(t12), .I0(t11));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst14(.O(t13), .I0(t12));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst15(.O(t14), .I0(t13));
(* dont_touch = "true" *) (* RLOC = "X1Y4" *) LUT1 #(.INIT(2'b10)) LUT1_inst16(.O(t15), .I0(t14));
(* dont_touch = "true" *) (* RLOC = "X1Y3" *) LUT1 #(.INIT(2'b10)) LUT1_inst17(.O(t16), .I0(t15));
(* dont_touch = "true" *) (* RLOC = "X1Y2" *) LUT1 #(.INIT(2'b10)) LUT1_inst18(.O(t17), .I0(t16));
(* dont_touch = "true" *) (* RLOC = "X1Y1" *) LUT1 #(.INIT(2'b10)) LUT1_inst19(.O(t18), .I0(t17));
(* dont_touch = "true" *) (* RLOC = "X1Y0" *) LUT1 #(.INIT(2'b10)) LUT1_inst20(.O(t19), .I0(t18));
(* dont_touch = "true" *) LUT1 #(.INIT(2'b10)) LUT1_inst21(.O(t20), .I0(t19));
(* dont_touch = "true" *) LUT1 #(.INIT(2'b10)) LUT1_inst22(.O(t21), .I0(t20));
(* dont_touch = "true" *) LUT1 #(.INIT(2'b10)) LUT1_inst23(.O(t22), .I0(t21));
(* dont_touch = "true" *) LUT1 #(.INIT(2'b10)) LUT1_inst24(.O(t23), .I0(t22));
(* dont_touch = "true" *) LUT1 #(.INIT(2'b10)) LUT1_inst25(.O(OUT), .I0(t23));

endmodule

