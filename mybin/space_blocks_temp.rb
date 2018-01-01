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

################################################################################
#settings
################################################################################
ARRAYS_VERBOSE          = FALSE
DESIRED_SPACING_VERBOSE = FALSE
DEFAULT_DESIRED_SPACING = 1

################################################################################
#Options
################################################################################
# hash for optparse
options = {}
#
optparse = OptionParser.new do|opts|
  opts.banner = "\nChange the number of newlines between blocks\nUsage is:\n space_blocks.rb <opts> filenames"
  #
  # Defaults
  options[:num_lines] = 1
  options[:write_back_in_place] = false
  #
  # first arg to opts.on, 
  #   Is the short form. 
  #
  # second arg opts.on
  #  Is the long form parameter 
  #  NUM is optionol bc its in []
  #    Automatically convert args pass Integer to the on method after switch description.
  #
  # Third arg opts.on, 
  #   Integer tells ruby to convert the parameter to an Integer 
  #
  # Fourth arg is a doc string
    opts.on( '-n', '--number [NUM]', Integer, "Optional, Number of lines to space" ) do|n|
      options[:num_lines] = n
    end
    #

  #about.com calls this a Simple Switch
  #   A simple switch is an argument with no optional forms or no parameters. 
  #   The effect will be to simply set a flag in the options hash. 
  #   No other parameters will be passed to the on method.
  #   In this case, the default is true, running -w sets it to true
    options[:write_back_in_place] = false
    opts.on( '-w', '--write_back', "Write file back to original" ) do
      options[:write_back_in_place] = true
    end

    #
    # This displays the help screen, all programs are
    # assumed to have this option.
    opts.on( '-h', '--help', 'Display this screen' ) do
      puts opts
      exit
    end
  end
#
#
# Parse the command-line. Remember there are two forms
# of the parse method. The 'parse' method simply parses
# ARGV, while the 'parse!' method parses ARGV and removes
# any options found there, as well as any parameters for
# the options. 
# What's left is the list of files.
files_list_from_command_line = optparse.parse!

################################################################################
# read in the file name
################################################################################
if ! files_list_from_command_line.empty?
  #
  # Right new just get one file, later loop over them all.
  if File.file?(files_list_from_command_line[0])
    full_file_path_and_name  = files_list_from_command_line[0]
  else
    puts "CMD line arg provided is not a file, check the file name"
    abort
  end
else
  puts "\n","----- ARGV[0] empty using a default dummy filename -----","\n"
  path_to_file = './'
  full_file_path_and_name  = path_to_file + 'test.txt'
end

################################################################################
# Create temp out file name, so that the original file is not over-written
# except when the user wants it.
################################################################################
# this could be nicer than just putting .temp at the end of the filename
# out_file_name  = full_file_path_and_name.gsub(/(test)/,"\\1" + "s")
#

def create_new_temp_file_name(orig_file_name_arg)
# This transforms my.txt into my_temp.txt
# a = 'my.txt'
# a.split('.').first+"_temp" + '.' + a.split('.').last
# -> "temp.txt"
#
# Check if it has a dot, if so put in _temp after the dot
  if orig_file_name_arg.match('\.') then
    new_temp_file_name = 
      orig_file_name_arg.split('.').first+"_temp" + '.' + orig_file_name_arg.split('.').last
  # No dot, then just append _temp 
  else
    new_temp_file_name = orig_file_name_arg + "_temp"
  end 
#
end

# out_file_name  = full_file_path_and_name + ".temp"
out_file_name  = create_new_temp_file_name(full_file_path_and_name)

puts "  Output file name: #{out_file_name}","\n"  

# File.readlines 'converts to windows' and so changes \r\n to \n as lines
  # use [[:blank:]] rathre than \s bc \s matches newline                                                                                          
  # Want the affect of removing leading spaces but not the newline
  file_contents_as_an_array  = File.
    readlines(full_file_path_and_name).collect  { |x| x.gsub(/^[[:blank:]]+$/,'')}

file_contents_as_a_string = file_contents_as_an_array.join

#test
shell_outputs_string_with_CRLF_if_win = %x(file test.txt|grep CRLF)

#detect the file type linux or windows
if shell_outputs_string_with_CRLF_if_win.match("CRLF")
  puts "  Input file has Windows line endings"
else
  puts "  Input file has Linux line endings"
end

#
if nil
  puts "shell_outputs_string_with_CRLF_if_win is #{shell_outputs_string_with_CRLF_if_win}"
end

################################################################################
# set desired spacing, try to read as an arguement, otherwise set the default
################################################################################
puts ""
if  ARGV[1].nil? || ARGV[1].empty?
  desired_spacing = DEFAULT_DESIRED_SPACING
  if DESIRED_SPACING_VERBOSE
    puts "  ARGV[1] NIL OR EMPTY"
    puts "  desired_spacing is #{desired_spacing} "
  end
else
  desired_spacing =  ARGV[1]
  if DESIRED_SPACING_VERBOSE
    puts "  ARGV[1] --NOT--NIL OR EMPTY"
    puts "  desired_spacing is #{desired_spacing} "
  end
end 
#
if desired_spacing.to_i == 2 
  #puts "  got here 2"
  win_newline_body_of_file = "\n\n\n"
  win_newline_beg_of_file  = "\n\n"
  win_newline_end_of_file  = "\n\n\n"
else
  #puts "  got here not 2"
  win_newline_body_of_file = "\n\n"
  win_newline_beg_of_file  = "\n"
  win_newline_end_of_file  = "\n\n"
end

################################################################################
# Process the file
################################################################################
if true
file_contents_as_a_string_subbed = 
  file_contents_as_a_string.
  gsub(/(.)([\n]){2,}/, "\\1#{win_newline_body_of_file}")
 #backreferences double backslashed inside double quotes
end
#
if true
#  beginning of the string/file, \A matches the beginning of string
file_contents_as_a_string_subbed.
  gsub!(/\A([\n]){1,}/, "#{win_newline_beg_of_file}")
 #backreferences double backslashed inside double quotes
end
#
if true
#end of the string/file, \Z matches the end of string
file_contents_as_a_string_subbed.
  gsub!(/([\n]){1,}\Z/, "#{win_newline_end_of_file}")
 #backreferences double backslashed inside double quotes
end
#
file_contents_as_a_array_subbed  = file_contents_as_a_string_subbed.
  split("\n\n")

################################################################################
# Write output
################################################################################
File.open(out_file_name, 'w') { |file| file.
  write(file_contents_as_a_string_subbed) }

################################################################################
# Maybe print
################################################################################
if ARRAYS_VERBOSE
  puts "Orig As a array"
  p file_contents_as_an_array

end  
#
if ARRAYS_VERBOSE
  puts "Orig As a string"
  p file_contents_as_a_string
end
#
if ARRAYS_VERBOSE
  puts "foo", "\n"
  puts "\n", "Subbed As a string"
  p file_contents_as_a_string_subbed
  puts "\n","End of prog"
end

if ARGV
 p ARGV
end

if TRUE
  p "Here is the option hash, recall the hash keys are symbols",options
end

p "File?",files_list_from_command_line

