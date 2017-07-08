module  test  (a,comp );


  ha
  u1 (
      .sum(comp[1]),
      .cout(car[1]), 
      .a(not_a[1]), 
      .b(car[0])   );     


  ha u2 (.sum(comp[2]),.cout(car[2]), .a(not_a[2]), .b(car[1])   );


  atcl_pll_reconfig
  #(.USE_BUFG_ON_FB_CLK(1),
    .PLL_CLKOUT_ENABLE(7'b010_0001),
    .SINGLE_CLOCK_INPUT(1),
    .USE_PLL_CHIPSCOPE(USE_PLL_CHIPSCOPE[0]))
  refpll0_reconfig
  (
    .clk_osc1(refclk_bufg),
    .clk_osc2(1'b0),
    .d_reconfiguring(refpll0_d_reconfiguring),
    .chipscope_pll_ctrl(chipscope_app_ctrl[CS_CTRL_BITS*CS_PLL_OFST +: CS_CTRL_BITS])
  );

       
       
endmodule
//******************************************************************************
