`timescale 1ps / 1ps

module TokensSwirlingTest;

// for pattern input //////////////////////////////////////////////////////////  
  reg         clk;
  reg [3:0]   btn;
  reg [3:0]   sw;
  
  initial clk = 1'b0;
  always begin
      #5000 clk = ~clk;
  end

// output of target /////////////////////////////////////////////////////////////////////
  wire [3:0] led;
  wire       led6_r;
  wire       led6_g;
  wire       led6_b;
  wire [7:0] je;

  //####  Target module ####
  TokensSwirling uTokensSwirling (
    .clk(clk),
    .btn(btn),
    .sw(sw),
    .led(led),
    .led6_r(led6_r),
    .led6_g(led6_g),
    .led6_b(led6_b),
    .je(je)
  );

  wire token_sMer = (uTokensSwirling.uCUES.sMer.uCM_Mer.ACKIN | uTokensSwirling.uCUES.sMer.uCM_Mer.SENDOUT);
  wire token_sFC0 = (uTokensSwirling.uCUES.sFC0.uC_FC0.ACKIN | uTokensSwirling.uCUES.sFC0.uC_FC0.SENDOUT);
  wire token_sFC1 = (uTokensSwirling.uCUES.sFC1.uCEX_FC1.ACKIN | uTokensSwirling.uCUES.sFC1.uCEX_FC1.SENDOUT);
  wire token_sM = (uTokensSwirling.uCUES.sSM.uCM_SM.ACKIN | uTokensSwirling.uCUES.sSM.uCM_SM.SENDOUT);
  wire token_sFtc0 = (uTokensSwirling.uCUES.sFtc0.uC_Ftc0.ACKIN | uTokensSwirling.uCUES.sFtc0.uC_Ftc0.SENDOUT);
  wire token_sFtc1 = (uTokensSwirling.uCUES.sFtc1.uCEX_Ftc1.ACKIN | uTokensSwirling.uCUES.sFtc1.uCEX_Ftc1.SENDOUT);
  wire token_sDec0 = (uTokensSwirling.uCUES.sDec0.uC_Dec0.ACKIN | uTokensSwirling.uCUES.sDec0.uC_Dec0.SENDOUT);
  wire token_sExe0 = (uTokensSwirling.uCUES.sExe0.uC_Exe0.ACKIN | uTokensSwirling.uCUES.sExe0.uC_Exe0.SENDOUT);
  wire token_sExe1 = (uTokensSwirling.uCUES.sExe1.uCX2_Exe1.ACKIN | uTokensSwirling.uCUES.sExe1.uCX2_Exe1.SENDOUT);
  wire token_sMem0 = (uTokensSwirling.uCUES.sMem0.uC_Mem0.ACKIN | uTokensSwirling.uCUES.sMem0.uC_Mem0.SENDOUT);
  wire token_sMem1 = (uTokensSwirling.uCUES.sMem1.uCEX_Mem1.ACKIN | uTokensSwirling.uCUES.sMem1.uCEX_Mem1.SENDOUT);
  wire token_sSBA = (uTokensSwirling.uCUES.sSB.uCB_SB.ACKINA | uTokensSwirling.uCUES.sSB.uCB_SB.SENDOUTA);
  wire token_sSBB = (uTokensSwirling.uCUES.sSB.uCB_SB.ACKINB | uTokensSwirling.uCUES.sSB.uCB_SB.SENDOUTB);
  wire token_sSwB = (uTokensSwirling.uCUES.sSw.uCB_Sw.ACKINB | uTokensSwirling.uCUES.sSw.uCB_Sw.SENDOUTB);


  initial begin
    btn = 4'b0001;
    sw = 4'b0001;
    #200000;

    btn = 4'b0000;
    #100000;

    btn = 4'b0010;
    #100000;
    btn = 4'b0000;
    #200000;

    btn = 4'b0100;
    #100000;
    btn = 4'b0000;
    #1000000;

    $finish;

  end

endmodule
