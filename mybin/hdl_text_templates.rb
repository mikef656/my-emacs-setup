#!/usr/bin/env ruby
#################################################################################


#################################################################################
# text definitions
  #
  @system_port_group = <<-END.gsub(/^ {2}/, '')
    -------------------------------------------------------------------------------       
    -- System
    arst                     : in    std_logic;
    clk_gbus                 : in    std_logic;
        
    -------------------------------------------------------------------------------       
  END
  #
  @in_instance_group = <<-END.gsub(/^ {2}/, '')
      -------------------------------------------------------------------------------       
      --gbus inputs
      function0_out_gbus_data  => function0_out_gbus_data,
      function0_out_gbus_valid => function0_out_gbus_valid,
      function0_out_gbus_ready => function0_out_gbus_ready,
      function0_out_gbus_req   => function0_out_gbus_req,
      function0_out_gbus_grant => function0_out_gbus_grant,
      function0_out_gbus_rej   => function0_out_gbus_rej,
      -------------------------------------------------------------------------------       
  END
  #
  @in_port_group = <<-END.gsub(/^ {2}/, '')
      -------------------------------------------------------------------------------       
      --gbus inputs
      function0_out_gbus_data     : in    std_logic_vector(GBUS_RANGE);
      function0_out_gbus_valid    : in    std_logic;
      function0_out_gbus_ready    : out   std_logic;
      function0_out_gbus_req      : in    std_logic;
      function0_out_gbus_grant    : out   std_logic;
      function0_out_gbus_rej      : out   std_logic;
      -------------------------------------------------------------------------------       
  END
  #
  @out_port_group = <<-END.gsub(/^ {2}/, '')
      --------------------------------------------------------------------------------
      --gbus outputs
      function0_in_gbus_data      : out   std_logic_vector(GBUS_RANGE);
      function0_in_gbus_valid     : out   std_logic;
      function0_in_gbus_ready     : in    std_logic;
      function0_in_gbus_req       : out   std_logic;
      function0_in_gbus_grant     : in    std_logic;
      function0_in_gbus_rej       : in    std_logic;
      --------------------------------------------------------------------------------
  END
  #
  @out_instance_group = <<-END.gsub(/^ {2}/, '')
      --------------------------------------------------------------------------------
      --gbus outputs
      in_gbus_data    => function0_in_gbus_data,
      in_gbus_valid   => function0_in_gbus_valid,
      in_gbus_ready   => function0_in_gbus_ready,
      in_gbus_req     => function0_in_gbus_req,
      in_gbus_grant   => function0_in_gbus_grant,
      in_gbus_rej     => function0_in_gbus_rej,
      --------------------------------------------------------------------------------
  END
  #
  @fpga_instance = <<-END.gsub(/^ {2}/, '')
  i1: 
  debounce
     generic map 
        ( 
        ge_iniitally_low          => '1' ,
        ge_dly_tm_clks         => ge_dly_tm_clks
        )
     port map                  
        (   
        clk_25mhz              => clk_25mhz,
        reset_l                => s_reset_l_qq,
        in_noisy               => s_pwr_off_wrn_l_qq,
        out_dbnc               => s_pwr_off_wrn_l_dbnc
        );
  END
  #
  @entity_header_text = <<-END.gsub(/^ {2}/, '')
    entity router_sub is
      generic (
            g_reset : std_logic := '1'
      );
      port ( 
   END
  #
  @library_text = <<-END.gsub(/^ {2}/, '')
    library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;
    -- 
    library svst_lib;
    use svst_lib.svst_pkg.all;
    -- 
    library galaxy_bus;
    use galaxy_bus.galaxy_bus_pkg.all;
  END
  #
  @entity_trailer_text = "end scst3;\n"

#
#################################################################################

