# -*- coding: iso-8859-1 -*-
#################################################################################
require_relative "./router_data.rb"
require_relative "./router_common.rb"
#################################################################################


#################################################################################
# DDR_READ_OUT1   GIO4   MUX0   PWR_STEER_0
def create_routing_constant_name(from,to,strat,strat_index,mux_index)
  strat_index_hex = strat_index.to_i.to_s(16)
  
  if FALSE
    p "----" , strat_index_hex
  end
  #
  if strat.downcase =~ /.*prev.*/
  #dont add extra chars if its prev nodebeg
  temp_constant = 
    "C_" + 
      from + "_" +
        to + "_" + 
          "mux" + mux_index.to_s + "_" +
            strat
  #
  else
    temp_constant = 
      "C_" + 
       from + "_" +
         to + "_" + 
           "mux" + mux_index.to_s + "_" +
              strat + "_" + strat_index.to_i.to_s(16) 
             #strat + "_" + strat_index_hex 
               #strat_index.to_s # 
               #strat_index
  end
  
  if 1 && FALSE
    puts "the strat_index is #{strat_index}"
    puts "to  #{to}"
    
    if strat_index.is_a?(String) 
      puts "its a string"
    end

    if strat_index.is_a?(Integer) 
      puts "its a Integer"
    end

    p strat_index
    #puts strat_index.to_s(16)
    
  end
  

  if strat_index == 13  && FALSE
    puts " = 13 exiting"
    puts from,to,strat,strat_index,mux_index   
    exit
  end

  temp_constant.upcase
end
#################################################################################


#################################################################################
def create_lut_ref(route_from_location,
                     route_from_route_strategy,
                         route_from_route_strategy_index,
                           route_to_location)
  #
  temp_constant = 
    route_from_location + "_" + 
      route_to_location + "_" + 
        route_from_route_strategy  +"_" +
          route_from_route_strategy_index.to_s
end
#################################################################################


#################################################################################
def create_routing_constants(destination,sources_array_of_hash)
  #
  #this var is intended to be local to this def, and get re-created with each
  #call to the def
  lut_routing_constant_array ||= []
  #
  routing_constant_group_header = routing_constant_group_header_heredoc_def(destination)
  #
  routing_constants_group =  
  sources_array_of_hash.collect.each_with_index {|route_from,mux_index|
    #
    #locals to improve readability of line, does it?
    from_loc   = route_from[:route_from_location]
    strat      = route_from[:route_strategy]
    strat_indx = route_from[:route_strategy_index]
    dest       = destination
    #
    routing_constant_name = 
      create_routing_constant_name(from_loc,dest,strat,strat_indx,mux_index)
    #
    routing_constant = routing_constants_heredoc_def(routing_constant_name,route_from,mux_index)

    @mux_side_constants_for_ref_array  ||= []
    @mux_side_constants_for_ref_array << routing_constant_name
    #
    ###########################################################################
    # Look up table stuff
    # This creates an array of strings that can be created using the other
    # descriptor hash.  The position of the constant in the array gives the mux
    # index.
    #
    lut_ref    = create_lut_ref(from_loc, strat, strat_indx, dest)
    #  
    lut_routing_constant_array << lut_ref
    ###########################################################################
    #
    routing_constant
    }
  #
  #push an array of identifiers to the lut
  @route_descriptor_lut_destinations_are_keys_hash[destination] = lut_routing_constant_array 
  #
  routing_constant_group_header + routing_constants_group.join
  #
end
##############################################################################


#################################################################################
def routing_constant_group_header_heredoc_def(route_to)
  #
  constant_group_header = <<-END.gsub(/^ {2}/, '   ')
  -- Destination #{route_to}
  END
  #
end
##############################################################################


#################################################################################
def routing_constants_heredoc_def(routing_constant,route_from,mux_index)
  #locals shorten the line nicely in Ruby
  rindx = route_from[:route_strategy_index].to_s
  mindx = mux_index.to_s
  rcnst = routing_constant
  #
  vhdl_line_routing_constant = <<-END.gsub(/^ {2}/, '   ')
  constant #{rcnst} : T_CONNECTION_TYPE:= (router_index => #{rindx} , mux_index =>  #{mindx});
  END
  #
end
##############################################################################


##############################################################################
@new_connection_constant_array = 
  @route_keys_are_destinations_vals_are_sources_array_of_hash.collect {|destination,source_array_of_hash|
    #
    head,*source_array_of_hash_no_model_description = source_array_of_hash
    #
    create_routing_constants(destination,source_array_of_hash_no_model_description)
  }
##############################################################################


################################################################################
def create_vhdl_mux_process(mux_driver_destination,mux_driver_array_of_hash_sources)
  #
  sensitivity_list_signals = 
    create_sensitivity_list_signals(mux_driver_array_of_hash_sources,"mux")
  #
  source_names = create_commented_source_names(mux_driver_array_of_hash_sources)
  #
  fn_args = create_fn_args_for_mux(mux_driver_array_of_hash_sources,mux_driver_destination)
  puts "-----fn_args----- #{fn_args}"
  #
  fn_args_no_last_comma = fn_args.gsub(/(.*)(,)(.*)/m,'\1\3') #this is how to remove the last comma
  #
  @mux_driver = <<-END.gsub(/^ {2}/, '   ')
  -------------------------------------------------------------------------------
  -- Interconnect to the #{mux_driver_destination} omb_mux
  #{mux_driver_destination}_mux_proc:
  process(#{sensitivity_list_signals})
  begin
  -- The following #{mux_driver_array_of_hash_sources.count} top level fpga modules are router_top inputs
  #{source_names}
  -- are routed to the fpga top level module #{mux_driver_destination.upcase} which is router_top output.
  --
  -- Details of the route interconnect can be understood by inspecting the argements
  -- to the function below.
  --
  #{mux_driver_destination}_mux_in_port <= router_port_to_mux_port_func(
     #{fn_args_no_last_comma}
                                                    );
  end process;
  -------------------------------------------------------------------------------
   
  END
end
################################################################################


################################################################################
def create_fn_args_for_mux(mux_driver_array_of_hash_sources,mux_driver_destination)
  fn_args =
    mux_driver_array_of_hash_sources.collect.each_with_index { |route_from, index|
      # locals
      from_loc   = route_from[:route_from_location]
      strat      = route_from[:route_strategy]
      strat_indx = route_from[:route_strategy_index]
      dest       = mux_driver_destination
      #
      create_one_signal(route_from,"mux") + 
      ","+
        create_routing_constant_name(from_loc,dest,strat,strat_indx,index) +
          ","
      #
      }.join ("\n     ")
    #
  fn_args
end
################################################################################


################################################################################
def create_commented_source_names(mux_driver_array_of_hash_sources)
  #
  commented_source_names =
    mux_driver_array_of_hash_sources.collect { |single_source_hash|
    #   
    single_source_hash[:route_from_location].gsub(/^/,"--   ").upcase
    #
    }.join ("\n  ")
  #  
  commented_source_names
end
################################################################################


################################################################################
def create_one_signal(single_destination_hash,type_arg)
  #yield a signal
  if type_arg =~ /mux/
    signal_name =
        single_destination_hash[:route_from_location] + 
          "_router" + 
            "_" + 
              single_destination_hash[:route_strategy] + 
      "_port"
  end
  #
  # for the ready generation
  if type_arg =~ /router/
    #
    signal_name =
        single_destination_hash[:route_to_location] + "_mux_in_ready"
  end
  #  
  signal_name
end
################################################################################


################################################################################
def create_sensitivity_list_signals(array_of_hash_sources_arg,type_arg)
  #yield a string of signals seperated by commas
  #
    sensitivity_list_signals =
      array_of_hash_sources_arg.collect.each_with_index {|single_hash,i|
        #
        #break the signals up so that the line does not grow long.        
        #checking odd will give two signals/per line
        if (i.odd?)
          create_one_signal(single_hash,type_arg) +"," + "\n  "
        else
          create_one_signal(single_hash,type_arg) +","
        end
        #
      }.join.gsub(/(.*)(,)(.*)/m,'\1\3') #this is how to remove the last comma
  #    
  sensitivity_list_signals
end
################################################################################


################################################################################
def get_sensitivity_list_lenght(signals_for_sensitivity_list_arg)
  #
  sensitivity_list_length = signals_for_sensitivity_list_arg.scan(/,/).count
  if sensitivity_list_length == 0
    sensitivity_list_length = 1
  else
    sensitivity_list_length = sensitivity_list_length + 1
  end
  #  
  sensitivity_list_length
end
################################################################################


################################################################################
def create_router_ready_proc(source_name,model_params,destination_array_of_hash)
  reserved = model_params[:model_location_reserved]
  #
  unless reserved
    #don't generate all this (& check for errors as it's generated) if not used
    sensitivity_list_signals = create_sensitivity_list_signals(destination_array_of_hash,"router")
    #
    sensitivity_list_length = get_sensitivity_list_lenght(sensitivity_list_signals)
    #
    ready_signals = destination_array_of_hash.collect {|destination_hash|
                       create_one_ready(source_name,destination_hash)
    }.join
  end
  #
  insert_router_ready_heredoc(source_name,
                                sensitivity_list_signals,
                                  sensitivity_list_length,
                                    ready_signals,
                                      reserved)
  
end
################################################################################


################################################################################
def insert_router_ready_heredoc(source_name,
                                  sensitivity_list_signals,
                                    sensitivity_list_length,
                                      ready_signals,
                                        reserved)
if reserved
  
  @fpga_null_proc_for_tieoff = <<-END.gsub(/^ {2}/, '   ')
  -------------------------------------------------------------------------------
  --#{source_name.upcase} INPUT ROUTER/LOCATION IS RESERVED
  --This Surecom_omb_router's outputs are not functionally used as part of router_top.
  --The router outputs may be used for instrumentation.
  --This is where a process would be if the router were used in a functional way.
  --
  --TIE OFF UN-USED READY'S USING C_ROUTER_READY_ALL_ONES SO THAT:
     -- 1 Message sent to an unused surecom_omb_router port does not lock up the router
     -- 2 Prevent 'U' in simulation
     -- 3 Prevent "undriven" warnings in synthesis
  #{source_name}_router_ready <= C_ROUTER_READY_ALL_ONES;
  -------------------------------------------------------------------------------
   
  END
else

  #
  @router_ready_heredoc = <<-END.gsub(/^ {2}/, '   ')
  -------------------------------------------------------------------------------
  #{source_name}_router_ready_driven_from_muxes_proc : 
  process(#{sensitivity_list_signals}) 
  begin
  --
  --TIE OFF UN-USED READY'S USING C_ROUTER_READY_ALL_ONES SO THAT:
     -- 1 Message sent to an unused surecom_omb_router port does not lock up the router
     -- 2 Prevent 'U' in simulation
     -- 3 Prevent "undriven" warnings in synthesis
  #{source_name}_router_ready        <= C_ROUTER_READY_ALL_ONES;
  --
  --DRIVE READYS FROM #{sensitivity_list_length} OMB MUXES TO #{source_name.upcase} SURECOM_OMB_ROUTER
  #{ready_signals.gsub(/\A {2}/, '')}
  end process;
  -------------------------------------------------------------------------------
   
  END
end
#
end
################################################################################


#################################################################################
def create_one_ready(source,destination_hash)
  #
  dest       = destination_hash[:route_to_location]
  strat      = destination_hash[:route_strategy]
  strat_indx = destination_hash[:route_strategy_index].to_s
  #
  ###########################################################################
  # Look up table stuff
  # The position of the constant in the array gives the mux index.
  lut_ref  = create_lut_ref(source, strat, strat_indx, dest)
  #
  mux_index = 
    look_up_mux_index(source,dest,strat,strat_indx,lut_ref)
  #
  routing_constant = 
    create_routing_constant_name(source,dest,strat,strat_indx,mux_index)


  @router_side_constants_for_ref_array ||= []
  @router_side_constants_for_ref_array    << routing_constant

  #
  @mux_child_proc = <<-END.gsub(/^ {2}/, '  ')
  --
  #{source}_router_ready.#{strat}(#{routing_constant}.router_index) <= 
     #{dest}_mux_in_ready(#{routing_constant}.mux_index);  
  END
end
#################################################################################


#################################################################################
def look_up_mux_index(source,dest,strat,strat_indx,lut_ref)
  #
  ###########################################################################
  # Look up table stuff
  # The position of the constant in the array gives the mux index.
  #
  if FALSE
    p "The source is #{source}"
    p "The lut reference is #{lut_ref}"
    puts "The lut is #{@route_descriptor_lut_destinations_are_keys_hash}","\n"
    #
    puts @route_descriptor_lut_destinations_are_keys_hash[dest]
  end
  #
  # note that std err output and re-direction does not work for console.exe
  #
  mux_index_looked_up = @route_descriptor_lut_destinations_are_keys_hash[dest].index(lut_ref)
  # mux_index_looked_up should be a number representing the mux index of the constant
  # mux_index_looked_up will be nil if it's not found, in which case the user data is wrong
  # because the router side has a path that the mux side does not.
  #
  unless mux_index_looked_up
    handle_lut_errors(source,dest,strat,strat_indx,lut_ref)
  #
  # When it's nil, then set it to something noticable
  # This will happen in the case where the user does not stop on errors.
    mux_index_looked_up = 9999
  end
  #
  mux_index_looked_up
end
#################################################################################


#################################################################################
def handle_lut_errors(source,dest,strat,strat_indx,lut_ref)
  #
  $stderr.puts "#"*80
  $stderr.puts "The source (router side) is #{source}","\n"
  $stderr.puts "Trying to look up", "  #{lut_ref}"
  $stderr.puts "Seems as if ", "  #{lut_ref}", "is expected but not found in the hash."
  #
  $stderr.puts "\n","-----Here is the lut hash-----" 
  #     
  @route_descriptor_lut_destinations_are_keys_hash.each {|key,value|
    $stderr.puts "The key/destination is #{key}","  #{value}","\n"
  }
  $stderr.puts "-----Here is the lut hash-----" 
  #
  $stderr.puts "#"*80
  #
  #puts "The mux_index_looked_up for #{lut_ref} is #{mux_index_looked_up}"
  #
  if EXIT_SCRIPT_WHEN_A_ROUTE_LOOKUP_NOT_FOUND
    #
    puts "#"*80
    puts "The source (router side) is #{source}","\n"
    puts "Trying to look up", "  #{lut_ref}"
    puts "Seems as if ", "  #{lut_ref}", "is expected but not found in the hash."
    #
    puts "\n","-----Here is the lut hash-----" 
    #     
    @route_descriptor_lut_destinations_are_keys_hash.each {|key,value|
      puts "The key/destination is #{key}","  #{value}","\n"
    }
    puts "-----Here is the lut hash-----" 
    #
    puts "#"*80
    #
    #EXIT RUNNING RUBY, the last thing written to std out in this case
    #should be very helpful in detecting a bad lookup.
    puts "exiting, route lookup not found!, see what was just written
          for help finding the issue or set ruby constant
          EXIT_SCRIPT_WHEN_A_ROUTE_LOOKUP_NOT_FOUND to false to stop
          the script from exiting on this error"
    exit
  end
  #
end
#################################################################################


################################################################################
@all_mux_drivers_array = 
  @route_keys_are_destinations_vals_are_sources_array_of_hash.collect {|dest_name,dest_array_of_hash| 
  #
  head, *tail = dest_array_of_hash
  #
  create_vhdl_mux_process(dest_name,tail)
  }
  #           
puts @all_mux_drivers_array
################################################################################


################################################################################
@all_router_ready_array = 
  @route_descriptor_hash_keys_are_sources_vals_are_dest_array_of_hash.collect {|source_name,destination_array_of_hash| 
  #
  # syntax is first, *rest
  model_params, *destination_array_of_hash_no_model = destination_array_of_hash
  #
  create_router_ready_proc(source_name,model_params,destination_array_of_hash_no_model)
  }
  #           
puts @all_router_ready_array
################################################################################


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
  @tmru_vhdl_header_desisgn_unit_header_heredoc = <<-END.gsub(/^ {2}/, '')
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
def create_router_design_unit_list(temparg)
  temparg_upcase = temparg.upcase
  temparg_capitalize = temparg.capitalize
  #
  @design_unit_list = <<-END.gsub(/^ {2}/, '')
  --       inst_#{temparg}_router: surecom_omb_router.vhd
  END
end
#################################################################################


#################################################################################
def create_mux_design_unit_list(temparg)
  temparg_upcase = temparg.upcase
  temparg_capitalize = temparg.capitalize
  #
  @design_unit_list = <<-END.gsub(/^ {2}/, '')
  --       inst_#{temparg}_mux: omb_mux.vhd
  END
end
#################################################################################


#################################################################################
  # Don't expect these to change over designs
  @router_types_heredoc = <<-END.gsub(/^ {2}/, '   ')
  type T_ROUTER_TOP_READY is
     record
        #{BLOCK_ID}       :std_logic_vector(15 downto 0);
        #{POWER_STEERING} :std_logic_vector(15 downto 0);
        #{NEXT_NODE}      :std_logic_vector(15 downto 0);
        #{PREVIOUS_NODE}  :std_logic_vector(15 downto 0);
  end record;
   
   
  constant C_ROUTER_READY_ALL_ONES : T_ROUTER_TOP_READY := 
     (#{BLOCK_ID}         => (others=> '1'),
      #{POWER_STEERING}   => (others=> '1'),
      #{NEXT_NODE}        => (others=> '1'), 
      #{PREVIOUS_NODE}    => (others=> '1'));
 
 
  END

  router_types_array = @router_types_heredoc.split("\n").
                        assure_elements_have_ending_newline.
                        align_regexp(/:/).
                        align_regexp(/=>/)
#################################################################################


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
# message det stuff
msg_det_mapping_array = @sources_array.collect.each_with_index {|x,i|
   create_msg_det_mapping_array(x,i)
   }.align_regexp(/= /).unshift("-- bits 3:0 - Msg_det_sel - Message Detected Select\n").push("--\n")
#################################################################################


#################################################################################
  @vhdl_libs_heredoc = <<-END.gsub(/^ {2}/, '')
  library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  --   
  library router_lib;
  use router_lib.router_top_pkg.all;

   
  END
#################################################################################


#################################################################################
  @entity_begin_heredoc = <<-END.gsub(/^ {2}/, '   ')
entity #{@router_design_name} is
  generic(
     g_reset                 :     std_logic := '1'   -- Sets asserted level of async reset (arst)
         );
  port(
     -- Local control signals
     Clk_omb                       : in  std_logic;
     Reset                         : in  std_logic;
     This_node_id                  : in  std_logic_vector(7 downto 0);
  END
#################################################################################


#################################################################################
def create_router_entity_inputs(source_name)
  source_name_upcase = source_name.upcase
  source_name_capitalize = source_name.capitalize
  #
  @fpga_signals = <<-END.gsub(/^ {2}/, '      ')
  -- #{source_name_upcase} IF IN PORT
  #{source_name_capitalize}_to_router_sof            : in  std_logic;
  #{source_name_capitalize}_to_router_eof            : in  std_logic;
  #{source_name_capitalize}_to_router_valid          : in  std_logic;
  #{source_name_capitalize}_to_router_data           : in  std_logic_vector(63 downto 0);
  #{source_name_capitalize}_to_router_ready          : out std_logic;
  END
end
#################################################################################


#################################################################################
def create_router_entity_outputs(dest)
  dest_upcase = dest.upcase
  dest_capitalize = dest.capitalize
  #
  @fpga_signals = <<-END.gsub(/^ {2}/, '      ')
  -- #{dest_upcase} IF OUT PORT
  Router_to_#{dest}_ready          : in std_logic;
  Router_to_#{dest}_sof            : out  std_logic;
  Router_to_#{dest}_eof            : out  std_logic;
  Router_to_#{dest}_valid          : out  std_logic;
  Router_to_#{dest}_data           : out  std_logic_vector(63 downto 0);
  END
end
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
  end #{@router_design_name};
  --------------------------------------------------------------------------------

  
  END
#################################################################################


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
  msg_det_proc : process(Clk_omb,Reset)
  begin
     if (Reset = g_reset) then
           Router_top_msg_detected   <= (others => '0');
     elsif ((Clk_omb'event) and (Clk_omb = '1')) then
        --
        case  Unsigned(Router_top_msg_det_select) is
  END
#################################################################################


#################################################################################
def create_msg_det_case_arms(sources,index_0_based)
  sources_upcase = sources.upcase
  ##
  @msg_det_case_arms = <<-END.gsub(/^ {2}/, '            ')
  when x"#{index_0_based.to_s(16)}" =>
     Router_top_msg_detected <= block_id_msg_detected.#{sources};
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
def create_msg_det_type_body(temparg,index)
  temparg_upcase = temparg.upcase
  ##
  @proc_arg = <<-END.gsub(/^ {2}/, '         ')
  #{temparg}        : std_logic_vector(15 downto 0);
  END
end
#################################################################################


#################################################################################
def create_router_signals(sources)
  sources_upcase = sources.upcase
  ##
  @fpga_signals = <<-END.gsub(/^ {2}/, '   ')
  -----------------------------------------------------------------------------
  -- Internal connections to #{sources} router
  -----------------------------------------------------------------------------
  -- data direction: router -> mux 
  signal #{sources}_router_#{BLOCK_ID}_port          :T_ROUTER_OUT_PORT_OUTPUTS;
  signal #{sources}_router_#{POWER_STEERING}_port    :T_ROUTER_OUT_PORT_OUTPUTS;
  signal #{sources}_router_#{NEXT_NODE}_port            :T_ROUTER_OUT_PORT_OUTPUTS;
  signal #{sources}_router_#{PREVIOUS_NODE}_port     :T_ROUTER_OUT_PORT_OUTPUTS;
  --
  -- data direction: mux -> router 
  signal #{sources}_router_ready                     :T_ROUTER_TOP_READY;
  --
  
  END
end
#################################################################################


#################################################################################
def create_mux_signals(destinations)
  destinations_upcase = destinations.upcase
  ##
  @fpga_signals = <<-END.gsub(/^ {2}/, '   ')
  -----------------------------------------------------------------------------
  -- Internal connections to #{destinations} mux
  -----------------------------------------------------------------------------
  signal #{destinations}_mux_in_port                        :T_MUX_IN_PORT;
  signal #{destinations}_mux_in_ready                       :std_logic_vector(C_#{destinations_upcase}_MUX_IN_PORTS-1 downto 0);

  END
end
#################################################################################


#################################################################################
  @connection_constants_comment_heredoc = <<-END.gsub(/^ {2}/, '   ')
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
  END
#
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
def create_mux_instances(destinations)
  ##
  #
  destinations_cap    = destinations.capitalize
  destinations_upcase = destinations.upcase
  #

  @fpga_instance = <<-END.gsub(/^ {2}/, '   ')
   -- #{destinations_cap} output port 
   inst_#{destinations}_mux: entity work.OMB_MUX
      generic map (
         IN_PORTS       => C_#{destinations_upcase}_MUX_IN_PORTS
         )               
      port map (         
         Clk            => Clk_omb,
         Rst            => Reset,
         --in port(s)    
         Sof_in_port    => #{destinations}_mux_in_port.sof,  
         Eof_in_port    => #{destinations}_mux_in_port.eof,  
         Valid_in_port  => #{destinations}_mux_in_port.valid,
         Ready_in_port  => #{destinations}_mux_in_ready,
         Data_in_port   => #{destinations}_mux_in_port.data, 
         --out port      
         Sof_out_port   => Router_to_#{destinations}_sof,
         Eof_out_port   => Router_to_#{destinations}_eof,
         Valid_out_port => Router_to_#{destinations}_valid,
         Ready_out_port => Router_to_#{destinations}_ready,
         Data_out_port  => Router_to_#{destinations}_data
         );


  END
end
#################################################################################


#################################################################################
def create_router_instances(sources,dest)
  #
  @generics = create_router_instance_generics(dest)
  #
  generics_blanks_removed_aligned = 
    @generics.split("\n").reject{ |l| l=~/^ *$/ }.align_regexp(/=/).join("\n")
  #
  if dest[:model_generic_formal] 
     formal = dest[:model_generic_formal]
     actual = dest[:model_generic_actual]
  else
     formal = "--"
     actual = "--"
  end
     
  sources_cap = sources.capitalize
  #
  ##
  @fpga_instance = <<-END.gsub(/^ {2}/, '   ')
  -- Messages from the fpga top level function #{sources} enter this module instance
  -- (surecom_omb_router) and are directed to one of its outputs
  -- #{sources}_router_block_id_port, #{sources}_router_pwr_steer_port, or
  -- #{sources}_router_previous_node_port based on the message fields RI qw
  inst_#{sources}_router: entity work.surecom_omb_router
  #{generics_blanks_removed_aligned}
     port map (
        Clk                          => Clk_omb,
        Reset                        => Reset,
        This_node_id                 => This_node_id,
        -- router in port
        Sof_in_port                  => #{sources_cap}_to_router_sof,
        Eof_in_port                  => #{sources_cap}_to_router_eof,
        Valid_in_port                => #{sources_cap}_to_router_valid,
        Ready_in_port                => #{sources_cap}_to_router_ready,
        Data_in_port                 => #{sources_cap}_to_router_data,
        --Block ID out port
        Block_sof_out_port           => #{sources}_router_#{BLOCK_ID}_port.sof,
        Block_eof_out_port           => #{sources}_router_#{BLOCK_ID}_port.eof,
        Block_valid_out_port         => #{sources}_router_#{BLOCK_ID}_port.valid,
        Block_ready_out_port         => #{sources}_router_ready.#{BLOCK_ID},
        Block_data_out_port          => #{sources}_router_#{BLOCK_ID}_port.data,
        --Pwr steer out port
        Pwr_steer_sof_out_port       => #{sources}_router_#{POWER_STEERING}_port.sof,
        Pwr_steer_eof_out_port       => #{sources}_router_#{POWER_STEERING}_port.eof,
        Pwr_steer_valid_out_port     => #{sources}_router_#{POWER_STEERING}_port.valid,
        Pwr_steer_ready_out_port     => #{sources}_router_ready.#{POWER_STEERING},
        Pwr_steer_data_out_port      => #{sources}_router_#{POWER_STEERING}_port.data,
        --Previous node out port                                               
        Previous_node_sof_out_port   => #{sources}_router_#{PREVIOUS_NODE}_port.sof,
        Previous_node_eof_out_port   => #{sources}_router_#{PREVIOUS_NODE}_port.eof,
        Previous_node_valid_out_port => #{sources}_router_#{PREVIOUS_NODE}_port.valid,
        Previous_node_ready_out_port => #{sources}_router_ready.#{PREVIOUS_NODE},
        Previous_node_data_out_port  => #{sources}_router_#{PREVIOUS_NODE}_port.data,
        --Message detected
        Block_id_msg_detected        => block_id_msg_detected.#{sources}
        );


  END
end
#################################################################################


#################################################################################
def create_router_instance_generics(dest)
  #
  if dest[:model_generic_formal] 
     formal = "#{dest[:model_generic_formal]} => "
     actual = "#{dest[:model_generic_actual]},"
  else
     #want to end up with a blank line that another def will remove
     formal = ""
     actual = ""
  end
  #
  @router_instance_generics_heredoc = <<-END.gsub(/^ {2}/, '   ')
  generic map (
       #{formal} #{actual}
       G_SURECOM_OMB_ROUTER_NN_PN_OUT_PORTS      => C_SURECOM_OMB_ROUTER_NN_PN_PORTS,
       G_SURECOM_OMB_ROUTER_BLK_ID_OUT_PORTS     => C_SURECOM_OMB_ROUTER_BLK_ID_PORTS,
       G_SURECOM_OMB_ROUTER_PWR_STEER_OUT_PORTS  => C_SURECOM_OMB_ROUTER_PWR_STEER_PORTS
       )
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
def missing_source_check(source_lenght,des_lenght)
  # des_lenght    = @mux_side_constants_for_ref_array.length
  # source_lenght = @router_side_constants_for_ref_array.length
  #   
  if CHECK_FOR_MISSING_SOURCE_AND_REPORT && (des_lenght != source_lenght)
    puts "-"*80
    puts "MISSING SOURCE CHECK"
    #
    if CHECK_FOR_MISSING_SOURCE_AND_REPORT_VERBOSE
      puts @router_side_constants_for_ref_array.sort
    end
    puts "  -- @router_side_constants_for_ref_array length: #{source_lenght}--",""
    # 
    if CHECK_FOR_MISSING_SOURCE_AND_REPORT_VERBOSE   
      puts @mux_side_constants_for_ref_array.sort
    end
    puts "  -- @mux_side_constants_for_ref_array   length  #{des_lenght}--",""
    #
    puts "  -- @dest_array minus sources array --"
    puts "    #{@mux_side_constants_for_ref_array - @router_side_constants_for_ref_array}"
    puts " IS LIKELY TO BE MISSING SOURCE"
    puts "-"*80,""
  end
end
#################################################################################


#################################################################################
# router instance names for comment header
# Objects are chunked together because there are groups of several that are
# named similarly.
router_design_unit_list_chunks_array = @sources_array.collect {|x|
   create_router_design_unit_list(x)
   }
#
mux_design_unit_list_chunks_array = @destinations_array.collect {|x|
   create_mux_design_unit_list(x)
   }
#
inputs_array  = (@input_modules_heredoc.split(/\n$/) + router_design_unit_list_chunks_array).
                assure_elements_have_ending_newline
#                
outputs_array = (@ouput_modules_heredoc.split(/\n/) + mux_design_unit_list_chunks_array).
                assure_elements_have_ending_newline
                
design_unit_list_array = 
                       (inputs_array + outputs_array).
                       join.
                       split("\n").
                       align_regexp(/:/)
#################################################################################


#################################################################################
# entity inputs_array
# Objects are chunked together because there are groups of several that are
# named similarly.
router_entity_inputs_chunks_array = @sources_array.collect {|source_name|
   create_router_entity_inputs(source_name)
   }
#
#Seperate them so that they may be alligned
router_entity_inputs_array = 
  router_entity_inputs_chunks_array.join.split("\n").align_regexp(/:/)
#################################################################################


#################################################################################
# entity ouputs
# Objects are chunked together because there are groups of several that are
# named similarly.
router_entity_outputs_chunks_array = @destinations_array.collect {|dest|
   create_router_entity_outputs(dest)
   }
#
#Seperate them so that they may be alligned
router_entity_outputs_array = 
  router_entity_outputs_chunks_array.join.split("\n").align_regexp(/:/)
#################################################################################


#################################################################################
vhdl_arch =   ["\n","\n","architecture rtl of #{@router_design_name} is","\n", "\n"]
#################################################################################


#################################################################################
vhdl_begin =   ["\n","\n","begin","\n", "\n"]
#################################################################################


#################################################################################
vhdl_end_of_file =   ["end rtl;"]
#################################################################################


#################################################################################
## constants
msg_det_case_arms_array = @sources_array.collect.each_with_index {|sources,i|
   create_msg_det_case_arms(sources,i)
   }
#################################################################################


#################################################################################
## mux constants
mux_constant_array = @destinations_array.collect {|x|
   create_mux_constants(x)
   }.unshift(@mux_ports_constats_header) + ["\n"]
#################################################################################


#################################################################################
# signals as mux actuals
# signals are chunked together because there are groups of several that are
# named similarly.
omb_mux_signal_array_chunked = @destinations_array.collect {|destinations|
   create_mux_signals(destinations)
   # } + ["-----------------------------------------------------------------------------"]
   }
#
#Seperate them so that they may be alligned
omb_mux_signal_array = omb_mux_signal_array_chunked.join.split("\n").align_regexp(/:/)
#################################################################################


#################################################################################
# signals as router actuals
# signals are chunked together because there are groups of several that are
# named similarly.
router_signal_array_chunks = @sources_array.collect {|sources|
   create_router_signals(sources)
   }
#
#Seperate them so that they may be alligned
router_signal_array = router_signal_array_chunks.join.split("\n").align_regexp(/:/)
#################################################################################


#################################################################################
# type for message det
msg_det_type_array = @sources_array.
  collect.each_with_index {|x,i|
   create_msg_det_type_body(x,i)
   }.
     unshift("   type T_MSG_DETECTED is\n      record\n").
     push("   end record;\n\n").
     assure_elements_have_ending_newline.
     align_regexp(/:/).push("\n\n")
#################################################################################


#################################################################################
# ready signals driven to router process
surecom_router_ready_array = @sources_array.collect {|x|
   create_ready_driver_processs(x)
   }
#################################################################################


#################################################################################
surecom_omb_router_instance_array = 
  @route_descriptor_hash_keys_are_sources_vals_are_dest_array_of_hash.collect {|sources,dest_array_of_hash|
   create_router_instances(sources,dest_array_of_hash[0])
   }
#################################################################################


#################################################################################
omb_mux_instance_array = @destinations_array.collect {|destinations|
   create_mux_instances(destinations)
   }
#################################################################################


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


if TRUE
  puts @all_mux_drivers_array
end


#################################################################################
msg_det_section = @msg_det_mux_header_heredoc.split("\n") + 
                    msg_det_case_arms_array + 
                      @msg_det_mux_trailer_heredoc.split("\n")
#################################################################################


#################################################################################
# entity
tot_entity_array =
  @entity_begin_heredoc.split("\n") + 
    router_entity_inputs_array +
      router_entity_outputs_array +
        @entity_msg_det_heredoc.gsub!(/(.*)(;)(.*)/m,'\1\3').split("\n") +
          @entity_end_heredoc.split("\n")


tot_entity_array_realigned_together = 
  tot_entity_array.align_regexp(/:/).align_regexp(/std/)
#################################################################################


#################################################################################
#
@hdl_file = 
           @tmru_vhdl_header_start_heredoc.split("\n") +
           msg_det_mapping_array +
           @tmru_vhdl_header_desisgn_unit_header_heredoc.split("\n")  +
           design_unit_list_array +
           @tmru_vhdl_header_end_heredoc.split("\n") +
           @vhdl_libs_heredoc.split("\n").assure_elements_have_ending_newline +
           tot_entity_array_realigned_together +
           vhdl_arch + 
           router_types_array +
           msg_det_type_array +
           @connection_constants_comment_heredoc.split("\n") +
           @new_connection_constant_array.join.split("\n").align_regexp(/:/) +
           router_constant_arrary +
           mux_constant_array.align_regexp(/:/) +
           router_signal_array +
           omb_mux_signal_array +
           @message_detected_signals_heredoc.split("\n")  +
           vhdl_begin +
           @all_mux_drivers_array +
           @all_router_ready_array +
           surecom_omb_router_instance_array +
           omb_mux_instance_array +
           msg_det_section+
           vhdl_end_of_file
#################################################################################


################################################################################
#write to files
File.open(@output_file, "w+") do |f|
  @hdl_file .each { |element| f.puts(element) }
end
################################################################################


missing_source_check(@router_side_constants_for_ref_array.length,
                     @mux_side_constants_for_ref_array.length)


#################################################################################
puts "Implemented:"
puts "  #{@router_side_constants_for_ref_array.length} connections"
puts "  #{@destinations_array.length} OMB muxes"
puts "  #{@sources_array.length} OMB routers"
puts "--Reached the end of create_router.rb--"
#################################################################################
