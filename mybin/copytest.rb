################################################################################
# http://www.tutorialspoint.com/ruby/ruby_arrays.htm
#http://www.sitepoint.com/guide-ruby-collections-part-arrays/
# Ruby examples c:/Users/mfitzgerald/AppData/Roaming/mybin/create_router.rb
################################################################################


################################################################################
require 'csv'
#
OUTPUT_FILE = './test_output_file.vhd'
#
csv_file_as_array_of_array = CSV.read('testfile.csv')
#
# the first row of the csv
csv_file_primitive_tests = csv_file_as_array_of_array[0]
#
# Other rows of the csv
csv_file_functional_tests = csv_file_as_array_of_array.drop(1)

p "Is this row 0 the way I want it: #{csv_file_primitive_tests}"
p "Is this everything else the way I want it: #{csv_file_functional_tests}"

puts "Here is the whole csv file as an array of arrays"
p csv_file_as_array_of_array
puts
#
# real data just not from a file yet
temp_fn_test_row_array = 
  ["fn1_test.do" , "x", "", "", "x","verilog_header1.v", "wave_foo.do"]
#
################################################################################





################################################################################
def verilog_test_selection_heredoc_def(arg_individual_verilog_test_name)
  #
  @my_heredoc_test = <<-END.gsub(/^ {2}/, '')
  #===============================================================================
  # verilog test selection
  #===============================================================================
  set verilog_test_selection #{arg_individual_verilog_test_name}
   
  END
  #
end
################################################################################


################################################################################
def model_selection_heredoc_def(arg)
  #
  p "Inside the def, model_selection_heredoc_def: #{arg}"
  #
  @my_heredoc_test = <<-END.gsub(/^ {2}/, '')
  #===============================================================================
  # model selection
  #===============================================================================
  set rocketlink_model  #{arg[0]}
  set pcie_model        #{arg[1]}
  set card_mem_model    #{arg[2]}
  set snrf_model        #{arg[3]}
  set sysio_board_model #{arg[4]}
  set rtc_board_model   #{arg[5]}


  END
  #
end
################################################################################


################################################################################
def wave_file_heredoc_def(arg)
  #
  @my_heredoc_test = <<-END.gsub(/^ {2}/, '')
  
  #===============================================================================
  # wave file selection
  #===============================================================================
  set wave_file #{arg}
   
  # the first command line arg is $1
  # the second command line arg is $2...
  if {[info exists 1]} {
    set supress_waves 1
    } else {
    set supress_waves 0
  }
   
  #===============================================================================
  # simulation control
  #===============================================================================
  # the first command line arg is $1
  # the second command line arg is $2...
  if {[info exists 2]} {
    set prefer_restart 1
    } else {
    set prefer_restart 0
  }

  END
  #
end
################################################################################


################################################################################
def run_test_heredoc_def(arg)
  #
  @my_heredoc_test = <<-END.gsub(/^ {2}/, '')
  #===============================================================================
  # run test
  #===============================================================================
  do call_proc_run_test.do
  END
  #
end
################################################################################


#################################################################################
#write to files
def write_file(target_file,array_to_write)
  puts "Writing to file #{target_file}"
    #
    # w+ access mode
    # Read-write mode. Overwrites existing file if the file exists. If the file
    # does not exist, creates a new file for reading and writing.
    #
     File.open(target_file, "w+") do |f| 
    # This might be for a heredoc, not split for an array?
    # array_to_write.split("\n").each { |element| f.puts(element) } 
    #
    # IO.puts
    # Writes the given objects to ios as with IO#print. Writes a record separator
    # (typically a newline) after any that do not already end with a newline
    # sequence. If called with an array argument, writes each element on a new
    # line. If called without arguments, outputs a single record separator.
    #
    #
    # IO.write
    # Writes the given string to ios. The stream must be opened for writing. If
    # the argument is not a string, it will be converted to a string using
    # to_s. Returns the number of bytes written.
    #
    array_to_write.each { |element| f.puts(element) } 
    # array_to_write.each { |element| f.write(element) } 
  end
end
#################################################################################


################################################################################
def iterate_a_test_def(fn_test_row_array_arg,primitive_test_array_arg)

  p "fn_test_row_array_before_map: #{fn_test_row_array_arg}"
   
  #################################################################################
  # iterate the data.
  fn_test_row_array_after_map = fn_test_row_array_arg.each_with_index.map { |x,i| 
    #
    if i == 0
      puts "column 0  #{x}"
      # name of a modelsim .do file to write out don't change it
      x
    elsif i == ( (fn_test_row_array_arg.length) -2)
      # 2nd to last element is verilog header file
      puts "minus 2 case"
      x
    elsif i == ( (fn_test_row_array_arg.length) -1)
      # last element is the name of wave file, don't change it
      puts "minus 1 case"
      x
    else
      #if (x =='')|| (!x)          # 
      if (x.nil?)|| (x.empty?)
        p "test array #{i} found nil dont put something in" 
        x
      else
        p "test array #{i} found non-nil make a sub" 
        primitive_test_array_arg[i]
      end
    end
    #
  }
  #################################################################################
  p "fn_test_row_array_arg_after_map: #{fn_test_row_array_after_map}"
   
  #################################################################################
  fn_test_row_array_after_map_no_blanks = 
    fn_test_row_array_after_map.reject{ |x| 
    p "x: #{x}"
    x.nil? || x.empty?}
  #
  #remove the first and last elements of the array
  primitive_test_row_array = fn_test_row_array_after_map_no_blanks.slice(1..-3)
  #
  #functional test file name
  fn_test_name_to_write = fn_test_row_array_after_map_no_blanks.first
  #
  #Verilog test file name
  verilog_test_name_to_write = fn_test_row_array_after_map_no_blanks.slice(-2)
  #Wave file name
  wave_file_name_to_write = fn_test_row_array_after_map_no_blanks.slice(-1)
  #################################################################################
   
   
  #################################################################################
  # write to console
  puts
    p "after_map: #{fn_test_row_array_after_map}"
    p "after_map, then remove blanks: #{fn_test_row_array_after_map_no_blanks}"
    p "primitive_test_row_array : #{primitive_test_row_array}"
    p "verilog_test_name_to_write : #{verilog_test_name_to_write}"
    p "fn_test_name_to_write : #{fn_test_name_to_write}"
    p "wave_file_name_to_write : #{wave_file_name_to_write}"
  puts
  #################################################################################
   
   
  #################################################################################
  # put the total functional test together
  tot_individual_test_array = 
   verilog_test_selection_heredoc_def(verilog_test_name_to_write).split("\n") +
      model_selection_heredoc_def(primitive_test_row_array).split("\n") +
        wave_file_heredoc_def(wave_file_name_to_write).split("\n") +
          run_test_heredoc_def("arg not used").split("\n")
  #################################################################################
   
   
  #################################################################################
  p tot_individual_test_array
  #################################################################################
   
   
  #################################################################################
  # write out files
  #
  write_file(fn_test_name_to_write,tot_individual_test_array)
  #
  write_file(verilog_test_name_to_write,["foo"])
  #################################################################################
end
#################################################################################


#################################################################################
# call it
#
#iterate_a_test_def(csv_file_functional_tests[0],csv_file_primitive_tests)
#
csv_file_functional_tests.each { |fn_test|
  #
  iterate_a_test_def(fn_test,csv_file_primitive_tests)
}
#################################################################################


################################################################################
  #
  @verilog_header_heredoc = <<-END.gsub(/^ {2}/, '')
  // ==========================================================================================================
  // test_BTC
  // ==========================================================================================================
  `define DO_BTC_REGISTER_TEST        "NO"    // register verification
  `define DO_BTC_DDR_TEST             "YES"     // ddr buffer verification
  `define DO_BTC_COUPLER_TEST         "NO"     // btc "header only" send & receive, multiple scenarios
  `define DO_BTC_MESSAGE_TEST         "NO"     // btc message test, send & receive 1 message over each channel
  `define DO_BTC_FLUSH_TEST           "NO"     // btc flush tests, multiple scenarios
  // `define DO_BTC_DDR_RACE_TEST        "NO"     // btc, special test for race condition between buffer rx & ddr read-back
  //
  // `include "./src/system_tb/test_BTC.v"      // BTC tests
  END
  #
################################################################################

match_this = "DO_BTC_DDR_RACE_TEST"
match_that = "test_btc.v"




puts "\nHere is the old header"

################################################################################
# 0 or more chars of leading white space followed by
# literal //, which is the verilog comment followed by 
# 0 or more anything followed by
# the target string
# case insensitive
# replace with everything before the literal // and after the literal //
# with two extra spaces where the // was.
# b="  //  `something_else Foo bar".gsub(/^(\s*)\/\/(.*#{c})/i, '\1  \2')
################################################################################

new_verilog_header = @verilog_header_heredoc.split("\n").collect { |x|
  x.gsub(/^(\s*)\/\/(.*#{match_this})/i, '\1  \2')
  x.gsub(/^(\s*)\/\/(.*#{match_that})/i, '\1  \2')
  }

puts new_verilog_header
