#!/usr/bin/env ruby
################################################################################
#Develop something that writes out valid HDL code based on parameters
#Todo
#Make a complete HDL file that will compile.
################################################################################


################################################################################
require_relative "./hdl_text_templates.rb"
require_relative "./hdl_defs.rb"
################################################################################


################################################################################
#params
VERBOSE_DEBUG = TRUE
#
WRITE_TO_FILES = :not_now
################################################################################


################################################################################
#
@function_names_array = ["foo", "bar", "baz"]
################################################################################


multi_input_port_group = create_multiple_port_groups(@in_port_group,3)
#
@inc_val = 1
multiple_input_groups_w_inc = multi_input_port_group.collect do |port_group| 
  increment_num_at_end_of_port_name(port_group) 
end
#
multi_output_port_group = create_multiple_port_groups(@out_port_group,3)
#
@inc_val = 1
multiple_output_groups_with_inc = multi_output_port_group.collect do |port_group| 
  increment_num_at_end_of_port_name(port_group) 
end


# puts result = increment_num_at_end_of_port_name(@in_port_group)
puts multiple_input_groups_w_inc
puts multiple_output_groups_with_inc


# tempvar = "function0 : in slv;\nfunction0 in slv;\n".gsub(/function0/) do |match|
tempvar = multiple_input_groups_w_inc[0].gsub(/function0/) do |match|
  @function_names_array[0]
end                     


othertemp = multiple_input_groups_w_inc.each_with_index.collect do |group,i|
  multiple_input_groups_w_inc[i].gsub(/function0/,@function_names_array[i])
end


puts tempvar
puts othertemp
puts multiple_input_groups_w_inc.length


this_entity = write_entity(@in_port_group,3)


puts "done"


################################################################################
#read in files
#
merge_result_file       = "merge_result_quadwords_das_pattern.txt"
merge_result_words_file = "merge_result_words_das_pattern.txt"
################################################################################
   

################################################################################
#write to files
unless WRITE_TO_FILES == :not_now
  puts "Writing to files"
  #
  File.open(merge_result_file, "w+") do |f| 
    @merge_result_array_qw .each { |element| f.puts(element) } 
  end
  #
  merge_result_array_words = conv_qw_array_to_word_array(@merge_result_array_qw)
  File.open(merge_result_words_file, "w+") do |f|
    merge_result_array_words.each { |element| f.puts(element) }
  end
end
################################################################################ 
