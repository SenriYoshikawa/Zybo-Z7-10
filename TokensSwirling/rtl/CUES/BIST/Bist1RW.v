module Bist1RW (
		RST,
		D,
		CLK,
		WEN,
		A,
		Q,
		BistMode,
		BistFail,
		BistFinish
		);

   parameter RWIDTH = 34;
   parameter RDEPTH = 14;
   parameter W_ENABLE = 1'b0;
   parameter W_DISABLE = ~(W_ENABLE);

   input                RST;
   input [RWIDTH -1:0] 	D;
   input 		CLK;
   input 		BistMode;

   output 		WEN;
   output [RDEPTH -1:0] A;
   output [RWIDTH -1:0] Q;
   output 		BistFail;
   output 		BistFinish;
   
   reg 			ERR_FLG;
   reg [3:0] 		STATE;
   reg [RDEPTH:0] 	count;
   wire [RDEPTH:0] 	tmpcount;
   wire [RDEPTH:0] 	ud_count;
   reg 			allhigh;
   reg 			firstclk;
   reg 			down;
   reg 			WRITE_EN;

   assign 	 BistFail = ERR_FLG;

   assign 	 ud_count = (down == 1'b1)? {(RDEPTH+1){1'b1}}: {{(RDEPTH){1'b0}},{1'b1}};
   //assign 	 tmpcount = (down == 1'b1)? (count - 1) : (count + 1);
   assign 	 tmpcount = count + ud_count;
   assign 	 A = count[RDEPTH -1 :0];
   assign 	 Q = allhigh? {RWIDTH{1'b1}} : {RWIDTH{1'b0}};
   assign 	 WEN = WRITE_EN;
   assign 	 BistFinish = &STATE;
   
   parameter   INIT  = 4'b0000;
   parameter   L_R_0 = 4'b0001;
   parameter   L_W_1 = 4'b0011;
   parameter   L_R_1 = 4'b0010;
   parameter   L_W_0 = 4'b0110;
   parameter   H_R_0 = 4'b0111;
   parameter   H_W_1 = 4'b0101;
   parameter   H_R_1 = 4'b0100;
   parameter   H_W_0 = 4'b1100;
   parameter   FINAL = 4'b1101;
   parameter   FINSD = 4'b1111;

   parameter   C_CRRY = {1'b1,{RDEPTH{1'b0}}};
   parameter   C_ZERO = {1'b0,{RDEPTH{1'b0}}};
   parameter   ALL_ZERO = {RWIDTH{1'b0}};
   parameter   ALL_ONE = {RWIDTH{1'b1}};

   always @(posedge CLK or negedge RST)begin
      if(RST == 1'b0)begin
	 ERR_FLG <= 1'b0;
	 STATE <= INIT;
	 count <= C_ZERO;
	 allhigh <= 1'b0;
	 down <= 1'b0;
	 firstclk <= 1'b0;
	 WRITE_EN <= W_ENABLE; // to Write Mode
      end
      else if (BistMode == 1'b1) begin
	 case (STATE)
	   //*** Write all 0 ***
	   INIT:begin
	      if (count == C_CRRY)begin
		 count <= C_ZERO; // reset counter
		 WRITE_EN <= W_DISABLE; // to Read Mode
		 STATE <= L_R_0;
	      end
	      else begin
		 count <= tmpcount;
	      end
	   end
	   //*** Compare with 0 ***
	   L_R_0:begin
	      if (count == C_CRRY)begin
		 count <= C_ZERO; // reset counter
		 WRITE_EN <= W_ENABLE; // to Write Mode
		 allhigh <= 1'b1;
		 STATE <= L_W_1;
		 firstclk <= 1'b0;
	      end
	      else begin
		 if(firstclk == 1'b0)begin
		    firstclk <= 1'b1;
		 end
		 else if(D != ALL_ZERO)begin
		    ERR_FLG <= 1'b1;
		 end
		 count <= tmpcount;
	      end
	   end
	   //*** Write all 1 ***
	   L_W_1:begin
	      if (count == C_CRRY)begin
		 count <= C_ZERO; // reset counter
		 WRITE_EN <= W_DISABLE; // to Read Mode
		 STATE <= L_R_1;
	      end
	      else begin
		 count <= tmpcount;
	      end
	   end
	   //*** Compare with 1 ***
	   L_R_1:begin
	      if (count == C_CRRY)begin
		 count <= C_ZERO; // reset counter
		 WRITE_EN <= W_ENABLE; // to Write Mode
		 allhigh <= 1'b0;
		 STATE <= L_W_0;
		 firstclk <= 1'b0;
	      end
	      else begin
		 if(firstclk == 1'b0)begin
		    firstclk <= 1'b1;
		 end
		 else if(D != ALL_ONE)begin
		    ERR_FLG <= 1'b1;
		 end
		 count <= tmpcount;
	      end
	   end
	   //*** Write 0 ***
	   L_W_0:begin
	      if (count == C_CRRY)begin
		 count <= C_CRRY; // set carry
		 WRITE_EN <= W_DISABLE; // to Read Mode
		 STATE <= H_R_0;
		 down <= 1'b1; // set count down mode
	      end
	      else begin
		 count <= tmpcount;
	      end
	   end
	   //*** Count down to 0, Compare with 0 ***
	   H_R_0:begin
	      if (count == C_ZERO)begin
		 count <= C_CRRY; // set carry
		 WRITE_EN <= W_ENABLE; // to Write Mode
		 allhigh <= 1'b1;
		 STATE <= H_W_1;
		 firstclk <= 1'b0;
	      end
	      else begin
		 if(firstclk == 1'b0)begin
		    firstclk <= 1'b1;
		 end
		 else if(D != ALL_ZERO)begin
		    ERR_FLG <= 1'b1;
		 end
		 count <= tmpcount;
	      end
	   end
	   //*** Count down to 0, Write 1 ***
	   H_W_1:begin
	      if (count == C_ZERO)begin
		 count <= C_CRRY; // set carry
		 WRITE_EN <= W_DISABLE; // to Read Mode
		 STATE <= H_R_1;
	      end
	      else begin
		 count <= tmpcount;
	      end
	   end
	   //*** Count down to 0, Compare with 1 ***
	   H_R_1:begin
	      if (count == C_ZERO)begin
		 count <= C_CRRY; // set carry
		 WRITE_EN <= W_ENABLE; // to Write Mode
		 allhigh <= 1'b0;
		 STATE <= H_W_0;
		 firstclk <= 1'b0;
	      end
	      else begin
		 if(firstclk == 1'b0)begin
		    firstclk <= 1'b1;
		 end
		 else if(D != ALL_ONE)begin
		    ERR_FLG <= 1'b1;
		 end
		 count <= tmpcount;
	      end
	   end
	   //*** Count down to 0, Write 0 ***
	   H_W_0:begin
	      if (count == C_ZERO)begin
		 count <= C_CRRY; // set carry
		 WRITE_EN <= W_DISABLE; // to Read Mode
		 STATE <= FINAL;
	      end
	      else begin
	      /*
	        if (count == 15'b011_1111_1111_0000)begin
		   allhigh <= 1'b1;
		   count <= tmpcount;
	        end
	        else begin
		   count <= tmpcount;
	        end
	      */
	      ///*
		 count <= tmpcount;
	      //*/
	      end
	   end
	   //*** Count down to 0, Compare with 0 ***
	   FINAL:begin
	      if (count == C_ZERO)begin
		 STATE <= FINSD;
	      end
              else begin
		 if(firstclk == 1'b0)begin
		    firstclk <= 1'b1;
		 end
		 else if(D != ALL_ZERO)begin
		    ERR_FLG <= 1'b1;
		 end
		 count <= tmpcount;
	      end
	   end
	   //*** ***
	   FINSD:begin
	      // Nothing will Change
	   end 
	 endcase // case(STATE)
      end // if (BistMode == 1'b1)
      
   end // always @ (posedge CLK)

endmodule
