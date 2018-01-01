
#################################################################################
#valid locations
SCH1          = "sch1"
SCH2          = "sch2"
REGCFG        = "regcfg"
DDR_WRITE1    = "ddr_write1"
DDR_WRITE2    = "ddr_write2"
DDR_READ_IN1  = "ddr_read_in1"
DDR_READ_IN2  = "ddr_read_in2"
DMA           = "dma"
FRC2          = "frc2"
FRC1          = "frc1"
FLASH         = "flash"
GIO4          = "gio4"
GIO3          = "gio3"
GIO2          = "gio2"
GIO1          = "gio1"
GBUSMSG       = "gbusmsg"
SEGRX1        = "segrx1"
CPUMSG        = "cpumsg"
CTLMSG        = "ctlmsg"
SEGRX2        = "segrx2"
DDR_READ_OUT1 = "ddr_read_out1"
DDR_READ_OUT2 = "ddr_read_out2"
#################################################################################

#
#################################################################################
#valid route strategies
PREVIOUS_NODE  = "prev_node"
NEXT_NODE      = "next_node"
BLOCK_ID       = "block_id"
POWER_STEERING = "pwr_steer"
#valid models
OMB_MUX        = "omb_mux"
OMB_ROUTER     = "omb_router"
#################################################################################


#################################################################################
G_PWR_STEERING_DESTINATIONS         = "G_PWR_STEERING_DESTINATIONS"
C_PWR_STEERING_DEFAULT_DESTINATIONS = "(7,6,5,4,3,2,1,0)"
C_STEER_0_4567_nn_go_to_0           = "(0,0,0,0,3,2,1,0)"
#################################################################################


#################################################################################
# Flow/error control
# Run this after all sources and destinations have been specified
EXIT_SCRIPT_WHEN_A_ROUTE_LOOKUP_NOT_FOUND = TRUE

CHECK_FOR_MISSING_SOURCE_AND_REPORT        = TRUE
# verbose will print all of both constant arrays, else print only the lenght
CHECK_FOR_MISSING_SOURCE_AND_REPORT_VERBOSE = FALSE
#################################################################################


#################################################################################
@router_design_name = "router_top"
@fpga_design_name   = "st"
#################################################################################


#################################################################################
# files                                      
@output_file              = "./#{@router_design_name}_script_out.vhd"
@tb_output_file           = "./#{@router_design_name}_tb_template.vhd"
@dut_instance_file        = "./#{@router_design_name}.vho"
#################################################################################


#################################################################################
#specify connections, keys are route destinations
@route_keys_are_destinations_vals_are_sources_array_of_hash       = {
  #Infer mux
  SCH1                                  => [
              {# This first hash key for each destination is unique in that
               # it's used to specify parameters for the model.
               :model_rtl_name          => OMB_MUX, 
               :model_comment           => "This is the omb_mux", 
               :model_location_reserved => FALSE, 
               :model_generic_formal    => FALSE, 
               :model_generic_actual    => FALSE, 
               },
              #
              {
               :route_from_location     => CPUMSG, 
               :route_strategy          => PREVIOUS_NODE,
               :route_strategy_comment  => "Previous node", 
               :route_strategy_index    => 0,
               },
              {
               :route_from_location     => CTLMSG, 
               :route_strategy          => PREVIOUS_NODE, 
               :route_strategy_comment  => "Previous node", 
               :route_strategy_index    => 0,
               },
              #                       
              {
               :route_from_location     => GBUSMSG, 
               :route_strategy          => PREVIOUS_NODE, 
               :route_strategy_comment  => "Previous node", 
               :route_strategy_index    => 0,
               },
              {
               :route_from_location     => GIO1, 
               :route_strategy          => PREVIOUS_NODE, 
               :route_strategy_comment  => "Previous node", 
               :route_strategy_index    => 0,
               },
            ],                        
  #                                   
  #Infer mux
  REGCFG                                => [                         
              {# This first hash key for each destination is different in that
               # it's used to specify parameters for the model.
               :model_rtl_name          => OMB_MUX, 
               :model_comment           => "This is the omb_mux", 
               :model_location_reserved => FALSE,
               :model_generic_formal    => FALSE, 
               :model_generic_actual    => FALSE, 
               },
              #                       
              {:route_from_location     => GBUSMSG, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "Block ID", 
               :route_strategy_index    => 2,
               },
               #
              {:route_from_location     => GIO1, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "Block ID", 
               :route_strategy_index    => 2,
               },
               #
              {:route_from_location     => SCH1, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "Block ID", 
               :route_strategy_index    => 2,
               },                               
              {:route_from_location     => SCH2, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "Block ID", 
               :route_strategy_index    => 2,
               },
            ],
  # Infer omb mux
  DDR_WRITE1                                => [                         
              {# This first hash key for each destination is different in that
               # it's used to specify parameters for the model.
               :model_rtl_name          => OMB_MUX, 
               :model_comment           => "This is the omb_mux", 
               :model_location_reserved => FALSE,
               :model_generic_formal    => FALSE, 
               :model_generic_actual    => FALSE, 
               },
              #                       
              {:route_from_location     => GBUSMSG, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "Block ID", 
               :route_strategy_index    => 8,
               },
               #
              {:route_from_location     => FRC1, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "Block ID", 
               :route_strategy_index    => 8,
               },
               #
              {:route_from_location     => GIO1, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "Block ID", 
               :route_strategy_index    => 8,
               },                               
            ],
  # Infer omb mux
  DDR_WRITE2                                => [                         
              {# This first hash key for each destination is different in that
               # it's used to specify parameters for the model.
               :model_rtl_name          => OMB_MUX, 
               :model_comment           => "This is the omb_mux", 
               :model_location_reserved => FALSE,
               :model_generic_formal    => FALSE, 
               :model_generic_actual    => FALSE, 
               },
              #                       
              {:route_from_location     => GBUSMSG, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "Block ID", 
               :route_strategy_index    => 10,
               },
               #
              {:route_from_location     => GIO1, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "Block ID", 
               :route_strategy_index    => 10,
               },
               #
              {:route_from_location     => FRC2, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "Block ID", 
               :route_strategy_index    => 10,
               },                               
            ],
  # Infer omb mux
  DDR_READ_IN1                            => [                         
              {# This first hash key for each destination is different in that
               # it's used to specify parameters for the model.
               :model_rtl_name          => OMB_MUX, 
               :model_comment           => "This is the omb_mux", 
               :model_location_reserved => FALSE,
               :model_generic_formal    => FALSE, 
               :model_generic_actual    => FALSE, 
               },
              #                       
              {:route_from_location     => GBUSMSG, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "Block ID", 
               :route_strategy_index    => 9,
               },
               #
              {:route_from_location     => GIO1, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "Block ID", 
               :route_strategy_index    => 9,
               },
               #
              {:route_from_location     => DMA, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "Block ID", 
               :route_strategy_index    => 9,
               },
             ],                                              
  # Infer omb mux
  DDR_READ_IN2                            => [                         
              {# This first hash key for each destination is different in that
               # it's used to specify parameters for the model.
               :model_rtl_name          => OMB_MUX, 
               :model_comment           => "This is the omb_mux", 
               :model_location_reserved => FALSE,
               :model_generic_formal    => FALSE, 
               :model_generic_actual    => FALSE, 
               },
              #                       
              {:route_from_location     => GBUSMSG, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "Block ID", 
               :route_strategy_index    => 11,
               },
               #
              {:route_from_location     => DMA, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "Block ID", 
               :route_strategy_index    => 11,
               },
               #
              {:route_from_location     => GIO1, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "Block ID", 
               :route_strategy_index    => 11,
               },                               
            ],
  # Infer omb mux
  DMA                            => [                         
              {# This first hash key for each destination is different in that
               # it's used to specify parameters for the model.
               :model_rtl_name          => OMB_MUX, 
               :model_comment           => "This is the omb_mux", 
               :model_location_reserved => FALSE,
               :model_generic_formal    => FALSE, 
               :model_generic_actual    => FALSE, 
               },
              #                       
              {:route_from_location     => GIO1, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "Block ID", 
               :route_strategy_index    => 13,
               },
            ],
  # Infer omb mux
  FRC2                                    => [                         
              {# This first hash key for each destination is different in that
               # it's used to specify parameters for the model.
               :model_rtl_name          => OMB_MUX, 
               :model_comment           => "This is the omb_mux", 
               :model_location_reserved => FALSE,
               :model_generic_formal    => FALSE, 
               :model_generic_actual    => FALSE, 
               },
              #                       
              {:route_from_location     => GIO1, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "Block ID", 
               :route_strategy_index    => 7,
               },
               #
              {:route_from_location     => DDR_READ_OUT1, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "Block ID", 
               :route_strategy_index    => 7,
               },
               #
              {:route_from_location     => DDR_READ_OUT2, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "Block ID", 
               :route_strategy_index    => 7,
               },                               
            ],
  # Infer omb mux
  FRC1                                    => [                         
              {# This first hash key for each destination is different in that
               # it's used to specify parameters for the model.
               :model_rtl_name          => OMB_MUX, 
               :model_comment           => "This is the omb_mux", 
               :model_location_reserved => FALSE,
               :model_generic_formal    => FALSE, 
               :model_generic_actual    => FALSE, 
               },
              #                       
              {:route_from_location     => GIO1, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "Block ID", 
               :route_strategy_index    => 6,
               },
               #
              {:route_from_location     => DDR_READ_OUT1, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "Block ID", 
               :route_strategy_index    => 6,
               },
               #
              {:route_from_location     => DDR_READ_OUT2, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "Block ID", 
               :route_strategy_index    => 6,
               },                               
            ],
  # Infer omb mux
  FLASH                                    => [                         
              {# This first hash key for each destination is different in that
               # it's used to specify parameters for the model.
               :model_rtl_name          => OMB_MUX, 
               :model_comment           => "This is the omb_mux", 
               :model_location_reserved => FALSE,
               :model_generic_formal    => FALSE, 
               :model_generic_actual    => FALSE, 
               },
              #                       
              {:route_from_location     => GIO1, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "Block ID", 
               :route_strategy_index    => 14,
               },
               #
              {:route_from_location     => GBUSMSG, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "Block ID", 
               :route_strategy_index    => 14,
               },
               #
            ],
  # Infer omb mux
  GIO4                                    => [                         
              {# This first hash key for each destination is different in that
               # it's used to specify parameters for the model.
               :model_rtl_name          => OMB_MUX, 
               :model_comment           => "This is the omb_mux", 
               :model_location_reserved => FALSE,
               :model_generic_formal    => FALSE, 
               :model_generic_actual    => FALSE, 
               },
              #                       
              {:route_from_location     => DDR_READ_OUT1, 
               :route_strategy          => POWER_STEERING, 
               :route_strategy_comment  => "Power Steering", 
               :route_strategy_index    => 3,
               },
               #
              {:route_from_location     => DDR_READ_OUT2, 
               :route_strategy          => POWER_STEERING, 
               :route_strategy_comment  => "Power Steering", 
               :route_strategy_index    => 3,
               },
               #
            ],
  # Infer omb mux
  GIO3                                    => [                         
              {# This first hash key for each destination is different in that
               # it's used to specify parameters for the model.
               :model_rtl_name          => OMB_MUX, 
               :model_comment           => "This is the omb_mux", 
               :model_location_reserved => FALSE,
               :model_generic_formal    => FALSE, 
               :model_generic_actual    => FALSE, 
               },
              #                       
              {:route_from_location     => DDR_READ_OUT1, 
               :route_strategy          => POWER_STEERING, 
               :route_strategy_comment  => "Power Steering", 
               :route_strategy_index    => 2,
               },
               #
              {:route_from_location     => DDR_READ_OUT2, 
               :route_strategy          => POWER_STEERING, 
               :route_strategy_comment  => "Power Steering", 
               :route_strategy_index    => 2,
               },
               #
            ],
  # Infer omb mux
  GIO2                                    => [                         
              {# This first hash key for each destination is different in that
               # it's used to specify parameters for the model.
               :model_rtl_name          => OMB_MUX, 
               :model_comment           => "This is the omb_mux", 
               :model_location_reserved => FALSE,
               :model_generic_formal    => FALSE, 
               :model_generic_actual    => FALSE, 
               },
              #                       
              {:route_from_location     => DDR_READ_OUT1, 
               :route_strategy          => POWER_STEERING, 
               :route_strategy_comment  => "Power Steering", 
               :route_strategy_index    => 1,
               },
               #
              {:route_from_location     => DDR_READ_OUT2, 
               :route_strategy          => POWER_STEERING, 
               :route_strategy_comment  => "Power Steering", 
               :route_strategy_index    => 1,
               },
               #
            ],
  # Infer omb mux
  GIO1                                    => [                         
              {# This first hash key for each destination is different in that
               # it's used to specify parameters for the model.
               :model_rtl_name          => OMB_MUX, 
               :model_comment           => "This is the omb_mux", 
               :model_location_reserved => FALSE,
               :model_generic_formal    => FALSE, 
               :model_generic_actual    => FALSE, 
               },
              #                       
              {:route_from_location     => FRC1, 
               :route_strategy          => POWER_STEERING, 
               :route_strategy_comment  => "Power Steering", 
               :route_strategy_index    => 0,
               },
               #
              {:route_from_location     => FRC2, 
               :route_strategy          => POWER_STEERING, 
               :route_strategy_comment  => "Power Steering", 
               :route_strategy_index    => 0,
               },
               #
              #                       
              {:route_from_location     => DDR_READ_OUT1, 
               :route_strategy          => POWER_STEERING, 
               :route_strategy_comment  => "Power Steering", 
               :route_strategy_index    => 0,
               },
               #
              {:route_from_location     => DDR_READ_OUT2, 
               :route_strategy          => POWER_STEERING, 
               :route_strategy_comment  => "Power Steering", 
               :route_strategy_index    => 0,
               },
               #
               #
              {:route_from_location     => FLASH, 
               :route_strategy          => POWER_STEERING, 
               :route_strategy_comment  => "Power Steering", 
               :route_strategy_index    => 0,
               },
               #
              #                       
              {:route_from_location     => REGCFG, 
               :route_strategy          => POWER_STEERING, 
               :route_strategy_comment  => "Power Steering", 
               :route_strategy_index    => 0,
               },
               #
              {:route_from_location     => SCH1, 
               :route_strategy          => POWER_STEERING, 
               :route_strategy_comment  => "Power Steering", 
               :route_strategy_index    => 0,
               },
               #
            ],
  # Infer omb mux
  GBUSMSG                                    => [                         
              {# This first hash key for each destination is different in that
               # it's used to specify parameters for the model.
               :model_rtl_name          => OMB_MUX, 
               :model_comment           => "This is the omb_mux", 
               :model_location_reserved => FALSE,
               :model_generic_formal    => FALSE, 
               :model_generic_actual    => FALSE, 
               },
              #                       
              {:route_from_location     => DDR_READ_OUT1, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "block_id", 
               :route_strategy_index    => 3,
               },
               #
              {:route_from_location     => DDR_READ_OUT2, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "block_id", 
               :route_strategy_index    => 3,
               },
               #
              {:route_from_location     => REGCFG, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "block_id", 
               :route_strategy_index    => 3,
               },
               #
              {:route_from_location     => SCH1, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "Power Steering", 
               :route_strategy_index    => 3,
               },
               #
              ],
  # Infer omb mux
  SEGRX1                                => [                         
              {# This first hash key for each destination is different in that
               # it's used to specify parameters for the model.
               :model_rtl_name          => OMB_MUX, 
               :model_comment           => "This is the omb_mux", 
               :model_location_reserved => FALSE,
               :model_generic_formal    => FALSE, 
               :model_generic_actual    => FALSE, 
               },
              #                       
              {:route_from_location     => SCH1, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "block_id", 
               :route_strategy_index    => 4,
               },
               #
              ],
  # Infer omb mux
  CPUMSG                                => [                         
              {# This first hash key for each destination is different in that
               # it's used to specify parameters for the model.
               :model_rtl_name          => OMB_MUX, 
               :model_comment           => "This is the omb_mux", 
               :model_location_reserved => FALSE,
               :model_generic_formal    => FALSE, 
               :model_generic_actual    => FALSE, 
               },
              #                       
              {:route_from_location     => SCH1, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "block_id", 
               :route_strategy_index    => 12,
               },
               #
            ],
  # Infer omb mux
  CTLMSG                                => [                         
              {# This first hash key for each destination is different in that
               # it's used to specify parameters for the model.
               :model_rtl_name          => OMB_MUX, 
               :model_comment           => "This is the omb_mux", 
               :model_location_reserved => FALSE,
               :model_generic_formal    => FALSE, 
               :model_generic_actual    => FALSE, 
               },
              #                       
              {:route_from_location     => SCH1, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "block_id", 
               :route_strategy_index    => 1,
               },
               #
              {:route_from_location     => SCH2, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "block_id", 
               :route_strategy_index    => 1,
               },
               #
            ],
  # Infer omb mux
  SEGRX2                                => [                         
              {# This first hash key for each destination is different in that
               # it's used to specify parameters for the model.
               :model_rtl_name          => OMB_MUX, 
               :model_comment           => "This is the omb_mux", 
               :model_location_reserved => FALSE,
               :model_generic_formal    => FALSE, 
               :model_generic_actual    => FALSE, 
               },
              #                       
              {:route_from_location     => SCH2, 
               :route_strategy          => BLOCK_ID, 
               :route_strategy_comment  => "block_id", 
               :route_strategy_index    => 5,
               },
               #
            ],
                    }
#################################################################################


#################################################################################
#specify connections, keys are route sources_array
 @route_descriptor_hash_keys_are_sources_vals_are_dest_array_of_hash  = {
   #Infer router
   CPUMSG                                          => [
              {# This first hash key for each source is different in that
               # it's used to specify parameters for the model.
                :model_rtl_name                    => OMB_ROUTER, 
                :model_comment                     => "This is the omb_router", 
                :model_location_reserved           => FALSE, 
                :model_generic_formal              => FALSE, 
                :model_generic_actual              => FALSE, 
                },
               #
               {
                :route_to_location                 => SCH1, 
                :route_strategy                    => PREVIOUS_NODE,
                :route_strategy_comment            => "Previous node", 
                :route_strategy_index              => 0,
                },
             ],                        
   #                                   
   #Infer router
   CTLMSG                                          => [                         
              {# This first hash key for each source is different in that
               # it's used to specify parameters for the model.
                :model_rtl_name                    => OMB_ROUTER, 
                :model_comment                     => "This is the omb_router", 
                :model_location_reserved           => FALSE, 
                :model_generic_formal              => FALSE, 
                :model_generic_actual              => FALSE, 
                },
               #                       
               {:route_to_location                 => SCH1, 
                :route_strategy                    => PREVIOUS_NODE, 
                :route_strategy_comment            => "Previous node", 
                :route_strategy_index              => 0,
                }
             ],
   #Infer router
   GBUSMSG                                         => [                         
              {# This first hash key for each source is different in that
               # it's used to specify parameters for the model.
                :model_rtl_name                    => OMB_ROUTER, 
                :model_comment                     => "This is the omb_router", 
                :model_location_reserved           => FALSE, 
                :model_generic_formal              => FALSE, 
                :model_generic_actual              => FALSE, 
                },
               #                       
               {:route_to_location                 => SCH1, 
                :route_strategy                    => PREVIOUS_NODE, 
                :route_strategy_comment            => "Previous node", 
                :route_strategy_index              => 0,
                },
               #                       
               {:route_to_location                 => REGCFG, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "Block Id", 
                :route_strategy_index              => 2,
                # test error :route_strategy_index => 1,
                },
               #                       
               {:route_to_location                 => DDR_WRITE1, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "Block Id", 
                :route_strategy_index              => 8,
                },
               #                       
               {:route_to_location                 => DDR_WRITE2, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "Block Id", 
                :route_strategy_index              => 10,
                },
               #                       
               {:route_to_location                 => DDR_READ_IN1, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "Block Id", 
                :route_strategy_index              => 9,
                },
               #                       
               {:route_to_location                 => DDR_READ_IN2, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "Block Id", 
                :route_strategy_index              => 11,
                },
               #                       
               {:route_to_location                 => FLASH, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "Block Id", 
                :route_strategy_index              => 14,
                },
             ],
   # Infer router
   FRC1                                         => [                         
              {# This first hash key for each source is different in that
               # it's used to specify parameters for the model.
                :model_rtl_name                    => OMB_ROUTER, 
                :model_comment                     => "This is the omb_router", 
                :model_location_reserved           => FALSE, 
                :model_generic_formal              => G_PWR_STEERING_DESTINATIONS, 
                :model_generic_actual              => C_STEER_0_4567_nn_go_to_0, 
                },
               #                       
               {:route_to_location                 => DDR_WRITE1, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "Block Id", 
                :route_strategy_index              => 8,
                },
               #                       
               {:route_to_location                 => GIO1, 
                :route_strategy                    => POWER_STEERING, 
                :route_strategy_comment            => "power_steering", 
                :route_strategy_index              => 0,
                },
             ],
   # Infer router
   FRC2                                         => [                         
              {# This first hash key for each source is different in that
               # it's used to specify parameters for the model.
                :model_rtl_name                    => OMB_ROUTER, 
                :model_comment                     => "This is the omb_router", 
                :model_location_reserved           => FALSE, 
                :model_generic_formal              => G_PWR_STEERING_DESTINATIONS, 
                :model_generic_actual              => C_STEER_0_4567_nn_go_to_0, 
                },
               #                       
               {:route_to_location                 => DDR_WRITE2, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "Block Id", 
                :route_strategy_index              => 10,
                },
               #                       
               {:route_to_location                 => GIO1, 
                :route_strategy                    => POWER_STEERING, 
                :route_strategy_comment            => "power_steering", 
                :route_strategy_index              => 0,
                },
             ],
   # Infer router
   DMA                                         => [                         
              {# This first hash key for each source is different in that
               # it's used to specify parameters for the model.
                :model_rtl_name                    => OMB_ROUTER, 
                :model_comment                     => "This is the omb_router", 
                :model_location_reserved           => FALSE, 
                :model_generic_formal              => FALSE, 
                :model_generic_actual              => FALSE, 
                },
               #                       
               {:route_to_location                 => DDR_READ_IN1, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "Block Id", 
                :route_strategy_index              => 9,
                },
               #                       
               {:route_to_location                 => DDR_READ_IN2, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "block_id", 
                :route_strategy_index              => 11,
                },
             ],
   # Infer router
   GIO1                                         => [                         
              {# This first hash key for each source is different in that
               # it's used to specify parameters for the model.
                :model_rtl_name                    => OMB_ROUTER, 
                :model_comment                     => "This is the omb_router", 
                :model_location_reserved           => FALSE, 
                :model_generic_formal              => FALSE, 
                :model_generic_actual              => FALSE, 
                },
               #                       
               {:route_to_location                 => SCH1, 
                :route_strategy                    => PREVIOUS_NODE, 
                :route_strategy_comment            => "previous_node", 
                :route_strategy_index              => 0,
                },
               #                       
               {:route_to_location                 => REGCFG, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "block_id", 
                :route_strategy_index              => 2,
                },
               #                       
               {:route_to_location                 => DDR_WRITE1, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "block_id", 
                :route_strategy_index              => 8,
                },
               #                       
               {:route_to_location                 => DDR_WRITE2, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "block_id", 
                :route_strategy_index              => 10,
                },
               #                       
               {:route_to_location                 => DDR_READ_IN1, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "block_id", 
                :route_strategy_index              => 9,
                },
               #                       
               {:route_to_location                 => DDR_READ_IN2, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "block_id", 
                :route_strategy_index              => 11,
                },
               #                       
               {:route_to_location                 => DMA, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "block_id", 
                :route_strategy_index              => 13,
                },
               #                       
               {:route_to_location                 => FRC2, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "block_id", 
                :route_strategy_index              => 7,
                },
               # 
               {:route_to_location                 => FRC1, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "block_id", 
                :route_strategy_index              => 6,
                },
               # 
               {:route_to_location                 => FLASH, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "block_id", 
                :route_strategy_index              => 14,
                },
             ],

   # Infer router
   DDR_READ_OUT1                                         => [                         
              {# This first hash key for each source is different in that
               # it's used to specify parameters for the model.
                :model_rtl_name                    => OMB_ROUTER, 
                :model_comment                     => "This is the omb_router", 
                :model_location_reserved           => FALSE, 
                :model_generic_formal              => G_PWR_STEERING_DESTINATIONS, 
                :model_generic_actual              => C_STEER_0_4567_nn_go_to_0, 
                },
               #                       
               {:route_to_location                 => FRC2, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "block_id", 
                :route_strategy_index              => 7,
                },
               #                       
               {:route_to_location                 => FRC1, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "block_id", 
                :route_strategy_index              => 6,
                },
               #                       
               {:route_to_location                 => GIO4, 
                :route_strategy                    => POWER_STEERING, 
                :route_strategy_comment            => "block_id", 
                :route_strategy_index              => 3,
                },
               {:route_to_location                 => GIO3, 
                :route_strategy                    => POWER_STEERING, 
                :route_strategy_comment            => "block_id", 
                :route_strategy_index              => 2,
                },
               {:route_to_location                 => GIO2, 
                :route_strategy                    => POWER_STEERING, 
                :route_strategy_comment            => "block_id", 
                :route_strategy_index              => 1,
                },
               {:route_to_location                 => GIO1, 
                :route_strategy                    => POWER_STEERING, 
                :route_strategy_comment            => "block_id", 
                :route_strategy_index              => 0,
                },
               #                       
               {:route_to_location                 => GBUSMSG, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "block_id", 
                :route_strategy_index              => 3,
                },
               #                       
             ],

   # Infer router
   GIO2                                         => [                         
              {# This first hash key for each source is different in that
               # it's used to specify parameters for the model.
                :model_rtl_name                    => OMB_ROUTER, 
                :model_comment                     => "This is the omb_router", 
                :model_location_reserved           => TRUE, 
                :model_generic_formal              => FALSE, 
                :model_generic_actual              => FALSE, 
                },
             ],

   # Infer router
   GIO3                                         => [                         
              {# This first hash key for each source is different in that
               # it's used to specify parameters for the model.
                :model_rtl_name                    => OMB_ROUTER, 
                :model_comment                     => "This is the omb_router", 
                :model_location_reserved           => TRUE, 
                :model_generic_formal              => FALSE, 
                :model_generic_actual              => FALSE, 
                },
             ],
   # Infer router
   GIO4                                         => [                         
              {# This first hash key for each source is different in that
               # it's used to specify parameters for the model.
                :model_rtl_name                    => OMB_ROUTER, 
                :model_comment                     => "This is the omb_router", 
                :model_location_reserved           => TRUE, 
                :model_generic_formal              => FALSE, 
                :model_generic_actual              => FALSE, 
                },
             ],

   # Infer router
   DDR_READ_OUT2                                         => [                         
              {# This first hash key for each source is different in that
               # it's used to specify parameters for the model.
                :model_rtl_name                    => OMB_ROUTER, 
                :model_comment                     => "This is the omb_router", 
                :model_location_reserved           => FALSE, 
                :model_generic_formal              => G_PWR_STEERING_DESTINATIONS, 
                :model_generic_actual              => C_STEER_0_4567_nn_go_to_0, 
                },
               #                       
               {:route_to_location                 => FRC2, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "block_id", 
                :route_strategy_index              => 7,
                },
               #                       
               {:route_to_location                 => FRC1, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "block_id", 
                :route_strategy_index              => 6,
                },
               #                       
               {:route_to_location                 => GIO4, 
                :route_strategy                    => POWER_STEERING, 
                :route_strategy_comment            => "block_id", 
                :route_strategy_index              => 3,
                },
               {:route_to_location                 => GIO3, 
                :route_strategy                    => POWER_STEERING, 
                :route_strategy_comment            => "block_id", 
                :route_strategy_index              => 2,
                },
               {:route_to_location                 => GIO2, 
                :route_strategy                    => POWER_STEERING, 
                :route_strategy_comment            => "block_id", 
                :route_strategy_index              => 1,
                },
               {:route_to_location                 => GIO1, 
                :route_strategy                    => POWER_STEERING, 
                :route_strategy_comment            => "block_id", 
                :route_strategy_index              => 0,
                },
               #                       
               {:route_to_location                 => GBUSMSG, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "block_id", 
                :route_strategy_index              => 3,
                },
               #                       
             ],
   # Infer router
   FLASH                                         => [                         
              {# This first hash key for each source is different in that
               # it's used to specify parameters for the model.
                :model_rtl_name                    => OMB_ROUTER, 
                :model_comment                     => "This is the omb_router", 
                :model_location_reserved           => FALSE, 
                :model_generic_formal              => G_PWR_STEERING_DESTINATIONS, 
                :model_generic_actual              => C_STEER_0_4567_nn_go_to_0, 
                },
               #                       
               {:route_to_location                 => GIO1, 
                :route_strategy                    => POWER_STEERING, 
                :route_strategy_comment            => "power_steering", 
                :route_strategy_index              => 0,
                },
             ],
   # Infer router
   REGCFG                                         => [                         
              {# This first hash key for each source is different in that
               # it's used to specify parameters for the model.
                :model_rtl_name                    => OMB_ROUTER, 
                :model_comment                     => "This is the omb_router", 
                :model_location_reserved           => FALSE, 
                :model_generic_formal              => G_PWR_STEERING_DESTINATIONS, 
                :model_generic_actual              => C_STEER_0_4567_nn_go_to_0, 
                },
               #                       
               {:route_to_location                 => GIO1, 
                :route_strategy                    => POWER_STEERING, 
                :route_strategy_comment            => "power_steering", 
                :route_strategy_index              => 0,
                },
               #                       
               {:route_to_location                 => GBUSMSG, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "power_steering", 
                :route_strategy_index              => 3,
                },
             ],
   # Infer router
   SCH1                                         => [                         
              {# This first hash key for each source is different in that
               # it's used to specify parameters for the model.
                :model_rtl_name                    => OMB_ROUTER, 
                :model_comment                     => "This is the omb_router", 
                :model_location_reserved           => FALSE, 
                :model_generic_formal              => G_PWR_STEERING_DESTINATIONS, 
                :model_generic_actual              => C_STEER_0_4567_nn_go_to_0, 
                },
               #                       
               {:route_to_location                 => REGCFG, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "Block Id", 
                :route_strategy_index              => 2,
                },
               #                       
               {:route_to_location                 => GIO1, 
                :route_strategy                    => POWER_STEERING, 
                :route_strategy_comment            => "power_steering", 
                :route_strategy_index              => 0,
                },
               #                       
               {:route_to_location                 => GBUSMSG, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "Block Id", 
                :route_strategy_index              => 3,
                },
               #                       
               {:route_to_location                 => SEGRX1, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "Block Id", 
                :route_strategy_index              => 4,
                },
               #                       
               {:route_to_location                 => CPUMSG, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "Block Id", 
                :route_strategy_index              => 12,
                },
               #                       
               {:route_to_location                 => CTLMSG, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "Block Id", 
                :route_strategy_index              => 1,
                },
             ],
   # Infer router
   SCH2                                         => [                         
              {# This first hash key for each source is different in that
               # it's used to specify parameters for the model.
                :model_rtl_name                    => OMB_ROUTER, 
                :model_comment                     => "This is the omb_router", 
                :model_location_reserved           => FALSE, 
                :model_generic_formal              => FALSE, 
                :model_generic_actual              => FALSE, 
                },
               #
               {:route_to_location                 => CTLMSG, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "Block Id", 
                :route_strategy_index              => 1,
                },
               #                       
               {:route_to_location                 => SEGRX2, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "Block Id", 
                :route_strategy_index              => 5,
                },
                #
               {:route_to_location                 => REGCFG, 
                :route_strategy                    => BLOCK_ID, 
                :route_strategy_comment            => "Block Id", 
                :route_strategy_index              => 2,
                },
             ],

                     }


#################################################################################
# Look up table hash
#http://ruby.about.com/od/rubysbasicfeatures/ss/Creating-Hashes-From-Arrays.htm
@sources_array      = @route_descriptor_hash_keys_are_sources_vals_are_dest_array_of_hash.keys
@destinations_array = @route_keys_are_destinations_vals_are_sources_array_of_hash.keys
#
@sources_are_keys_hash      = {}
@route_descriptor_lut_destinations_are_keys_hash = {}
#
@sources_array.each {|x|
   @sources_are_keys_hash[x] = 0
  }
#
@destinations_array.each {|x|
   @route_descriptor_lut_destinations_are_keys_hash[x] = 0
  }
#
early_sources_are_keys_hash = @sources_are_keys_hash
#################################################################################


#################################################################################
