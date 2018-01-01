#!/usr/bin/env ruby
# -*- coding: iso-8859-1 -*-


@design_name = "router_top"


#################################################################################
mux_driver_hash = {
   "sch1"  => [
               "cpumsg_router_previous_node_port",  "C_CPUMSG_PN_SCH1_MUX_0",
               "ctlmsg_router_previous_node_port",  "C_CTLMSG_PN_SCH1_MUX_1",
               "gbusmsg_router_previous_node_port", "C_GBUSMSG_PN_SCH1_MUX_2"
              ], 
    
    "regcfg"=>[
             "gbusmsg_router_blockid_port",         "C_GBUSMSG_BLK2_REGCFG_MUX_0",
             "gio1_router_blockid_port",            "C_GIO1_BLK2_REGCFG_MUX_1",
             "sch1_router_blockid_port",            "C_SCH1_BLK2_REGCFG_MUX_2",
             "sch2_router_blockid_port",            "C_SCH2_BLK2_REGCFG_MUX_3"
              ],

    "ddr_write1"=>[
             "gbusmsg_router_blockid_port",         "C_GBUSMSG_BLK8_DDR_WRITE1_MUX_0",
             "frc1_router_blockid_port",            "C_FRC1_BLK8_DDR_WRITE1_MUX_1",
             "gio1_router_blockid_port",            "C_GIO1_BLK8_DDR_WRITE1_MUX_2"
              ],
    
    "ddr_write2"=>[
             "gbusmsg_router_blockid_port",         "C_GBUSMSG_BLKA_DDR_WRITE2_MUX_0",
             "gio1_router_blockid_port",            "C_GIO1_BLKA_DDR_WRITE2_MUX_1",
             "frc2_router_blockid_port",            "C_FRC2_BLKA_DDR_WRITE2_MUX_2" 
              ],
    
    "ddr_read_in1"=>[
             "gbusmsg_router_blockid_port",         "C_GBUSMSG_BLK9_DDR_READ_IN1_MUX_0",
             "gio1_router_blockid_port",            "C_GIO1_BLK9_DDR_READ_IN1_MUX_1",   
             "dma_router_blockid_port",            "C_DMA_BLK9_DDR_READ_IN1_MUX_2"    
              ],

    "ddr_read_in2"=>[
             "gbusmsg_router_blockid_port",        "C_GBUSMSG_BLKB_DDR_READ_IN2_MUX_0", 
             "dma_router_blockid_port",            "C_DMA_BLKB_DDR_READ_IN2_MUX_1", 
             "gio1_router_blockid_port",           "C_GIO1_BLKB_DDR_READ_IN2_MUX_2" 
              ],

    "dma"=>[
             "gio1_router_blockid_port",           "C_GIO1_BLKD_DMA_MUX_0" # 
              ],

    "frc2"=>[
             "gio1_router_blockid_port",        "C_GIO1_BLK7_FRC2_MUX_0",        
             "ddr_read_out1_router_blockid_port", "C_DDR_READ_OUT1_BLK7_FRC2_MUX_1", 
             "ddr_read_out2_router_blockid_port", "C_DDR_READ_OUT2_BLK7_FRC2_MUX_2" 
              ],

    "frc1"=>[
             "gio1_router_blockid_port",        "C_GIO1_BLK6_FRC1_MUX_0",        
             "ddr_read_out1_router_blockid_port", "C_DDR_READ_OUT1_BLK6_FRC1_MUX_1", 
             "ddr_read_out2_router_blockid_port", "C_DDR_READ_OUT2_BLK6_FRC1_MUX_2" 
              ],

    "flash"=>[
             "gio1_router_blockid_port",        "C_GIO1_BLKE_FLASH_MUX_0",
             "gbusmsg_router_blockid_port",     "C_GBUSMSG_BLKE_FLASH_MUX_1"
              ],

    "gio4"=>[
             "ddr_read_out1_router_pwr_steer_port", "C_DDR_READ_OUT1_ST3_GIO4_MUX_0",
             "ddr_read_out2_router_pwr_steer_port", "C_DDR_READ_OUT2_ST3_GIO4_MUX_1"
              ],

    "gio3"=>[
             "ddr_read_out1_router_pwr_steer_port", "C_DDR_READ_OUT1_ST2_GIO3_MUX_0",
             "ddr_read_out2_router_pwr_steer_port", "C_DDR_READ_OUT2_ST2_GIO3_MUX_1"
              ],

    "gio2"=>[
             "ddr_read_out1_router_pwr_steer_port", "C_DDR_READ_OUT1_ST1_GIO2_MUX_0",
             "ddr_read_out2_router_pwr_steer_port", "C_DDR_READ_OUT2_ST1_GIO2_MUX_1"
              ],

    "gio1"=>[
             "frc1_router_pwr_steer_port"          , "C_FRC1_S0NN_GIO1_MUX_0",
             "frc2_router_pwr_steer_port"          , "C_FRC2_S0NN_GIO1_MUX_1",
             "ddr_read_out1_router_pwr_steer_port" , "C_DDR_READ_OUT1_S0NN_GIO1_MUX_2",
             "ddr_read_out2_router_pwr_steer_port" , "C_DDR_READ_OUT2_S0NN_GIO1_MUX_3",
             "flash_router_pwr_steer_port"         , "C_FLASH_S0NN_GIO1_MUX_4",
             "regcfg_router_pwr_steer_port"        , "C_REGCFG_S0NN_GIO1_MUX_5",
             "sch1_router_pwr_steer_port"          , "C_SCH1_S0NN_GIO1_MUX_6"
              ],

    "gbusmsg"=>[
             "ddr_read_out1_router_blockid_port" , "C_DDR_READ_OUT1_BLK3_GBUSMSG_MUX_0",
             "ddr_read_out2_router_blockid_port" , "C_DDR_READ_OUT2_BLK3_GBUSMSG_MUX_1",
             "regcfg_router_blockid_port"        , "C_REGCFG_BLK3_GBUSMSG_MUX_2",
             "sch1_router_blockid_port"          , "C_SCH1_BLK3_GBUSMSG_MUX_3"
              ],

    "segrx1"=>[
             "sch1_router_blockid_port" , "C_SCH1_BLK4_SEGRX1_MUX_0"
              ],

    "cpumsg"=>[
             "sch1_router_blockid_port" , "C_SCH1_BLKC_CPUMSG_MUX_0"
              ],

    "ctlmsg"=>[
             "sch1_router_blockid_port" , "C_SCH1_BLK1_CTLMSG_MUX_0",
             "sch2_router_blockid_port" , "C_SCH2_BLK1_CTLMSG_MUX_1"
              ],
    
    "segrx2"=>[
             "sch2_router_blockid_port" , "C_SCH2_BLK5_SEGRX2_MUX_0"
              ],

                 }
#################################################################################


#################################################################################
router_readys_hash = {
   "cpumsg"  => [
                  ["previous_node", "C_CPUMSG_PN_SCH1_MUX_0", "sch1",],  
                ], 

   "ctlmsg"  => [
                  ["previous_node", "C_CTLMSG_PN_SCH1_MUX_1", "sch1",],  
                ], 

   "gbusmsg"  => [
                  ["previous_node", "C_GBUSMSG_PN_SCH1_MUX_2" , "sch1",],  
                  ["block_id", "C_GBUSMSG_BLK2_REGCFG_MUX_0"       , "regcfg"],
                  ["block_id", "C_GBUSMSG_BLK8_DDR_WRITE1_MUX_0", "ddr_write1"],
                  ["block_id", "C_GBUSMSG_BLKA_DDR_WRITE2_MUX_0", "ddr_write2"],
                  ["block_id", "C_GBUSMSG_BLK9_DDR_READ_IN1_MUX_0", "ddr_read_in1"],
                  ["block_id", "C_GBUSMSG_BLKB_DDR_READ_IN2_MUX_0", "ddr_read_in2"],
                  ["block_id", "C_GBUSMSG_BLKE_FLASH_MUX_1", "flash"],
                ], 
   
   "frc1"  => [
                  ["block_id", "C_FRC1_BLK8_DDR_WRITE1_MUX_1" , "ddr_write1"],  
                  ["pwr_steer", "C_FRC1_S0NN_GIO1_MUX_0"       , "gio1"],
              ], 

   "frc2"  => [
                  ["block_id", "C_FRC2_BLKA_DDR_WRITE2_MUX_2" , "ddr_write2"],  
                  ["pwr_steer", "C_FRC2_S0NN_GIO1_MUX_1"       , "gio1"],
              ], 

   "dma"  => [
                  ["block_id", "C_DMA_BLK9_DDR_READ_IN1_MUX_2", "ddr_read_in1"],  
                  ["block_id", "C_DMA_BLKB_DDR_READ_IN2_MUX_1", "ddr_read_in2"],
              ], 

   "gio1"  => [
                  ["previous_node", "C_GIO1_PN_SCH1_MUX_2", "sch1"],  #ok
                  ["block_id", "C_GIO1_BLK2_REGCFG_MUX_1",  "regcfg"],#ok
                  ["block_id", "C_GIO1_BLK8_DDR_WRITE1_MUX_2",  "ddr_write1"],#ok
                  ["block_id", "C_GIO1_BLKA_DDR_WRITE2_MUX_1",  "ddr_write2"],#ok fixed
                  ["block_id", "C_GIO1_BLK9_DDR_READ_IN1_MUX_1",  "ddr_read_in1"],#ok 
                  ["block_id", "C_GIO1_BLKB_DDR_READ_IN2_MUX_2",  "ddr_read_in2"],#ok fixed
                  ["block_id", "C_GIO1_BLKD_DMA_MUX_0",  "dma"],
                  ["block_id", "C_GIO1_BLK7_FRC2_MUX_0",  "frc2"],
                  ["block_id", "C_GIO1_BLK6_FRC1_MUX_0",  "frc1"],
                  ["block_id", "C_GIO1_BLKE_FLASH_MUX_0",  "flash"],
              ], 

   "gio2"  => [
                  ["na"],  # this is how to prevent the creation of a process driving
                           # a reserved mux.  Reserved meaning the top level ports exist
                           # and the router instance exists in case we need it in the future
                           # however for now it's unconnected.
              ], 

   "gio3"  => [
                  ["na"],  # this is how to prevent the creation of a process driving
                           # a reserved mux.  Reserved meaning the top level ports exist
                           # and the router instance exists in case we need it in the future
                           # however for now it's unconnected.
              ], 

   "gio4"  => [
                  ["na"],  # this is how to prevent the creation of a process driving
                           # a reserved mux.  Reserved meaning the top level ports exist
                           # and the router instance exists in case we need it in the future
                           # however for now it's unconnected.
              ], 

   "ddr_read_out1"  => [
                  ["block_id", "C_DDR_READ_OUT1_BLK7_FRC2_MUX_1",   "frc2"],  
                  ["block_id", "C_DDR_READ_OUT1_BLK6_FRC1_MUX_1",   "frc1"],  
                  ["pwr_steer", "C_DDR_READ_OUT1_ST3_GIO4_MUX_0",   "gio4"],
                  ["pwr_steer", "C_DDR_READ_OUT1_ST2_GIO3_MUX_0",   "gio3"],
                  ["pwr_steer", "C_DDR_READ_OUT1_ST1_GIO2_MUX_0",   "gio2"],
                  ["pwr_steer", "C_DDR_READ_OUT1_S0NN_GIO1_MUX_2",  "gio1"],
                  ["block_id", "C_DDR_READ_OUT1_BLK3_GBUSMSG_MUX_0","gbusmsg"],
              ], 

   "ddr_read_out2"  => [
                  ["block_id", "C_DDR_READ_OUT2_BLK7_FRC2_MUX_2", "frc2"],  
                  ["block_id", "C_DDR_READ_OUT2_BLK6_FRC1_MUX_2", "frc1"],  
                  ["pwr_steer", "C_DDR_READ_OUT2_ST3_GIO4_MUX_1", "gio4"],
                  ["pwr_steer", "C_DDR_READ_OUT2_ST2_GIO3_MUX_1", "gio3"],
                  ["pwr_steer", "C_DDR_READ_OUT2_ST1_GIO2_MUX_1", "gio2"],
                  ["pwr_steer", "C_DDR_READ_OUT2_S0NN_GIO1_MUX_3","gio1"],
                  ["block_id", "C_DDR_READ_OUT2_BLK3_GBUSMSG_MUX_1","gbusmsg"],
              ], 

   "flash"  => [
                  ["pwr_steer", "C_FLASH_S0NN_GIO1_MUX_4", "gio1",],  
              ], 

   "regcfg"  => [
                  ["pwr_steer", "C_REGCFG_S0NN_GIO1_MUX_5", "gio1"],  
                  ["block_id", "C_REGCFG_BLK3_GBUSMSG_MUX_2", "gbusmsg"],  
              ], 

   "sch1"  => [
                  ["block_id", "C_SCH1_BLK2_REGCFG_MUX_2", "regcfg"],
                  ["pwr_steer", "C_SCH1_S0NN_GIO1_MUX_6", "gio1"],  
                  ["block_id", "C_SCH1_BLK3_GBUSMSG_MUX_3", "gbusmsg"],  
                  ["block_id", "C_SCH1_BLK4_SEGRX1_MUX_0", "segrx1"],  
                  ["block_id", "C_SCH1_BLKC_CPUMSG_MUX_0", "cpumsg"],  
                  ["block_id", "C_SCH1_BLK1_CTLMSG_MUX_0", "ctlmsg"],  
              ], 

   "sch2"  => [
                  ["block_id", "C_SCH2_BLK2_REGCFG_MUX_3", "regcfg"],
                  ["block_id", "C_SCH2_BLK1_CTLMSG_MUX_1", "ctLmsg"],  
                  ["block_id", "C_SCH2_BLK5_SEGRX2_MUX_0", "segrx2"],  
              ], 

                     }
#################################################################################


#################################################################################
# surecom_omb_router_names_array = %w(cpumsg ctlmsg gbusmsg frc1 frc2 dma gio1
#                                     ddr_read_out1 ddr_read_out2 flash regcfg
#                                     sch1 sch2)
surecom_omb_router_names_array = router_readys_hash.keys


# surecom_omb_mux_names_array            = %w(sch1 regcfg ddr_write1 ddr_write2 ddr_read_in1
#                                       ddr_read_in2 dma frc2 frc1 flash gio4 gio3
#                                       gio2 gio1 gbusmsg segrx1 cpumsg ctlmsg segrx2)
surecom_omb_mux_names_array    = mux_driver_hash.keys
                                      
                                      
#                                      
output_file              = "./#{@design_name}_script_out.vhd"
tb_output_file           = "./#{@design_name}_tb_template.vhd"
dut_instance_file        = "./#{@design_name}.vho"
#################################################################################


#################################################################################
#stackoverflow.com/questions/25336504/
# does-ruby-have-a-method-similar-to-emacs-align-regexp/25336574#25336574
#my question
#note that the answer given does not correctly handle lines that do not contain
#the regexp, and it does not compact the space before the regexp (it may allign
#leaving a big whitespace before the alignment column.
class Array
  ##############################################################################
  def align_regexp (regexp)
    if regexp == (""or //)
      puts "--- WARNING REGEXP EMPTY ----"
      array_of_strings
    else
      rows = self.map{ |line| line.partition(regexp)}
      #
      pos = rows.map { |row| 
                     # if the regexp did not match then count its length as 0
                     if (row[2] == "")
                       0
                     else  
                       row[0].rstrip.size 
                     end
                     }.max
      #
      rows.map{ |row| 
                # if the regexp did not match then don't apply the correction
                if (row[2] == "")
                  row[0] = row[0].rstrip.ljust(0)
                else
                  row[0] = row[0].rstrip.ljust(pos+1)
                end
                #
                row.join 
              }
     end
  end
  ##############################################################################
  #
  ##############################################################################
  def assure_elements_have_ending_newline
    #call this on an array of strings, to assure that each ends in a newline
    self.collect {|element| 
                           if element =~ /\n$/
                             element 
                           else
                             element + "\n"
                           end}
  ##############################################################################
  end                      
end                               
#################################################################################


#################################################################################
multi_char_h_vhdl_comment = ["   -----------------------------------------------------------------------------"]
single_char_h_vhdl_comment = ["   --"]
#################################################################################


#################################################################################
  @tmru_vhdl_header_start_heredoc = <<-END.gsub(/^ {2}/, '')
  -- ****************************************************************************
  --
  -- Toshiba Medical Research Institute USA, INC.  (TMRU)
  --
  -- This confidential and proprietary software may be used only as authorized
  -- by a licensing agreement from Toshiba Medical Research Institute USA, INC.
  --
  -- In the event of publication, the following notice is applicable
  --
  --      © COPYRIGHT 20YY Toshiba Medical Research Institute USA, INC.
  --      ALL RIGHTS RESERVED
  --
  -- The entire notice above must be reproduced on all authorized copies.
  --
  --
  -- ****************************************************************************
  -- File identification:
  --      File name - SVN Rev - SVN Date - User
  -- $Id: ptss_router.vhd 11359 2014-08-18 14:21:59Z mfitzgerald $
  -- ****************************************************************************
  --
  -- ABSTRACT :
  -- The router_top module contains instances of surecom_omb_routers and
  -- omb_muxes which are interconnected to provide a set of paths so that omb
  -- messages can travel from a specific input thru the router_top to zero or
  -- more specific router_top outputs via a controlled number pre-defined paths.
  --
  -- Surecom_omb_routers are a design specific implementation of the TMRU IP
  -- omb_router that has been customized with a unique routing table
  -- configuration.  The general function of the surecom_omb_router is
  -- de-multiplexing omb buses based on in-message data.
  --
  -- The omb_mux instances used in the router top are from the TMRU IP.  The
  -- general function provided by omb_muxes is multiplexing omb buses.
  --
  -- Routing is defined as the process by which an omb message travels from a
  -- top level router input thru the top level routers interconnect to a top
  -- level router output.
  --
  -- The router_top interconnections are limited such that any given router_top
  -- input may route to a subset of all possible router_top outputs.  This is
  -- done to limit the routing resources needed to implement and to optimize CAE
  -- tool P&R and timing performance.  Interconnect is designed to provide only
  -- the routes needed by the top level fpga functions and no more.
  --
  -- ROUTER_TOP MODULE FUNCTIONS: 
  -- Route a message received on a specific input port to zero or more specific
  -- output ports, so that top level fpga functional modules can send messages
  -- to multiple other top level functional modules.
  --
  -- Routes input omb messages to a particular output location based on a
  -- prioritized protocol which examines three fields in the message's RI
  -- quadword.
  --   1) node id
  --   2) block id
  --   3) power steering
  --   so that from a fpga top level point of view, messages may be routed
  --   internally, routed externally, and external routes be directed (steering)
  --   over a particular physical channel.
  --
  -- Routes messages which request destinations not defined by the routers
  -- interconnect to an internal bit bucket location, so that those messages do
  -- not lock up the routing paths.
  --
  -- Provides access to an registered sticky history indication pertaining to
  -- whether a particular block id has been routed to, so that users may
  -- determine if the router is being used as anticipated/designed.
  --
  -- NOTES :
  -- * Routing Protocol
  -- ** The prioritized protocol which determines the route by examining message RI
  -- node id,block id, and power steering is defined\implemented in the
  -- surecom_omb_routers.
  --
  -- ** The prioritized protocol which examines node id,block id, and power steering
  -- used to make the route is the same in each surecom_omb_router
  --
  -- * Association of instances with top level functions
  -- ** Each top level router input port is associated with a surecom_omb_router.
  --
  -- ** Each top level router output port is associated with an omb_mux.
  --
  -- * Interconnect
  -- ** Interconnect is implemented using two combinational processes for each path
  --    1) In the surecom_omb_router -> omb mux direction for omb bus signals
  --      sof,eof,valid and data.
  --    2) In the omb mux -> surecom_omb_router direction for omb signal ready
  --
  -- ** function 'router_port_to_mux_port_func' 
  -- function 'router_port_to_mux_port_func' implements the omb_mux side of the
  -- router interconnect.  
  --
  -- Usage is 
  -- mux_input = router_port_to_mux_port_func(
  --    signal_to_be_routed_1,indexing_constant_1,
  --    signal_to_be_routed_2,indexing_constant_2,
  --    ... 
  --    signal_to_be_routed_n,indexing_constant_n,)
  --
  -- The function's output is a record type signal which drives the mux inputs.
  --
  -- The function's input (it's arguments) are signal,constant pairs.  The signal
  -- is from a surecom_omb_router output, the constant provides indexing for both.  
  -- sides of the interconnect.
  --
  -- The input indexing constant has two parts, one specifies a particular
  -- signal from the router.  That particular signal is associated with routing
  -- behavior.  For example an index of 1, on the block id signal specifies
  -- block_id 1.  An index of 3 on the power steering signal specifies steer 3
  -- The other part of the constant specifies the index of the omb_mux.
  --
  -- Function overloads exist for 1 - 8 input signal,indexing_constant pairs.
  --
  -- The function ties unused omb_mux inputs to 0, which is an inactive state.
  --
  -- * Surecom_omb_router connections
  -- ** Previous node connections always use signal index 0.
  --
  -- ** Next node connections share a common physical connection with steering 0
  --  therefore always use index 0.
  --
  -- * Message detected interface
  -- The router top message detected interface provides access to a registered
  -- sticky history of messages passing through all input ports on the router.
  --
  -- The message detected interface is multiplexed so that a single
  -- read data bus provides access to data stored in all the surecom_omb_routers.
  --
  -- Input port Router_top_msg_det_select is is used to select a particular
  -- Surecom_omb_router associated FPGA function.  The table shown below provides
  -- the mapping from Router_top_msg_det_select to Router_top_msg_detected.
  --
  -- The output port Router_top_msg_detected is bit mapped so that bit
  -- position corresponds to block id.  For example bit(0) in port
  -- Router_top_msg_detected asserted means that block id 0 from that particular
  -- mux has received an omb message.  The same bit de-asserted means no message
  -- has been received.
  --
  -- Only block id's associated with the st's node id are tracked by the message
  -- detected function.
  --
  END
#################################################################################


#################################################################################
  @tmru_vhdl_header_instance_header_heredoc = <<-END.gsub(/^ {2}/, '')
  -- ****************************************************************************
  -- Instantiated Modules:
  -- ****************************************************************************
  END
#################################################################################


#################################################################################
  @tmru_vhdl_header_end_heredoc = <<-END.gsub(/^ {2}/, '')
  -- ****************************************************************************

   
  END
#################################################################################


#################################################################################
  test_heredoc = <<-END.gsub(/^ {2}/, '')
  -- ****************************************************************************


  something else   
  END
#################################################################################


#################################################################################
  @input_modules_heredoc = <<-END.gsub(/^ {2}/, '')
  --    Associated with top level router inputs


  END
#################################################################################


#################################################################################
  @ouput_modules_heredoc = <<-END.gsub(/^ {2}/, '')
  --    Associated with top level router outputs

  END
#################################################################################


#################################################################################
def create_router_instance_list(temparg)
  temparg_upcase = temparg.upcase
  temparg_capitalize = temparg.capitalize
  #
  @instance_list = <<-END.gsub(/^ {2}/, '')
  --       inst_#{temparg}_router: surecom_omb_router.vhd
  END
end
#################################################################################


#################################################################################
def create_mux_instance_list(temparg)
  temparg_upcase = temparg.upcase
  temparg_capitalize = temparg.capitalize
  #
  @instance_list = <<-END.gsub(/^ {2}/, '')
  --       inst_#{temparg}_mux: omb_mux.vhd
  END
end
#################################################################################


#################################################################################
  # Don't expect these to change over designs
  @router_types_heredoc = <<-END.gsub(/^ {2}/, '   ')
  type T_ROUTER_TOP_READY is
     record
        block_id      :std_logic_vector(15 downto 0);
        pwr_steer     :std_logic_vector(15 downto 0);
        next_node     :std_logic_vector(15 downto 0);
        previous_node :std_logic_vector(15 downto 0);
  end record;
   
   
  constant C_ROUTER_READY_ALL_ONES : T_ROUTER_TOP_READY := 
     (block_id        => (others=> '1'),
      pwr_steer       => (others=> '1'),
      next_node       => (others=> '1'), 
      previous_node   => (others=> '1'));
 
 
  END

  router_types_array = @router_types_heredoc.split("\n").
                        assure_elements_have_ending_newline
#################################################################################



# mtf
#################################################################################
def create_msg_det_mapping_array(temparg,index)
  temparg_upcase = temparg.upcase
  ##
  @proc_arg = <<-END.gsub(/^ {2}/, '')
  -- #{index} = #{temparg}
  END
end
#################################################################################


#################################################################################
# testbench constants as procedure args
msg_det_mapping_array = surecom_omb_router_names_array.
  collect.each_with_index {|x,i|
   create_msg_det_mapping_array(x,i)
   }.align_regexp(/= /).unshift("-- bits 3:0 - Msg_det_sel - Message Detected Select\n").push("--\n")
#################################################################################



#################################################################################
  @vhdl_libs_heredoc = <<-END.gsub(/^ {2}/, '')
  library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  --   
  library ptss_lib;
  use ptss_lib.ptss_pkg.all;
  use ptss_lib.router_top_pkg.all;
  --synthesis translate_off
  use ptss_lib.pkg_probe;
  --synthesis translate_on
  --   
  library galaxy_bus_s7_lib;
  use galaxy_bus_s7_lib.galaxy_bus_pkg.all;
   
   
  END
#################################################################################


#################################################################################
  @entity_begin_heredoc = <<-END.gsub(/^ {2}/, '   ')
  entity #{@design_name} is
  generic(
     g_reset                 :     std_logic := '1'   -- Sets asserted level of async reset (arst)
         );
  port(
     -- Local control signals
     Clk_omb                       : in  std_logic;
     Reset                         : in  std_logic;
  END
#################################################################################


#################################################################################
def create_router_entity_inputs(temparg)
  temparg_upcase = temparg.upcase
  temparg_capitalize = temparg.capitalize
  #
  @fpga_signals = <<-END.gsub(/^ {2}/, '      ')
  -- #{temparg_upcase} IF IN PORT
  #{temparg_capitalize}_to_router_sof            : in  std_logic;
  #{temparg_capitalize}_to_router_eof            : in  std_logic;
  #{temparg_capitalize}_to_router_valid          : in  std_logic;
  #{temparg_capitalize}_to_router_data           : in  std_logic_vector(GBUS_RANGE);
  #{temparg_capitalize}_to_router_ready          : out std_logic;
  END
end
#################################################################################


#################################################################################
def create_router_entity_outputs(temparg)
  temparg_upcase = temparg.upcase
  temparg_capitalize = temparg.capitalize
  #
  @fpga_signals = <<-END.gsub(/^ {2}/, '      ')
  -- #{temparg_upcase} IF OUT PORT
  Router_to_#{temparg}_ready          : in std_logic;
  Router_to_#{temparg}_sof            : out  std_logic;
  Router_to_#{temparg}_eof            : out  std_logic;
  Router_to_#{temparg}_valid          : out  std_logic;
  Router_to_#{temparg}_data           : out  std_logic_vector(GBUS_RANGE);
  END
end
#################################################################################


#################################################################################
def create_instance_port_map_router_outputs(temparg)
  temparg_capitalize = temparg.capitalize
  ##
  @tb_dut_inst = <<-END.gsub(/^ {2}/, '   ')
        -- #{temparg} IF out ports
        Router_to_#{temparg}_sof     => router_to_#{temparg}.sof,
        Router_to_#{temparg}_eof     => router_to_#{temparg}.eof,
        Router_to_#{temparg}_valid   => router_to_#{temparg}.valid,
        Router_to_#{temparg}_ready   => router_to_#{temparg}.ready,
        Router_to_#{temparg}_data    => router_to_#{temparg}.data,
  END
end
#################################################################################


#################################################################################
  @dut_instance_msg_det_ports_heredoc = <<-END.gsub(/^ {2}/, '  ')
         -- msg detected if
         Router_top_msg_det_select     => router_top_msg_det_select,
         Router_top_msg_detected       => router_top_msg_detected,
  END
#################################################################################


#################################################################################
  @dut_instance_header = <<-END.gsub(/^ {2}/, '  ')
   inst_#{@design_name}: entity work.#{@design_name}
      port map (         
         Clk_omb                => clk_omb,
         Reset                  => reset,
  END
#################################################################################


#################################################################################
def create_instance_port_map_router_inputs(temparg)
  temparg_capitalize = temparg.capitalize
  ##
  @tb_dut_inst = <<-END.gsub(/^ {2}/, '   ')
        -- #{temparg} IF in ports
        #{temparg_capitalize}_to_router_sof    => #{temparg}_to_router.sof,
        #{temparg_capitalize}_to_router_eof    => #{temparg}_to_router.eof,
        #{temparg_capitalize}_to_router_valid  => #{temparg}_to_router.valid,
        #{temparg_capitalize}_to_router_ready  => #{temparg}_to_router.ready,
        #{temparg_capitalize}_to_router_data   => #{temparg}_to_router.data,
  END
end
#################################################################################


#################################################################################
def create_instance_input_signals(temparg)
  temparg_upcase = temparg.upcase
  temparg_capitalize = temparg.capitalize
  ##
  @tb_dut_inst = <<-END.gsub(/^ {2}/, '   ')
   -- #{temparg} signals
   signal #{temparg}_to_router_sof            : std_logic;                   
   signal #{temparg}_to_router_eof            : std_logic;                   
   signal #{temparg}_to_router_valid          : std_logic;                   
   signal #{temparg}_to_router_ready          : std_logic;
   signal #{temparg}_to_router_data           : std_logic_vector(GBUS_RANGE);                   
  END
end
#################################################################################


#################################################################################
def create_instance_output_signals(temparg)
  temparg_upcase = temparg.upcase
  temparg_capitalize = temparg.capitalize
  ##
  @tb_dut_inst = <<-END.gsub(/^ {2}/, '   ')
   -- #{temparg_capitalize} signals
   signal router_to_#{temparg}_sof            : std_logic;                   
   signal router_to_#{temparg}_eof            : std_logic;                   
   signal router_to_#{temparg}_valid          : std_logic;                   
   signal router_to_#{temparg}_ready          : std_logic;
   signal router_to_#{temparg}_data           : std_logic_vector(GBUS_RANGE);                   
  END
end
#################################################################################


#################################################################################
def create_instance_input_signals_record_type(temparg)
  temparg_upcase = temparg.upcase
  ##
  @tb_dut_inst = <<-END.gsub(/^ {2}/, '   ')
  signal #{temparg}_to_router  : T_ROUTER_PORT_X1;
  END
end
#################################################################################


#################################################################################
def create_instance_output_signals_record_type(temparg)
  temparg_upcase = temparg.upcase
  ##
  @tb_dut_inst = <<-END.gsub(/^ {2}/, '   ')
  signal router_to_#{temparg}  : T_ROUTER_PORT_X1;
  END
end
#################################################################################



#################################################################################
  @tb_signals_msg_det_heredoc = <<-END.gsub(/^ {2}/, '   ')
  -- msg detected if
  signal router_top_msg_det_select_tb  :  std_logic_vector(3 downto 0);
  signal router_top_msg_detected_tb    :  std_logic_vector(15 downto 0);
  END
#################################################################################


#################################################################################
  @signals_msg_det_signals_heredoc = <<-END.gsub(/^ {2}/, '   ')
  -- msg detected if
  signal router_top_msg_det_select  :  std_logic_vector(3 downto 0);
  signal router_top_msg_detected    :  std_logic_vector(15 downto 0);
  END
#################################################################################


#################################################################################
  @tb_dut_instance_msg_det_ports_heredoc = <<-END.gsub(/^ {2}/, '  ')
         -- msg detected if
         Router_top_msg_det_select     => router_top_msg_det_select_tb,
         Router_top_msg_detected       => router_top_msg_detected_tb,
  END
#################################################################################


#################################################################################
  @dut_tb_instance_header = <<-END.gsub(/^ {2}/, '  ')
   dut: entity work.#{@design_name}
      port map (         
         Clk_omb                => clk_150M,
         Reset                  => arst,
  END
#################################################################################


#################################################################################
  @entity_msg_det_heredoc = <<-END.gsub(/^ {2}/, '      ')
  -- MSG DETECTED IF
  Router_top_msg_det_select     : in  std_logic_vector(3 downto 0);
  Router_top_msg_detected       : out std_logic_vector(15 downto 0);
  END
#################################################################################


#################################################################################
  @entity_end_heredoc = <<-END.gsub(/^ {2}/, '')
     );
  end #{@design_name};
  --------------------------------------------------------------------------------

  
  END
#################################################################################


#################################################################################
  @msg_det_heredoc = <<-END.gsub(/^ {2}/, '   ')
  ptss_router_msg_det_select_un          <= unsigned(Ptss_router_msg_det_select);
   
  msg_det_proc : process(clk_omb,Reset)
  begin
     --if (Reset /= '0') then
     if (Reset = g_reset) then
           --Ptss_router_msg_detected   <= '0';
     elsif ((clk_omb'event) and (clk_omb = '1')) then
        --
        case Ptss_router_msg_det_select_un is
           when x"0"  => 
              Ptss_router_msg_detected  <= cpumsg_router_msg_detected;
           when x"1"  => 
              Ptss_router_msg_detected  <= ctlmsg_router_msg_detected;
           when x"2"  => 
              Ptss_router_msg_detected  <= gbusmsg_router_msg_detected;
           --when x"03"  => 
           --   route_table_port_id(3)  <= '1';
           --when x"04"  => 
           --   route_table_port_id(4)  <= '1';
           --when x"05"  => 
           --   route_table_port_id(5)  <= '1';
           --when x"06"  => 
           --   route_table_port_id(6)  <= '1';
           --when x"07"  => 
           --   route_table_port_id(7)  <= '1';
           --when x"08"  => 
           --   route_table_port_id(8)  <= '1';
           --when x"09"  => 
           --   route_table_port_id(9)  <= '1';
           --when x"0a"  => 
           --   route_table_port_id(10) <= '1';
           --when x"0b"  => 
           --   route_table_port_id(11) <= '1';
           --when x"0c"  => 
           --   route_table_port_id(12) <= '1';
           --when x"0d"  => 
           --   route_table_port_id(13) <= '1';
           --when x"0e"  => 
           --   route_table_port_id(14) <= '1';
           --when x"0f"  => 
           --   route_table_port_id(15) <= '1';
           when others       => 
              Ptss_router_msg_detected  <= gbusmsg_router_msg_detected;
              null;
              --Ptss_router_msg_detected  <= ;     <= (others => '0');
        end case;
     end if;
  end process;


  --
  END
##################################################################################


#################################################################################
  @router_constants = <<-END.gsub(/^ {2}/, '   ')
  -----------------------------------------------------------------------------
  -- Number router ports
  -----------------------------------------------------------------------------
  constant C_SURECOM_OMB_ROUTER_BLK_ID_PORTS    : positive := 16;
  constant C_SURECOM_OMB_ROUTER_PWR_STEER_PORTS : positive := 16;
  constant C_SURECOM_OMB_ROUTER_NN_PN_PORTS     : positive := 16;
  
  END

router_constant_arrary = [@router_constants]
#################################################################################


#################################################################################
  @mux_ports_constats_header = <<-END.gsub(/^ {2}/, '   ')
  -----------------------------------------------------------------------------
  -- Number mux ports
  -----------------------------------------------------------------------------
  END
#################################################################################


#################################################################################
  @msg_det_mux_header_heredoc = <<-END.gsub(/^ {2}/, '   ')
  -----------------------------------------------------------------------------
  --Mux for message detected indications
  msg_det_proc : process(clk_omb,Reset)
  begin
     if (Reset = g_reset) then
           Router_top_msg_detected   <= (others => '0');
     elsif ((clk_omb'event) and (clk_omb = '1')) then
        --
        case  Unsigned(Router_top_msg_det_select) is
  END
#################################################################################


#################################################################################
def create_msg_det_case_arms(temparg,index_0_based)
  temparg_upcase = temparg.upcase
  ##
  @msg_det_case_arms = <<-END.gsub(/^ {2}/, '            ')
  when x"#{index_0_based.to_s(16)}" =>
     Router_top_msg_detected <= block_id_msg_detected.#{temparg};
  END
end
#################################################################################


#################################################################################
  @msg_det_mux_trailer_heredoc = <<-END.gsub(/^ {2}/, '   ')
           when others =>
              Router_top_msg_detected <= (others => '0');
           --
        end case;
     end if;
  end process;
  -----------------------------------------------------------------------------

  
  END
#################################################################################



#################################################################################
def create_mux_constants(temparg)
  temparg_upcase = temparg.upcase
  ##
  @fpga_signals = <<-END.gsub(/^ {2}/, '   ')
  constant C_#{temparg_upcase}_MUX_IN_PORTS                   : integer := 8;
  END
end
#################################################################################


#################################################################################
def create_tb_procedure_arg_constants(temparg,index)
  temparg_upcase = temparg.upcase
  ##
  @proc_arg = <<-END.gsub(/^ {2}/, '   ')
  constant C_#{temparg_upcase}_ROUTER             : natural := #{index};
  END
end
#################################################################################


#################################################################################
def create_msg_det_type_body(temparg,index)
  temparg_upcase = temparg.upcase
  ##
  @proc_arg = <<-END.gsub(/^ {2}/, '         ')
  #{temparg}        : std_logic_vector(15 downto 0);
  END
end
#################################################################################


#################################################################################
def create_tb_input_mux_inst(temparg,index)
  temparg_upcase = temparg.upcase
  ##
  @tb_dut_inst = <<-END.gsub(/^ {2}/, '   ')
         --
         when #{index}  =>                                 
            #{temparg}_to_router_tb.sof       <=  sof_in_port_tb;         
            #{temparg}_to_router_tb.eof       <=  eof_in_port_tb;         
            #{temparg}_to_router_tb.valid     <=  valid_in_port_tb;       
            #{temparg}_to_router_tb.data      <=  data_in_port_tb;        
            ready_in_port_tb                  <=  #{temparg}_router_in_tb.ready;
  END
end
#################################################################################


#################################################################################
def create_tb_port_map_router_outputs_inst(temparg)
  temparg_capitalize = temparg.capitalize
  ##
  @tb_dut_inst = <<-END.gsub(/^ {2}/, '   ')
        -- #{temparg} IF out ports
        Router_to_#{temparg_capitalize}_sof            => Router_to_#{temparg}_tb.sof,
        Router_to_#{temparg_capitalize}_eof            => Router_to_#{temparg}_tb.eof,
        Router_to_#{temparg_capitalize}_valid          => Router_to_#{temparg}_tb.valid,
        Router_to_#{temparg_capitalize}_ready          => Router_to_#{temparg}_tb.ready,
        Router_to_#{temparg_capitalize}_data           => Router_to_#{temparg}_tb.data,
  END
end
#################################################################################


#################################################################################
def create_tb_port_map_router_inputs_inst(temparg)
  temparg_capitalize = temparg.capitalize
  ##
  @tb_dut_inst = <<-END.gsub(/^ {2}/, '   ')
        -- #{temparg_capitalize} IF in ports
        #{temparg_capitalize}_to_router_sof            => #{temparg}_to_router_tb.sof,
        #{temparg_capitalize}_to_router_eof            => #{temparg}_to_router_tb.eof,
        #{temparg_capitalize}_to_router_valid          => #{temparg}_to_router_tb.valid,
        #{temparg_capitalize}_to_router_ready          => #{temparg}_to_router_tb.ready,
        #{temparg_capitalize}_to_router_data           => #{temparg}_to_router_tb.data,
  END
end
#################################################################################


#################################################################################
def create_tb_input_signals_inst(temparg)
  temparg_upcase = temparg.upcase
  ##
  @tb_dut_inst = <<-END.gsub(/^ {2}/, '   ')
  signal #{temparg}_to_router_tb  : T_ROUTER_PORT_X1 := C_ROUTER_PORT_INIT;
  END
end
#################################################################################


#################################################################################
def create_tb_output_signals_inst(temparg)
  temparg_upcase = temparg.upcase
  ##
  @tb_dut_inst = <<-END.gsub(/^ {2}/, '   ')
  signal Router_to_#{temparg}_router_tb  : T_ROUTER_PORT_X1;
  END
end
#################################################################################





#################################################################################
def create_router_signals(temparg)
  temparg_upcase = temparg.upcase
  ##
  @fpga_signals = <<-END.gsub(/^ {2}/, '   ')
  -----------------------------------------------------------------------------
  -- Internal connections to #{temparg} router
  -----------------------------------------------------------------------------
  -- data direction: router -> mux 
  signal #{temparg}_router_blockid_port              :T_ROUTER_OUT_PORT_OUTPUTS;
  signal #{temparg}_router_pwr_steer_port            :T_ROUTER_OUT_PORT_OUTPUTS;
  signal #{temparg}_router_next_node_port            :T_ROUTER_OUT_PORT_OUTPUTS;
  signal #{temparg}_router_previous_node_port        :T_ROUTER_OUT_PORT_OUTPUTS;
  --
  -- data direction: mux -> router 
  signal #{temparg}_router_ready                     :T_ROUTER_TOP_READY;
  --
  
  END
end
#################################################################################


#################################################################################
def create_mux_signals(temparg)
  temparg_upcase = temparg.upcase
  ##
  @fpga_signals = <<-END.gsub(/^ {2}/, '   ')
  -----------------------------------------------------------------------------
  -- Internal connections to #{temparg} mux
  -----------------------------------------------------------------------------
  signal #{temparg}_mux_in_port                        :T_MUX_IN_PORT;
  signal #{temparg}_mux_in_ready                       :std_logic_vector(C_#{temparg_upcase}_MUX_IN_PORTS-1 downto 0);

  END
end
#################################################################################


#################################################################################
  @connection_constants_heredoc = <<-END.gsub(/^ {2}/, '   ')
  -----------------------------------------------------------------------------
  -- Interconnect/Connection constants generally use syntax of the form 'from to'
  --
  -- Specifically, additional detail is embedded in the constant name that
  -- correlates with the constant values and the constants use.  The value is a
  -- record of two natural numbers.  The detailed general form name is composed
  -- of several strings joined by an underscrore as shown below.
  --
  -- C from_location  strategy  strategy_index  to_location  to_index
  --
  -- Specific examples
  -- 
  -- C_CPUMSG_PN_SCH1_MUX_0
  --    from_location   cpumsg
  --    strategy        previous node
  --    strategy_index  0
  --    to_location     sch1
  --    to_index        0
  --
  -- C_GBUSMSG_BLK2_REGCFG_MUX_0
  --    from_location   gbusmsg
  --    strategy        block id
  --    strategy_index  2
  --    to_location     regcfg
  --    to_index        0
  --
  -- Notes on constant names and values
  -- Set the value router_index to be what is encoded in the name strategy index field.
  -- Set the value mux_index to be what is encoded in the name mux index field.
  -- Strategy index 0 must be used for strategy previous node.
  -- Use strategy index 0 and strategy steering for next node.
  -- To route using a block id N, use that strategy index N, strategy block id.
  -- 
  -----------------------------------------------------------------------------
  -- Connections to the SCH1 MUX 
  constant C_CPUMSG_PN_SCH1_MUX_0                 : T_CONNECTION_TYPE:= (router_index => 0, mux_index => 0);  
  constant C_CTLMSG_PN_SCH1_MUX_1                 : T_CONNECTION_TYPE:= (router_index => 0, mux_index => 1);  
  constant C_GBUSMSG_PN_SCH1_MUX_2                : T_CONNECTION_TYPE:= (router_index => 0, mux_index => 2);  
  constant C_GIO1_PN_SCH1_MUX_2                   : T_CONNECTION_TYPE:= (router_index => 0, mux_index => 3);  
  --
  -- Connections to the REGCFG MUX
  constant C_GBUSMSG_BLK2_REGCFG_MUX_0            : T_CONNECTION_TYPE:=(router_index => 2, mux_index => 0);  
  constant C_GIO1_BLK2_REGCFG_MUX_1               : T_CONNECTION_TYPE:=(router_index => 2, mux_index => 1);  
  constant C_SCH1_BLK2_REGCFG_MUX_2               : T_CONNECTION_TYPE:=(router_index => 2, mux_index => 2);  
  constant C_SCH2_BLK2_REGCFG_MUX_3               : T_CONNECTION_TYPE:=(router_index => 2, mux_index => 3);  
  --
  -- Connections to the DDR_WRITE1 mux
  constant C_GBUSMSG_BLK8_DDR_WRITE1_MUX_0        : T_CONNECTION_TYPE:=(router_index => 8, mux_index => 0);  
  constant C_FRC1_BLK8_DDR_WRITE1_MUX_1           : T_CONNECTION_TYPE:=(router_index => 8, mux_index => 1);  
  constant C_GIO1_BLK8_DDR_WRITE1_MUX_2           : T_CONNECTION_TYPE:=(router_index => 8, mux_index => 2);  
  --
  -- Connections to the DDR_WRITE2 mux
  constant C_GBUSMSG_BLKA_DDR_WRITE2_MUX_0        : T_CONNECTION_TYPE:=(router_index => 10, mux_index => 0);  
  constant C_GIO1_BLKA_DDR_WRITE2_MUX_1           : T_CONNECTION_TYPE:=(router_index => 10, mux_index => 1);  
  constant C_FRC2_BLKA_DDR_WRITE2_MUX_2           : T_CONNECTION_TYPE:=(router_index => 10, mux_index => 2);  
  --
  -- Connections to the DDR_READ_IN1 mux
  constant C_GBUSMSG_BLK9_DDR_READ_IN1_MUX_0      : T_CONNECTION_TYPE:=(router_index => 9, mux_index => 0);  
  constant C_GIO1_BLK9_DDR_READ_IN1_MUX_1         : T_CONNECTION_TYPE:=(router_index => 9, mux_index => 1);  
  constant C_DMA_BLK9_DDR_READ_IN1_MUX_2          : T_CONNECTION_TYPE:=(router_index => 9, mux_index => 2);  
  --
  -- Connections to the DDR_READ_IN2 mux
  constant C_GBUSMSG_BLKB_DDR_READ_IN2_MUX_0      : T_CONNECTION_TYPE:=(router_index => 11, mux_index => 0);  
  constant C_DMA_BLKB_DDR_READ_IN2_MUX_1          : T_CONNECTION_TYPE:=(router_index => 11, mux_index => 1);  
  constant C_GIO1_BLKB_DDR_READ_IN2_MUX_2         : T_CONNECTION_TYPE:=(router_index => 11, mux_index => 2);  
  --
  -- Connections to the DMA mux
  constant C_GIO1_BLKD_DMA_MUX_0                  : T_CONNECTION_TYPE:=(router_index => 13, mux_index => 0);  
  --
  -- Connections to the FRC2 mux
  constant C_GIO1_BLK7_FRC2_MUX_0                 : T_CONNECTION_TYPE:=(router_index => 7, mux_index => 0);  
  constant C_DDR_READ_OUT1_BLK7_FRC2_MUX_1        : T_CONNECTION_TYPE:=(router_index => 7, mux_index => 1);  
  constant C_DDR_READ_OUT2_BLK7_FRC2_MUX_2        : T_CONNECTION_TYPE:=(router_index => 7, mux_index => 2);  
  --
  -- Connections to the FRC1 mux
  constant C_GIO1_BLK6_FRC1_MUX_0                 : T_CONNECTION_TYPE:=(router_index => 6, mux_index => 0);  
  constant C_DDR_READ_OUT1_BLK6_FRC1_MUX_1        : T_CONNECTION_TYPE:=(router_index => 6, mux_index => 1);  
  constant C_DDR_READ_OUT2_BLK6_FRC1_MUX_2        : T_CONNECTION_TYPE:=(router_index => 6, mux_index => 2);  
  --
  -- Connections to the FLASH mux
  constant C_GIO1_BLKE_FLASH_MUX_0                : T_CONNECTION_TYPE:=(router_index => 14, mux_index => 0);  
  constant C_GBUSMSG_BLKE_FLASH_MUX_1             : T_CONNECTION_TYPE:=(router_index => 14, mux_index => 1);  
  --
  -- Connections to the GIO4 mux
  constant C_DDR_READ_OUT1_ST3_GIO4_MUX_0         : T_CONNECTION_TYPE:=(router_index => 3, mux_index => 0);  
  constant C_DDR_READ_OUT2_ST3_GIO4_MUX_1         : T_CONNECTION_TYPE:=(router_index => 3, mux_index => 1);  
  --
  -- Connections to the GIO3 mux
  constant C_DDR_READ_OUT1_ST2_GIO3_MUX_0         : T_CONNECTION_TYPE:=(router_index => 2, mux_index => 0);  
  constant C_DDR_READ_OUT2_ST2_GIO3_MUX_1         : T_CONNECTION_TYPE:=(router_index => 2, mux_index => 1);  
  --
  -- Connections to the GIO2 mux
  constant C_DDR_READ_OUT1_ST1_GIO2_MUX_0         : T_CONNECTION_TYPE:=(router_index => 1, mux_index => 0);  
  constant C_DDR_READ_OUT2_ST1_GIO2_MUX_1         : T_CONNECTION_TYPE:=(router_index => 1, mux_index => 1);  
  --
  -- Connections to the GIO1 mux
  constant C_FRC1_S0NN_GIO1_MUX_0                 : T_CONNECTION_TYPE:=(router_index => 0, mux_index => 0);  
  constant C_FRC2_S0NN_GIO1_MUX_1                 : T_CONNECTION_TYPE:=(router_index => 0, mux_index => 1);  
  constant C_DDR_READ_OUT1_S0NN_GIO1_MUX_2        : T_CONNECTION_TYPE:=(router_index => 0, mux_index => 2);  
  constant C_DDR_READ_OUT2_S0NN_GIO1_MUX_3        : T_CONNECTION_TYPE:=(router_index => 0, mux_index => 3);  
  constant C_FLASH_S0NN_GIO1_MUX_4                : T_CONNECTION_TYPE:=(router_index => 0, mux_index => 4);  
  constant C_REGCFG_S0NN_GIO1_MUX_5               : T_CONNECTION_TYPE:=(router_index => 0, mux_index => 5);  
  constant C_SCH1_S0NN_GIO1_MUX_6                 : T_CONNECTION_TYPE:=(router_index => 0, mux_index => 6);  
  --
  -- Connections to the GBUSMSG mux
  constant C_DDR_READ_OUT1_BLK3_GBUSMSG_MUX_0     : T_CONNECTION_TYPE:=(router_index => 3, mux_index => 0);  
  constant C_DDR_READ_OUT2_BLK3_GBUSMSG_MUX_1     : T_CONNECTION_TYPE:=(router_index => 3, mux_index => 1);  
  constant C_REGCFG_BLK3_GBUSMSG_MUX_2            : T_CONNECTION_TYPE:=(router_index => 3, mux_index => 2);  
  constant C_SCH1_BLK3_GBUSMSG_MUX_3              : T_CONNECTION_TYPE:=(router_index => 3, mux_index => 3);  
  --
  -- Connections to the SEGRX1 mux
  constant C_SCH1_BLK4_SEGRX1_MUX_0               : T_CONNECTION_TYPE:=(router_index => 4, mux_index => 0);  
  --
  -- Connections to the CPUMSG mux
  constant C_SCH1_BLKC_CPUMSG_MUX_0               : T_CONNECTION_TYPE:=(router_index => 12, mux_index => 0);  
  --
  -- Connections to the CTLMSG mux
  constant C_SCH1_BLK1_CTLMSG_MUX_0               : T_CONNECTION_TYPE:=(router_index => 1, mux_index => 0);  
  constant C_SCH2_BLK1_CTLMSG_MUX_1               : T_CONNECTION_TYPE:=(router_index => 1, mux_index => 1);  
  --
  -- Connections to the SEGRX2 mux
  constant C_SCH2_BLK5_SEGRX2_MUX_0               : T_CONNECTION_TYPE:=(router_index => 5, mux_index => 0);  

  
  END
#
connection_constants_array = @connection_constants_heredoc.split("\n").align_regexp(/:/) 
#################################################################################


#################################################################################
  @message_detected_signals_heredoc = <<-END.gsub(/^ {2}/, '   ')
  
  -----------------------------------------------------------------------------
  --Message detected
  signal block_id_msg_detected     :T_MSG_DETECTED;
  -----------------------------------------------------------------------------
  END
#################################################################################


#################################################################################
def create_mux_instances(temparg)
  ##
  #
  temparg_cap    = temparg.capitalize
  temparg_upcase = temparg.upcase
  #

  @fpga_instance = <<-END.gsub(/^ {2}/, '   ')
   -- #{temparg_cap} output port 
   inst_#{temparg}_mux: entity work.OMB_MUX
      generic map (
         IN_PORTS       => C_#{temparg_upcase}_MUX_IN_PORTS
         )               
      port map (         
         Clk            => Clk_omb,
         Rst            => Reset,
         --in port(s)    
         Sof_in_port    => #{temparg}_mux_in_port.sof,  
         Eof_in_port    => #{temparg}_mux_in_port.eof,  
         Valid_in_port  => #{temparg}_mux_in_port.valid,
         Ready_in_port  => #{temparg}_mux_in_ready,
         Data_in_port   => #{temparg}_mux_in_port.data, 
         --out port      
         Sof_out_port   => Router_to_#{temparg}_sof,
         Eof_out_port   => Router_to_#{temparg}_eof,
         Valid_out_port => Router_to_#{temparg}_valid,
         Ready_out_port => Router_to_#{temparg}_ready,
         Data_out_port  => Router_to_#{temparg}_data
         );


  END
end
#################################################################################


#################################################################################
def create_router_instances(temparg)
  #
  temparg_cap = temparg.capitalize
  #
  ##
  @fpga_instance = <<-END.gsub(/^ {2}/, '   ')
  -- Messages from the fpga top level function #{temparg} enter this module instance
  -- (surecom_omb_router) and are directed to one of its outputs
  -- #{temparg}_router_block_id_port, #{temparg}_router_pwr_steer_port, or
  -- #{temparg}_router_previous_node_port based on the message fields RI qw
  inst_#{temparg}_router: entity work.surecom_omb_router
     generic map (
        G_SURECOM_OMB_ROUTER_NN_PN_OUT_PORTS      => C_SURECOM_OMB_ROUTER_NN_PN_PORTS,
        G_SURECOM_OMB_ROUTER_BLK_ID_OUT_PORTS     => C_SURECOM_OMB_ROUTER_BLK_ID_PORTS,
        G_SURECOM_OMB_ROUTER_PWR_STEER_OUT_PORTS  => C_SURECOM_OMB_ROUTER_PWR_STEER_PORTS
        )
     port map (
        Clk                          => Clk_omb,
        Reset                        => Reset,
        -- router in port
        Sof_in_port                  => #{temparg_cap}_to_router_sof,
        Eof_in_port                  => #{temparg_cap}_to_router_eof,
        Valid_in_port                => #{temparg_cap}_to_router_valid,
        Ready_in_port                => #{temparg_cap}_to_router_ready,
        Data_in_port                 => #{temparg_cap}_to_router_data,
        --Block ID out port
        Block_sof_out_port           => #{temparg}_router_blockid_port.sof,
        Block_eof_out_port           => #{temparg}_router_blockid_port.eof,
        Block_valid_out_port         => #{temparg}_router_blockid_port.valid,
        Block_ready_out_port         => #{temparg}_router_ready.block_id,
        Block_data_out_port          => #{temparg}_router_blockid_port.data,
        --Pwr steer out port
        Pwr_steer_sof_out_port       => #{temparg}_router_pwr_steer_port.sof,
        Pwr_steer_eof_out_port       => #{temparg}_router_pwr_steer_port.eof,
        Pwr_steer_valid_out_port     => #{temparg}_router_pwr_steer_port.valid,
        Pwr_steer_ready_out_port     => #{temparg}_router_ready.pwr_steer,
        Pwr_steer_data_out_port      => #{temparg}_router_pwr_steer_port.data,
        --Previous node out port                                               
        Previous_node_sof_out_port   => #{temparg}_router_previous_node_port.sof,
        Previous_node_eof_out_port   => #{temparg}_router_previous_node_port.eof,
        Previous_node_valid_out_port => #{temparg}_router_previous_node_port.valid,
        Previous_node_ready_out_port => #{temparg}_router_ready.previous_node,
        Previous_node_data_out_port  => #{temparg}_router_previous_node_port.data,
        --Message detected
        Block_id_msg_detected        => block_id_msg_detected.#{temparg}
        );


  END
end
#################################################################################


#################################################################################
def create_mux_driver_processs(temparg)
  ##
  @mux_driver_proc = <<-END.gsub(/^ {2}/, '   ')
  -------------------------------------------------------------------------------
  #{temparg}_mux_proc:
   process(ctlmsg_router_previous_node_port, cpumsg_router_previous_node_port,gbusmsg_router_previous_node_port) 
   begin
   --route CPU MSG block id port 0 to sch1 mux port 0
   --route CTL MSG block id port 0 to sch1 mux port 1
   --
   #{temparg}_mux_in_port  <= router_port_to_mux_port_func
                           (
                           cpumsg_router_previous_node_port, C_CPUMSG_PN_SCH1_MUX_0,
                           ctlmsg_router_previous_node_port, C_CTLMSG_PN_SCH1_MUX_1,
                           gbusmsg_router_previous_node_port,C_GBUSMSG_PN_SCH1_MUX_2
                           );
   end process;
  -------------------------------------------------------------------------------


  END
end
#################################################################################


#################################################################################
def create_ready_driver_processs(temparg)
  ##
  @mux_driver_proc = <<-END.gsub(/^ {2}/, '   ')
  -------------------------------------------------------------------------------
   #{temparg}_drive_ready_to_mux_proc : 
   process(sch1_mux_in_ready) 
   begin
      ----tie off un-used ready's using C_ROUTER_READY_ALL_ONES so that:
      ----A message sent to an unused port does not lock up the router
      ----Prevent 'U' in simulation
      ----Prevent "undriven" warnings in synthesis
      #{temparg}_router_ready        <= C_ROUTER_READY_ALL_ONES;
      --
      #{temparg}_router_ready.previous_node(C_CPUMSG_PN_SCH1_MUX_0.router_index) <= 
         sch1_mux_in_ready(C_CPUMSG_PN_SCH1_MUX_0.mux_index);  
      ----
   end process;
  -------------------------------------------------------------------------------


  END
end
#################################################################################


#################################################################################
def create_ready_child(key_arg,val_array)

  #as reference here is the hash format, the values are each aoa
  ##################################################################################
  #router_readys_hash = {
  #   "cpumsg"  => [
  #                  ["previous_node", "C_CPUMSG_PN_SCH1_MUX_0", "sch1_mux_in_ready",],  
  #                  ["previous_node", "C_CPUMSG_PN_SCH1_MUX_0", "other_mux_in_ready"]
  #                ], 
  #                     }
  ##################################################################################
  #
  @mux_child_proc = <<-END.gsub(/^ {2}/, '  ')
  --
  #{key_arg}_router_ready.#{val_array[0]}(#{val_array[1]}.router_index) <= 
     #{val_array[2]}_mux_in_ready(#{val_array[1]}.mux_index);  
  END
end
#################################################################################


#################################################################################
#Create more than one unique instance
# router instance names for comment header
# Objects are chunked together because there are groups of several that are
# named similarly.
router_instance_list_chunks_array = surecom_omb_router_names_array.collect {|x|
   create_router_instance_list(x)
   }
#
mux_instance_list_chunks_array = surecom_omb_mux_names_array.collect {|x|
   create_mux_instance_list(x)
   }
#
inputs_array  = (@input_modules_heredoc.split(/\n$/) +router_instance_list_chunks_array).
                assure_elements_have_ending_newline
#                
outputs_array = (@ouput_modules_heredoc.split(/\n/) + mux_instance_list_chunks_array).
                assure_elements_have_ending_newline
                
instance_list_array = 
                       (inputs_array + outputs_array).
                       join.
                       split("\n").
                       align_regexp(/:/)
#################################################################################


# #################################################################################
# # testbench constants as procedure args
# msg_det_mapping_array = surecom_omb_router_names_array.
#   collect.each_with_index {|x,i|
#    create_tb_procedure_arg_constants(x,i)
#    }.align_regexp(/:/).unshift("  -- procedure constants\n").push("\n")
# #################################################################################


#################################################################################
#Create more than one unique instance
# entity inputs_array
# Objects are chunked together because there are groups of several that are
# named similarly.
router_entity_inputs_chunks_array = surecom_omb_router_names_array.collect {|x|
   create_router_entity_inputs(x)
   }
#
#Seperate them so that they may be alligned
router_entity_inputs_array = 
  router_entity_inputs_chunks_array.join.split("\n").align_regexp(/:/)
#################################################################################


#################################################################################
#Create more than one unique instance
# entity ouputs
# Objects are chunked together because there are groups of several that are
# named similarly.
router_entity_outputs_chunks_array = surecom_omb_mux_names_array.collect {|x|
   create_router_entity_outputs(x)
   }
#
#Seperate them so that they may be alligned
router_entity_outputs_array = 
  router_entity_outputs_chunks_array.join.split("\n").align_regexp(/:/)
#################################################################################


#################################################################################
vhdl_arch =   ["\n","\n","architecture rtl of #{@design_name} is","\n", "\n"]
#################################################################################


#################################################################################
vhdl_begin =   ["\n","\n","begin","\n", "\n"]
#################################################################################


#################################################################################
vhdl_end_of_file =   ["end rtl;"]
#################################################################################


#################################################################################
#Create more than one unique instance
## constants
msg_det_case_arms_array = surecom_omb_router_names_array.collect.each_with_index {|x,i|
   create_msg_det_case_arms(x,i)
   }
#################################################################################


#################################################################################
#Create more than one unique instance
## constants
mux_constant_array = surecom_omb_mux_names_array.collect {|x|
   create_mux_constants(x)
   # }.align_regexp(/:/).unshift(@mux_ports_constats_header) + ["\n"]
   }.unshift(@mux_ports_constats_header) + ["\n"]
   #}.unshift(@mux_ports_constats_header) + ["\n"]
#################################################################################


#################################################################################
#Create more than one unique instance
# signals as mux actuals
# signals are chunked together because there are groups of several that are
# named similarly.
omb_mux_signal_array_chunked = surecom_omb_mux_names_array.collect {|x|
   create_mux_signals(x)
   # } + ["-----------------------------------------------------------------------------"]
   }
#
#Seperate them so that they may be alligned
omb_mux_signal_array = omb_mux_signal_array_chunked.join.split("\n").align_regexp(/:/)
#################################################################################


#################################################################################
#Create more than one unique instance
# signals as router actuals
# signals are chunked together because there are groups of several that are
# named similarly.
router_signal_array_chunks = surecom_omb_router_names_array.collect {|x|
   create_router_signals(x)
   }
#
#Seperate them so that they may be alligned
router_signal_array = router_signal_array_chunks.join.split("\n").align_regexp(/:/)
#################################################################################


#################################################################################
# testbench constants as procedure args
msg_det_type_array = surecom_omb_router_names_array.
  collect.each_with_index {|x,i|
   create_msg_det_type_body(x,i)
   }.
     unshift("   type T_MSG_DETECTED is\n      record\n").
     push("   end record;\n\n").
     assure_elements_have_ending_newline.
     align_regexp(/:/).push("\n\n")
#################################################################################


#################################################################################
# testbench constants as procedure args
testbench_procedure_constants_array = surecom_omb_router_names_array.
  collect.each_with_index {|x,i|
   create_tb_procedure_arg_constants(x,i)
   }.align_regexp(/:/).unshift("  -- procedure constants\n").push("\n")
#################################################################################


#################################################################################
# testbench input record signals
testbench_input_signals_array = surecom_omb_router_names_array .collect {|x|
   create_tb_input_signals_inst(x)
   }.join.split("\n").align_regexp(/:/).unshift("  -- DUT input signals\n").push("\n")
#################################################################################


#################################################################################
# testbench output record signals
testbench_output_signals_array = surecom_omb_mux_names_array.collect {|x|
   create_tb_output_signals_inst(x)
   }.join.split("\n").align_regexp(/:/).unshift("  -- DUT output signals\n")
#################################################################################


#################################################################################
# testbench DUT instance inputs_array\w record signals
testbench_port_map_input_array = surecom_omb_router_names_array.collect {|x|
   create_tb_port_map_router_inputs_inst(x)
   }.join.split("\n").align_regexp(/=/)
#################################################################################


#################################################################################
# testbench instance\w record signals
testbench_port_map_output_array = surecom_omb_mux_names_array.collect {|x|
   create_tb_port_map_router_outputs_inst(x)
   }.join.split("\n").align_regexp(/=/).push("\n")
#################################################################################


#################################################################################
# testbench dut input mux
testbench_dut_input_mux_array = surecom_omb_router_names_array.collect.each_with_index {|x,i|
   create_tb_input_mux_inst(x,i)
   }.join.split("\n").align_regexp("<")
#################################################################################


#################################################################################
# instance input signals
instance_input_signals_array = surecom_omb_router_names_array.collect.each_with_index {|x|
   # create_instance_input_signals(x)
   create_instance_input_signals_record_type(x)
   }.join.split("\n").align_regexp(":")
#################################################################################


#################################################################################
# instance output signals
instance_output_signals_array = surecom_omb_mux_names_array.collect.each_with_index {|x|
   # create_instance_output_signals(x)
   create_instance_output_signals_record_type(x)
   }.join.split("\n").align_regexp(":")
#################################################################################


#################################################################################
# instance input ports
instance_port_map_input_array = surecom_omb_router_names_array.collect.each_with_index {|x|
   create_instance_port_map_router_inputs(x)
   }.join.split("\n").align_regexp(":")
#################################################################################


#################################################################################
# instance output ports
instance_port_map_output_array = surecom_omb_mux_names_array.collect.each_with_index {|x|
   create_instance_port_map_router_outputs(x)
   }.join.split("\n").align_regexp(":")
#################################################################################


#################################################################################
#Create more than one unique instance
# mux driver process
surecom_mux_process_array = surecom_omb_mux_names_array.collect {|x|
   create_mux_driver_processs(x)
   }
#################################################################################


#################################################################################
#Create more than one unique instance
# ready signals driven to router process
surecom_router_ready_array = surecom_omb_router_names_array.collect {|x|
   create_ready_driver_processs(x)
   }
#################################################################################


#################################################################################
#Create more than one unique instance
surecom_omb_router_instance_array = surecom_omb_router_names_array.collect {|x|
   create_router_instances(x)
   }
#################################################################################


#################################################################################
#Create more than one unique instance
omb_mux_instance_array = surecom_omb_mux_names_array.collect {|x|
   create_mux_instances(x)
   }
#################################################################################


#################################################################################
#Create more than one unique instance
omb_mux_instance_array = surecom_omb_mux_names_array.collect {|x|
   create_mux_instances(x)
   }
#################################################################################


################################################################################
def mux_driver_def(mux_driver_hash_key,mux_driver_hash_val)
  #
  if false
    puts "The key is #{mux_driver_hash_key}"
    puts "The value is #{mux_driver_hash_val}"
  end
  temp = mux_driver_hash_val
  #
  #evens are the signals
  if (mux_driver_hash_val.count/2) < 4
    myval_signals = mux_driver_hash_val.select.each_with_index { |str, i| i.even? }.uniq.join(",")
    processed_sensitivity_list = false
  else
    processed_sensitivity_list = true
    myval_signals_temp = mux_driver_hash_val.select.each_with_index { |str, i| i.even? }.uniq
    myval_signals = myval_signals_temp.collect.each_with_index { |str_element, i| 
        if (i == 1 ) || (i == 3)
          str_element + "\n      "
        else
          str_element
        end
        }.join(",")
  end
  ##
  myval_signals_4_comment = mux_driver_hash_val.select.each_with_index { |str, i| i.even? }.uniq
  myval_evens_only_comment_more = myval_signals_4_comment.collect.with_index {|str_element,index| 
     str_element.gsub(/^/,"  --   ").gsub(/_router.*$/,"").upcase}.join("\n")
  #
  @temp_array_of_2_joined_by_comma =Array.new
  #
  function_args = mux_driver_hash_val.each_slice(2) {|arg|
    @temp_array_of_2_joined_by_comma << arg.join(",")
    puts "temp array of 2 joined by comma\\w inspect:" ,@temp_array_of_2_joined_by_comma.inspect,""
    }
    #
  @temp_array_of_2_joined_by_comma_comma_end = @temp_array_of_2_joined_by_comma.collect {|x| x + ","}
  #
  @temp_array_of_2_joined_by_comma_comma_end[-1] = @temp_array_of_2_joined_by_comma.last
  #
  string_of_fn_args = @temp_array_of_2_joined_by_comma_comma_end.join("\n     ")
  #
  puts "\n","Temp array joined by \\n", string_of_fn_args,""
  #
  # these were in the heredoc as instrumentation.
  #-- processed_sensitivity_list is #{processed_sensitivity_list}
  #-- the count divided by 2 is #{mux_driver_hash_val.count/2}
  # these were in the heredoc as instrumentation.
  @fpga_signals = <<-END.gsub(/^ {2}/, '   ')
  -------------------------------------------------------------------------------
  -- Interconnect to the #{mux_driver_hash_key} omb_mux
  #{mux_driver_hash_key}_mux_proc:
  process(#{myval_signals})
  begin
  -- The following #{myval_signals_4_comment.count} top level fpga modules are router_top inputs
#{myval_evens_only_comment_more}
  -- are routed to the fpga top level module #{mux_driver_hash_key.upcase} which is router_top output.
  --
  -- Details of the route interconnect can be understood by inspecting the argements
  -- to the function below.
  #{mux_driver_hash_key}_mux_in_port <= router_port_to_mux_port_func(
     #{string_of_fn_args}
                                                    );
  end process;
  -------------------------------------------------------------------------------
  
  END
end
################################################################################


################################################################################
  @mux_proc_comment_heredoc = <<-END.gsub(/^ {2}/, '   ')
  -------------------------------------------------------------------------------
  -- function 'router_port_to_mux_port_func' implements the omb_mux side of the
  -- router interconnect.  
  --
  -- Usage is 
  -- mux_input = router_port_to_mux_port_func(
  --    signal_to_be_routed_1,indexing_constant_1,
  --    signal_to_be_routed_2,indexing_constant_2,
  --    ... 
  --    signal_to_be_routed_n,indexing_constant_n,)
  --
  -- The function's output is a record type signal which drives the mux inputs.
  --
  -- The function's input (it's arguments) are signal,constant pairs.  The signal
  -- is from a surecom_omb_router output, the constant provides indexing for both.  
  -- sides of the interconnect.
  --
  -- The input indexing constant has two parts, one specifies a particular
  -- signal from the router.  That particular signal is associated with routing
  -- behavior.  For example an index of 1, on the block id signal specifies
  -- block_id 1.  An index of 3 on the power steering signal specifies steer 3
  -- The other part of the constant specifies the index of the omb_mux.
  --
  -- Function overloads exist for 1 - 8 input signal,indexing_constant pairs.
  --
  -- Previous node connections always use signal index 0.
  --
  -- Next node connections share a commom physical connection with steering 0
  --  therefere always use index 0.
  --
  -- The function ties unused omb_mux inputs to 0, which is an inactive state.
  -------------------------------------------------------------------------------
  
  END
################################################################################


################################################################################
def router_readys_def(router_readys_hash_key,router_readys_hash_val)
  #
  #
  puts "the last is:"
  p router_readys_hash_val.flatten
  if router_readys_hash_val.flatten.last != "na"
  
  hash_val_as_single_array = router_readys_hash_val.flatten
  #
  # ref
  #stackoverflow.com/questions/24828271/iterating-over-an-array-of-arrays
  ready_sensitivity_list_array = 
    router_readys_hash_val.map{ |ary| 
          ary.last + "_mux_in_ready"}
  #
  #
  #
  #
  ready_sensitivity_list_string_temp_early = ready_sensitivity_list_array.uniq
  #
  if (ready_sensitivity_list_array.count) < 4
    #
    processed_sensitivity_list = false
    ready_sensitivity_list_string_temp = ready_sensitivity_list_string_temp_early
    #
  else
    processed_sensitivity_list = true
    
    ready_sensitivity_list_string_temp = 
      ready_sensitivity_list_string_temp_early.collect.each_with_index { |str_element, i| 
        if (i == 2 ) || (i == 5)
          str_element + "\n      "
        else
          str_element
        end
        }
  end
  #
  ready_sensitivity_list_string = ready_sensitivity_list_string_temp.join(",")
  #
  @ready_proc_child =
    router_readys_hash_val.map{ |ary| 
     # create_ready_child(router_readys_hash_key,ary)}.join("\n")
     create_ready_child(router_readys_hash_key,ary)}.join
  #
  debug_this = false
  if debug_this
    puts "Hash vals inside def #{router_readys_hash_val}",""
    puts "Hash vals inside def flatten #{hash_val_as_single_array}",""
    puts "ready_sensitivity_list_array #{ready_sensitivity_list_array}",""
    puts "The hash size is #{router_readys_hash_val.size}"
    puts "ready_sensitivity_list_array is a array " 
     if  ready_sensitivity_list_array.is_a?(Array)
       puts "its an array"
     end
  end
  #
  #
  debug2 = false
  if debug2 
    print "the child" ,"\n"
    puts @ready_proc_child  + "   --"
  end
  #
  @fpga_signals = <<-END.gsub(/^ {2}/, '   ')
  -------------------------------------------------------------------------------
  #{router_readys_hash_key}_router_ready_driven_from_muxes_proc : 
  process(#{ready_sensitivity_list_string}) 
  begin
  --
  --TIE OFF UN-USED READY'S USING C_ROUTER_READY_ALL_ONES SO THAT:
     -- 1 Message sent to an unused surecom_omb_router port does not lock up the router
     -- 2 Prevent 'U' in simulation
     -- 3 Prevent "undriven" warnings in synthesis
  #{router_readys_hash_key}_router_ready        <= C_ROUTER_READY_ALL_ONES;
  --
  --DRIVE READYS FROM #{ready_sensitivity_list_array.length} OMB MUXES TO #{router_readys_hash_key.upcase} SURECOM_OMB_ROUTER
#{@ready_proc_child + "   --"}
  end process;
  -------------------------------------------------------------------------------
   
  END
  else
  

  @myflag = "reached"
  puts "reached the else"
  
  @fpga_null_proc_for_tieoff = <<-END.gsub(/^ {2}/, '   ')
  -------------------------------------------------------------------------------
  --#{router_readys_hash_key}_router_ready_driven_from_muxes_proc : 
  --not a process, this router's outputs are not used in the current design.
  --this is where a process would be if the router were used in a functional way.
  --
  --TIE OFF UN-USED READY'S USING C_ROUTER_READY_ALL_ONES SO THAT:
     -- 1 Message sent to an unused surecom_omb_router port does not lock up the router
     -- 2 Prevent 'U' in simulation
     -- 3 Prevent "undriven" warnings in synthesis
  #{router_readys_hash_key}_router_ready <= C_ROUTER_READY_ALL_ONES;
  -------------------------------------------------------------------------------
   
  END

  end
end
################################################################################


################################################################################
mux_drivers_var = mux_driver_hash.collect {|key,val| 
  #temp[0] =  "#{key}  => #args"
  #p key, val
  mux_driver_def(key,val)
           }
#           
puts mux_drivers_var
################################################################################


################################################################################
if true
  router_ready_drivers_array = router_readys_hash.collect {|key,val| 
    #p key, val
    router_readys_def(key,val)
             }
  end
#           
puts router_readys_hash.values.flatten.inspect
#
puts router_ready_drivers_array
################################################################################


#################################################################################
msg_det_section = @msg_det_mux_header_heredoc.split("\n") + 
                    msg_det_case_arms_array + 
                      @msg_det_mux_trailer_heredoc.split("\n")
#################################################################################


tot_entity_array =
  @entity_begin_heredoc.split("\n") + 
    router_entity_inputs_array +
      router_entity_outputs_array +
        @entity_msg_det_heredoc.gsub!(/(.*)(;)(.*)/m,'\1\3').split("\n") +
          @entity_end_heredoc.split("\n")


tot_entity_array_realigned_together = 
  tot_entity_array.align_regexp(/:/).align_regexp(/std/)
#################################################################################
#concat
hdl_file = 
           @tmru_vhdl_header_start_heredoc.split("\n") +
           msg_det_mapping_array +
           @tmru_vhdl_header_instance_header_heredoc.split("\n")  +
           instance_list_array +
           @tmru_vhdl_header_end_heredoc.split("\n") +
           @vhdl_libs_heredoc.split("\n").assure_elements_have_ending_newline +
           # tot_entity_array.align_regexp(/:/) +
           tot_entity_array_realigned_together +
           vhdl_arch + 
           router_types_array +
           msg_det_type_array +
           connection_constants_array.align_regexp(/:/) +
           router_constant_arrary +
           mux_constant_array.align_regexp(/:/) +
           router_signal_array +
           omb_mux_signal_array +
           @message_detected_signals_heredoc.split("\n")  +
           vhdl_begin +
           #@mux_proc_comment_heredoc.split("\n") + moved to file header
           mux_drivers_var +
           router_ready_drivers_array +
           surecom_omb_router_instance_array +
           omb_mux_instance_array +
           msg_det_section+
           vhdl_end_of_file
#################################################################################


################################################################################
testbench_total_port_map = @dut_tb_instance_header.split("\n") +
                             testbench_port_map_input_array.align_regexp(/=>/) + 
                               testbench_port_map_output_array.align_regexp(/=>/) + 
                                 @tb_dut_instance_msg_det_ports_heredoc.split("\n").push("         );")

testbench_stuff = testbench_procedure_constants_array + 
                    testbench_input_signals_array + 
                      testbench_output_signals_array.push("\n") + 
                        @tb_signals_msg_det_heredoc.split("\n").push("\n") +
                          testbench_total_port_map.align_regexp(/=>/).join("\n").gsub!(/(.*)(,)(.*)/m,'\1\3').split("\n").push("\n") +
                            testbench_dut_input_mux_array
################################################################################


################################################################################
#dut  instance template 
  dut_instance_tot_entity = 
    @dut_instance_header.split("\n") +
      instance_port_map_input_array.align_regexp(/=/)  +
        instance_port_map_output_array.align_regexp(/=/) +
          @dut_instance_msg_det_ports_heredoc.split("\n")
  
  dut_instance = 
    instance_input_signals_array.align_regexp(/:/).unshift("   -- Router inputs")  +
      instance_output_signals_array.align_regexp(/:/).unshift("   -- Router outputs")  +
        @signals_msg_det_signals_heredoc.split("\n").push("\n"*2) +
        dut_instance_tot_entity.align_regexp(/=>/).push("         );").join("\n").gsub!(/(.*)(,)(.*)/m,'\1\3').split("\n")
        #dut_instance_tot_entity.align_regexp(/=>/).push("         );")
################################################################################


################################################################################
#write to files
File.open(output_file, "w+") do |f|
  hdl_file .each { |element| f.puts(element) }
end
################################################################################


################################################################################
#write to testbench files
File.open(tb_output_file, "w+") do |f|
  testbench_stuff.each { |element| f.puts(element) }
end
################################################################################


################################################################################
#write to dut instance file
File.open(dut_instance_file, "w+") do |f|
  dut_instance.each { |element| f.puts(element) }
end
################################################################################


#################################################################################
puts "Finished hdl_text_templates_test.rb run"
#################################################################################


puts dut_instance_tot_entity


puts "the msg_det_mapping_array is", msg_det_mapping_array
