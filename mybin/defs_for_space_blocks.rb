################################################################################
# requires
################################################################################
require 'optparse'
require 'pp'


def handle_options_proc( )
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
  files_list_from_command_line_list = optparse.parse!


  return files_list_from_command_line_list, options 
end


def check_file_list_empty(files_list_from_command_line_list_arg)
  ################################################################################
  # Check if file list from command line empty
  ################################################################################
  if files_list_from_command_line_list_arg.empty?
    puts "\n","----- ARGV[0] empty using a default dummy filename -----","\n"
    full_file_path_and_name  = @path_to_dummy_file + 'test.txt'
  else
    full_file_path_and_name = files_list_from_command_line_list_arg[0]
  end
end


def create_new_temp_file_name_proc(orig_file_name_arg)
# This transforms my.txt into my_temp.txt
# a = 'my.txt'
# a.split('.').first+"_temp" + '.' + a.split('.').last
# -> "temp.txt"
#
# Check if it has a dot, if so put in _temp after the dot
  if orig_file_name_arg.match('\.') then
    # Remove possible leading . as is ./file.txt
    first_part = orig_file_name_arg.sub(/^\.\//,"").split('.').first + "_temp"
    #
    second_part = orig_file_name_arg.split('.').last
    total_string = first_part + '.' + second_part
    #
    if false
      puts "orig #{orig_file_name_arg.sub(/^\.\//,"")}"
      puts "first part #{first_part}"
      puts "Second part #{second_part}"
      puts "Third part #{third_part}"
    end
    #
    new_temp_file_name = total_string
    #  
  # No dot, then just append _temp 
  else
    new_temp_file_name = orig_file_name_arg + "_temp"
  end 
#
end


#


def my_make_substitutions(file_contents_as_a_string_arg)
  #
  ################################################################################
  # Process the file
  ################################################################################
  if true
  file_contents_as_a_string_subbed = 
    file_contents_as_a_string_arg.
    gsub(/(.)([\n]){2,}/, "\\1#{@win_newline_body_of_file}")
   #backreferences double backslashed inside double quotes
  end
  #
  if true
  #  beginning of the string/file, \A matches the beginning of string
  file_contents_as_a_string_subbed.
    gsub!(/\A([\n]){1,}/, "#{@win_newline_beg_of_file}")
   #backreferences double backslashed inside double quotes
  end
  #
  if true
  #end of the string/file, \Z matches the end of string
  file_contents_as_a_string_subbed.
    gsub!(/([\n]){1,}\Z/, "#{@win_newline_end_of_file}")
   #backreferences double backslashed inside double quotes
  end
  #
  #
  file_contents_as_a_string_subbed
  #
end


def write_output_file(out_file_name_arg,file_contents_as_a_string_subbed_arg)
  # Write output
  File.open(out_file_name_arg, 'w') { |file| file.
    write(file_contents_as_a_string_subbed_arg) }
  #
end


def print_windows_or_linux_def(file_arg)
  #test
  shell_outputs_string_with_CRLF_if_win = %x(file file_arg|grep CRLF)
   
  #detect the file type linux or windows
  if shell_outputs_string_with_CRLF_if_win.match("CRLF")
    puts "  Input file has Windows line endings"
  else
    puts "  Input file has Linux line endings"
  end
  #
end


def establish_out_file_maybe_overwrite_def(full_file_path_and_name_arg, options_arg)
  #
  # Check that the file exists
  #
  if ! File.file?(full_file_path_and_name_arg)
    puts "CMD line arg provided is not a file, check the file name"
    abort
  end
  # 
  # 
  if options_arg[:write_back_in_place]
    out_file_name = full_file_path_and_name_arg
    puts "Writing back #{out_file_name} in-place" 
  else
    puts "full path and file name is #{full_file_path_and_name_arg}"
    out_file_name  = create_new_temp_file_name_proc(full_file_path_and_name_arg)
  end
  # 
  puts "  Current output file name: #{out_file_name}","\n"
  #
  out_file_name
  #
end
