#################################################################################
require_relative "./router_data.rb"
require_relative "./router_common.rb"
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
   dut: entity work.#{@router_design_name}
      port map (         
         Clk_omb                => clk_150M,
         Reset                  => arst,
  END
#################################################################################


#################################################################################
  @tb_signals_msg_det_heredoc = <<-END.gsub(/^ {2}/, '   ')
  -- msg detected if
  signal router_top_msg_det_select_tb  :  std_logic_vector(3 downto 0);
  signal router_top_msg_detected_tb    :  std_logic_vector(15 downto 0);
  END
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
  signal #{temparg}_to_router_tb  : T_OMB_PORT;-- := C_ROUTER_PORT_INIT;
  END
end
#################################################################################


#################################################################################
def create_tb_output_signals_inst(temparg)
  temparg_upcase = temparg.upcase
  ##
  @tb_dut_inst = <<-END.gsub(/^ {2}/, '   ')
  signal Router_to_#{temparg}_router_tb  : T_OMB_PORT;
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
# testbench constants as procedure args
testbench_procedure_constants_array = @sources_array.
  collect.each_with_index {|x,i|
   create_tb_procedure_arg_constants(x,i)
   }.align_regexp(/:/).unshift("  -- procedure constants\n").push("\n")
#################################################################################


#################################################################################
# testbench input record signals
testbench_input_signals_array = @sources_array.collect {|x|
   create_tb_input_signals_inst(x)
   }.join.split("\n").align_regexp(/:/).unshift("  -- DUT input signals\n").push("\n")
#################################################################################


#################################################################################
# testbench output record signals
testbench_output_signals_array = @destinations_array.collect {|x|
   create_tb_output_signals_inst(x)
   }.join.split("\n").align_regexp(/:/).unshift("  -- DUT output signals\n")
#################################################################################


#################################################################################
# testbench DUT instance inputs_array\w record signals
testbench_port_map_input_array = @sources_array.collect {|x|
   create_tb_port_map_router_inputs_inst(x)
   }.join.split("\n").align_regexp(/=/)
#################################################################################


#################################################################################
# testbench instance\w record signals
testbench_port_map_output_array = @destinations_array.collect {|x|
   create_tb_port_map_router_outputs_inst(x)
   }.join.split("\n").align_regexp(/=/).push("\n")
#################################################################################


#################################################################################
# testbench dut input mux
testbench_dut_input_mux_array = @sources_array.collect.each_with_index {|x,i|
   create_tb_input_mux_inst(x,i)
   }.join.split("\n").align_regexp("<")
#################################################################################


################################################################################
testbench_total_port_map = @dut_tb_instance_header.split("\n") +
                             testbench_port_map_input_array.align_regexp(/=>/) + 
                               testbench_port_map_output_array.align_regexp(/=>/) + 
                                 @tb_dut_instance_msg_det_ports_heredoc.split("\n").push("         );")

@testbench_stuff = testbench_procedure_constants_array + 
                    testbench_input_signals_array + 
                      testbench_output_signals_array.push("\n") + 
                        @tb_signals_msg_det_heredoc.split("\n").push("\n") +
                          testbench_total_port_map.align_regexp(/=>/).join("\n").gsub!(/(.*)(,)(.*)/m,'\1\3').split("\n").push("\n") +
                            testbench_dut_input_mux_array
################################################################################


################################################################################
#write to testbench files
File.open(@tb_output_file, "w+") do |f|
  @testbench_stuff.each { |element| f.puts(element) }
end
################################################################################

################################################################################
if FALSE 
  puts @testbench_stuff
end
#################################################################################


#################################################################################
puts "--Reached end of create_testbench.rb--"
#################################################################################
