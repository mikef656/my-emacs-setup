################################################################################
#usage (takes 2 command line args)
# space_blocks.rb <filename_to_process> <n>
#  Where n is the number of spaces bt blocks (currently 1 or 2 work)
# This file will remove leading whitespace.
# This file will respect linux/windows encoding.
################################################################################


################################################################################
#settings
################################################################################
ARRAYS_VERBOSE          = FALSE
DESIRED_SPACING_VERBOSE = FALSE
DEFAULT_DESIRED_SPACING = 1


################################################################################
# read in the file name
################################################################################
if ! ARGV.empty?
  #puts "ARGV[0] not empty"
  if File.file?(ARGV[0])
    full_file_path_and_name  = ARGV[0]
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
# Create out file name
################################################################################
# this could be nicer than just putting .temp at the end of the filename
# out_file_name  = full_file_path_and_name.gsub(/(test)/,"\\1" + "s")
#
out_file_name  = full_file_path_and_name + ".temp"
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
  gsub!(/([dn]){1,}\Z/, "#{win_newline_end_of_file}")
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
ene



