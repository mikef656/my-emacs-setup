#################################################################################
require_relative "./router_data.rb"
#################################################################################


# Tripple fixme, (time to give up) even though the user makes the mistake of listing the
# hash key 2 or more times, Ruby only knows about it 1x, so iterating
# over it does not give more than one key, even though it was specified
# in the hash literal mistakenly.  Time to give up on this check.
#
# double fixme, bc the keys method only returns unique keys
# can think of ways to do this but they all sound messy
# keep thinking.
# Inerate the hash, take each key and check that it's in the arrar
# If it's in the array remove it
# If not in the array then there are duplicates in the hash
#
# fixme, add an option to exit and puts the error if an error is detected
@enable_dups_keys_printing = FALSE
@temp_sources_array = @sources_array
@sources_array.each {|source,destinations|
    if @temp_sources_array.include?(source)
      @temp_sources_array = @temp_sources_array -= [source] 
      if @enable_dups_keys_printing
        puts "OK #{source}"
      end
    else
      if @enable_dups_keys_printing
        puts "#{source} is a dup"
      end
    end
    }
unless @sources_array.uniq == @sources_array
  if @enable_dups_keys_printing
    $stderr.puts " SOURCES as defined in the main hash are not unique"
  end
end
#
unless @destinations_array.uniq == @destinations_array
  if @enable_dups_keys_printing
    $stderr.puts " DESTINATIONS as defined in the main hash are not unique"
  end
end
#################################################################################


#################################################################################
def create_routing_constant_name(from,to,strat,strat_index,mux_index)
  if nil
    puts "got inside method create method"
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
             strat + "_" + 
               strat_index.to_s 
  end
  if nil
    puts "the temp_constant is #{temp_constant}"
  end
  #
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


################################################################################
if TRUE
  p @sources_array.is_a?(Array)
  p @sources_are_keys_hash
  #@sources_are_keys_hash["cpumsg"] =@sources_are_keys_hash["cpumsg"] +1
  p @sources_are_keys_hash
  #
  p @sources_array
  p @route_descriptor_lut_destinations_are_keys_hash
  p @route_descriptor_lut_destinations_are_keys_hash[SCH1].index("gbusmsg_sch1_prev_node_0")
end
#
if TRUE
  puts "here is the routing constant array "
  puts @new_connection_constant_array
end
#
##############################################################################


################################################################################

