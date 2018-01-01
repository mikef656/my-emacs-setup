################################################################################
#usage (takes 2 command line args)
# space_blocks.rb <filename_to_process> <n>
#  Where n is the number of spaces bt blocks (currently 1 or 2 work)
# This file will remove leading whitespace.
# This file will respect linux/windows encoding.
################################################################################

################################################################################
# requires
################################################################################
require 'optparse'
require 'pp'

require_relative "./defs_for_space_blocks.rb"
@path_to_dummy_file = './'

################################################################################
#settings
################################################################################
ARRAYS_VERBOSE          = FALSE
DESIRED_SPACING_VERBOSE = FALSE

################################################################################
# Handle Options
################################################################################
files_list_from_command_line_list, options = handle_options_proc


full_file_path_and_name = check_file_list_empty(files_list_from_command_line_list)

# Right new just get one file, later loop over them all.

out_file_name = establish_out_file_maybe_overwrite_def(full_file_path_and_name, options)

# File.readlines 'converts to windows' and so changes \r\n to \n as lines
  # use [[:blank:]] rathre than \s bc \s matches newline                                                                                          
  # Want the affect of removing leading spaces but not the newline
  file_contents_as_an_array  = File.
    readlines(full_file_path_and_name).collect  { |x| x.gsub(/^[[:blank:]]+$/,'')}

file_contents_as_a_string = file_contents_as_an_array.join


print_windows_or_linux_def("test.txt")


@win_newline_body_of_file = "\n"*(options[:num_lines] +1)
@win_newline_end_of_file  = "\n"*(options[:num_lines])
@win_newline_end_of_file  = "\n"*(options[:num_lines] +1)

file_contents_as_a_string_subbed = my_make_substitutions(file_contents_as_a_string)

write_output_file(out_file_name,file_contents_as_a_string_subbed)

################################################################################
# Maybe print
################################################################################
if ARRAYS_VERBOSE
  puts "Orig As a array"
  p file_contents_as_an_array
  #
  puts "foo", "\n"
  puts "\n", "Subbed As a string"
  p file_contents_as_a_string_subbed
  puts "\n","End of prog"
  #
end

if TRUE
  p "Here is the option hash, recall the hash keys are symbols: #{options}"
end

p "File?",files_list_from_command_line_list

puts "Reached the end of space_blocks.rb"

