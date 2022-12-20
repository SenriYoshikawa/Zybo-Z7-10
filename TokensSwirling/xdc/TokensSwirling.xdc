# clk
set_property -dict { PACKAGE_PIN K17 IOSTANDARD LVCMOS33 } [get_ports { clk }];

# button
set_property -dict { PACKAGE_PIN K18 IOSTANDARD LVCMOS33 } [get_ports { btn[0] }];
set_property -dict { PACKAGE_PIN P16 IOSTANDARD LVCMOS33 } [get_ports { btn[1] }];
set_property -dict { PACKAGE_PIN K19 IOSTANDARD LVCMOS33 } [get_ports { btn[2] }];
set_property -dict { PACKAGE_PIN Y16 IOSTANDARD LVCMOS33 } [get_ports { btn[3] }];

# sw
set_property -dict { PACKAGE_PIN G15 IOSTANDARD LVCMOS33 } [get_ports { sw[0] }];
set_property -dict { PACKAGE_PIN P15 IOSTANDARD LVCMOS33 } [get_ports { sw[1] }];
set_property -dict { PACKAGE_PIN W13 IOSTANDARD LVCMOS33 } [get_ports { sw[2] }];
set_property -dict { PACKAGE_PIN T16 IOSTANDARD LVCMOS33 } [get_ports { sw[3] }];

# led
set_property -dict { PACKAGE_PIN M14 IOSTANDARD LVCMOS33 } [get_ports { led[0] }];
set_property -dict { PACKAGE_PIN M15 IOSTANDARD LVCMOS33 } [get_ports { led[1] }];
set_property -dict { PACKAGE_PIN G14 IOSTANDARD LVCMOS33 } [get_ports { led[2] }];
set_property -dict { PACKAGE_PIN D18 IOSTANDARD LVCMOS33 } [get_ports { led[3] }];

set_property -dict { PACKAGE_PIN V16 IOSTANDARD LVCMOS33 } [get_ports { led6_r }];
set_property -dict { PACKAGE_PIN F17 IOSTANDARD LVCMOS33 } [get_ports { led6_g }];
set_property -dict { PACKAGE_PIN M17 IOSTANDARD LVCMOS33 } [get_ports { led6_b }];

# Pmod Je
set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { je[0] }];

set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sDec0/uC_Dec0/uCCORE/uISRP/pq];
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sDec0/uC_Dec0/uCCORE/uOSRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sExe0/uC_Exe0/uCCORE/uISRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sExe0/uC_Exe0/uCCORE/uOSRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sExe1/uCX2_Exe1/uCCOREA/uISRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sExe1/uCX2_Exe1/uCCOREA/uOSRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sExe1/uCX2_Exe1/uCCOREB/uISRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sExe1/uCX2_Exe1/uCCOREB/uOSRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sExe1/uCX2_Exe1/uFEB/cppkt_sexe1]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sFC0/uC_FC0/uCCORE/uISRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sFC0/uC_FC0/uCCORE/uOSRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sFC1/uCEX_FC1/uCCORE/uISRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sFC1/uCEX_FC1/uCCORE/uOSRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sFtc0/uC_Ftc0/uCCORE/uISRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sFtc0/uC_Ftc0/uCCORE/uOSRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sFtc1/uCEX_Ftc1/uCCORE/uISRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sFtc1/uCEX_Ftc1/uCCORE/uOSRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sMem0/uC_Mem0/uCCORE/uISRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sMem0/uC_Mem0/uCCORE/uOSRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sMem1/uCEX_Mem1/uCCORE/uISRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sMem1/uCEX_Mem1/uCCORE/uOSRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sMer/uCM_Mer/uAEB/aeb_smer]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sMer/uCM_Mer/uAEB/btn[0]]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sMer/uCM_Mer/uARB/GA]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sMer/uCM_Mer/uARB/arb_b2]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sMer/uCM_Mer/uARB/uRS1A/arb_a0]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sMer/uCM_Mer/uARB/uRS1B/arb_b0]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sMer/uCM_Mer/uCCOREA/uISRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sMer/uCM_Mer/uCCOREA/uOSRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sMer/uCM_Mer/uCCOREB/uISRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sMer/uCM_Mer/uCCOREB/uOSRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sSB/uCB_SB/uCCORE/uISRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sSB/uCB_SB/uCCORE/uOSRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sSM/uCM_SM/uAEB/aeb_ssm]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sSM/uCM_SM/uARB/GA]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sSM/uCM_SM/uARB/arb_b2]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sSM/uCM_SM/uARB/uRS1A/arb_a0]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sSM/uCM_SM/uARB/uRS1B/arb_b0]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sSM/uCM_SM/uCCOREA/uISRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sSM/uCM_SM/uCCOREA/uOSRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sSM/uCM_SM/uCCOREB/uISRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sSM/uCM_SM/uCCOREB/uOSRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sSw/uCB_Sw/uCCORE/uISRP/pq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uCUES/sSw/uCB_Sw/uCCORE/uOSRP/pq]
