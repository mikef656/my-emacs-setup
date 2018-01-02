#!/usr/bin/env ruby
# -*- coding: iso-8859-1 -*-

#################################################################################
require_relative "./router_data.rb"
require_relative "./router_common.rb"
#################################################################################


#################################################################################
def create_template_input_signals_record_type(temparg)
  temparg_upcase = temparg.upcase
  ##
  @tb_dut_inst = <<-END.gsub(/^ {2}/, '   ')
  signal #{temparg}_to_router  : T_OMB_PORT;
  END
end
#################################################################################


#################################################################################
def create_template_port_map_router_outputs(temparg)
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
def create_template_output_signals_record_type(temparg)
  temparg_upcase = temparg.upcase
  ##
  @tb_dut_inst = <<-END.gsub(/^ {2}/, '   ')
  signal router_to_#{temparg}  : T_OMB_PORT;
  END
end
#################################################################################


#################################################################################
  @dut_template_msg_det_ports_heredoc = <<-END.gsub(/^ {2}/, '  ')
         -- msg detected if
         Router_top_msg_det_select     => router_top_msg_det_select,
         Router_top_msg_detected       => router_top_msg_detected,
  END
#################################################################################


#################################################################################
  @dut_template_instance_header = <<-END.gsub(/^ {2}/, '  ')
   inst_#{@router_design_name}: entity router_lib.#{@router_design_name}
      port map (         
         Clk_omb                => clk_omb,
         Reset                  => reset,
         This_node_id           => C_#{@fpga_design_name.upcase}_NODE_ID,
  END
#################################################################################


#################################################################################
def create_template_instance_port_map_router_inputs(temparg)
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
  @signals_msg_det_signals_heredoc = <<-END.gsub(/^ {2}/, '   ')
  -- msg detected if
  signal router_top_msg_det_select  :  std_logic_vector(3 downto 0);
  signal router_top_msg_detected    :  std_logic_vector(15 downto 0);
  END
#################################################################################


#################################################################################
# instance input signals
template_input_signals_array = @sources_array.collect.each_with_index {|x|
   # create_instance_input_signals(x)
   create_template_input_signals_record_type(x)
   }.join.split("\n").align_regexp(":")
#################################################################################


#################################################################################
# instance output signals
template_output_signals_array = @destinations_array.collect.each_with_index {|x|
   # create_instance_output_signals(x)
   create_template_output_signals_record_type(x)
   }.join.split("\n").align_regexp(":")
#################################################################################


#################################################################################
# instance input ports
template_port_map_input_array = @sources_array.collect.each_with_index {|x|
   create_template_instance_port_map_router_inputs(x)
   }.join.split("\n").align_regexp(":")
#################################################################################


#################################################################################
# instance output ports
template_port_map_output_array = @destinations_array.collect.each_with_index {|x|
   create_template_port_map_router_outputs(x)
   }.join.split("\n").align_regexp(":")
#################################################################################


################################################################################
# entity
  dut_template_tot_entity = 
    @dut_template_instance_header.split("\n") +
      template_port_map_input_array.align_regexp(/=/)  +
        template_port_map_output_array.align_regexp(/=/) +
          @dut_template_msg_det_ports_heredoc.split("\n")
################################################################################  


################################################################################  
  @dut_template = 
    template_input_signals_array.align_regexp(/:/).unshift("   -- Router inputs")  +
      template_output_signals_array.align_regexp(/:/).unshift("   -- Router outputs")  +
        @signals_msg_det_signals_heredoc.split("\n").push("\n"*2) +
        dut_template_tot_entity.align_regexp(/=>/).push("         );").join("\n").gsub!(/(.*)(,)(.*)/m,'\1\3').split("\n")
################################################################################


################################################################################
#write to dut instance file
File.open(@dut_instance_file, "w+") do |f|
  @dut_template.each { |element| f.puts(element) }
end
################################################################################


#################################################################################
puts "--Reached the end of create_template.rb--"
#################################################################################
