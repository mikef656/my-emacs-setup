#!/usr/bin/env ruby
#################################################################################
#Develop something that writes out valid HDL code based on parameters
#################################################################################


#################################################################################
#params
VERBOSE_DEBUG = TRUE
#
#WRITE_TO_FILES = :not_now

# CSV_INPUT_FILE = './hdl_router_input.csv'
CSV_INPUT_FILE = 'M:/VHDL/fpga_designs/mfitzgerald/my_working_copies/surecom/fpgas/ptst_fpga/ptss_fpga/docs/hdl_router_input.csv'
HDL_OUTPUT_FILE = './hdl_router_rb.vhd'

@default_ipt_fn_names_array = ["foo", "bar", "baz","bust"]
@default_opt_fn_names_array = ["bing", "bang"]
   
#################################################################################


#################################################################################
require_relative "./hdl_text_templates.rb"
require_relative "./hdl_defs.rb"
require 'csv'
require 'english'
#################################################################################


#################################################################################
#read in the csv and assign input arrays if the specified .csv file exists 
# (holds input and output functions).
ipt_fn_names_array,opt_fn_names_array, hdl_router_input = 
  process_csv(CSV_INPUT_FILE)
#################################################################################


#################################################################################
#Create the multi groups
multi_ipt_port_group = 
  create_append_multi_port_groups(@in_port_group,ipt_fn_names_array.size)
multi_opt_port_group = 
  create_append_multi_port_groups(@out_port_group,opt_fn_names_array.size)
#################################################################################


#################################################################################
named_multi_input_groups = 
  create_named_multi_ipt_port_groups(multi_ipt_port_group,ipt_fn_names_array)
named_multi_output_groups = 
  create_named_multi_ipt_port_groups(multi_opt_port_group,opt_fn_names_array)
#################################################################################


#################################################################################
tot_port_groups = named_multi_input_groups + named_multi_output_groups
#
total_entity = 
  apnd_pstpnd(tot_port_groups,@entity_header_text,@entity_trailer_text,:sub4semi)
#################################################################################


#################################################################################
puts "transpose = #{hdl_router_input.transpose.inspect}"
hdl_output_functions_assignments = hdl_router_input.transpose.drop(1).inspect
puts "output assignments = #{hdl_output_functions_assignments}"
#################################################################################


#################################################################################
puts total_entity
#
puts "\n--done--"
#################################################################################


#################################################################################
#write to file
write_hdl_file(HDL_OUTPUT_FILE,total_entity)
#################################################################################


#################################################################################
