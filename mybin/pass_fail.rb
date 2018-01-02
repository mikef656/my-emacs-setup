################################################################################
# Creates a list of tests that passed or failed.
#usage
# pass_fail.rb
#
################################################################################

################################################################################
#This pathname class-module-lib replaces several File and Dir class-modules
#and provides nicer methods for accesing and manipulating paths
require 'pathname'
require 'pp'
################################################################################

################################################################################
#settings
################################################################################
PRINT_MISMACHING_LINES_VERBOSE = FALSE
#
# path_to_transripts  = 'c:/proj/rhs/sim/logs/transcripts/'
path_to_transripts  = './'

################################################################################
# Create out file name
################################################################################
out_file_name  = 'pass_fail.log'
puts "  Output file name: #{out_file_name}","\n"  

################################################################################
# New Empty array
################################################################################
@temp = []

################################################################################
def search_file_declare(file_name_arg)
    current_file_contents_as_an_array  = File.readlines(file_name_arg)

    passed = TRUE

    current_file_contents_as_an_array.each { |line_of_file|
      if line_of_file =~ /mismatch/i ||   
            line_of_file =~ /fail.*timeout.*/i ||
              line_of_file =~ /.*timeout.*fail/i ||
                line_of_file =~ /.*error[ ]+.*not.*/i
          #
         if PRINT_MISMACHING_LINES_VERBOSE
           puts "here is a mismathing line #{line_of_file}"
         end
         #
         passed = FALSE
      end
    }

    if passed
      puts " #{file_name_arg.basename} passed"
      (foo ||= []) << " #{file_name_arg.basename} passed"
      passcount = passcount + 1
    else
      puts " #{file_name_arg.basename} failed"
      (foo ||= []) << " #{file_name_arg.basename} failed"
      failcount = passcount + 1
    end

    @temp << foo

end
################################################################################

################################################################################
  if FALSE
    file_name_array.each { |file_name|

      search_file_declare(file_name)
    }
  end
################################################################################

################################################################################
  if TRUE
    Pathname.glob("#{path_to_transripts}*.log") do |log_file|                  
      #puts rb_file.basename
      search_file_declare(log_file)
    end                                                         
  end
################################################################################

################################################################################
  puts "temp array" 
  pp @temp

  File.open("pass_fail_results.txt","w") do |f|
    PP.pp(@temp,f)
  end

  if FALSE
    pathname_array = Pathname.glob("#{path_to_transripts}*.log")
    p pathname_array                  
  end

puts "passcount is : #{passcount}"
puts "failcount is : #{failcount}"


################################################################################
# Write output
################################################################################
if FALSE
  File.open(out_file_name, 'w') { |file| file.
    write(file_contents_as_a_string_subbed) }
end

