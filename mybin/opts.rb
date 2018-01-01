require 'optparse'
require 'pp'

options = {}

optparse = OptionParser.new do|opts|


  options[:myint] = 1
  # short form. 
  #
  #long form parameter NUM is optionol bc its in []
  # Automatically convert args  pass Integer to the on method after switch description.
  #
  opts.on( '-n', '--number [NUM]', Integer, "Convert to integer" ) do|n|
    options[:myint] = n
  end

  options[:simple] = false
  
  opts.on( '-s', '--simple', "Simple argument" ) do
    options[:simple] = true
  end

  # This displays the help screen, all programs are
  # assumed to have this option.
  opts.on( '-h', '--help', 'Display this screen' ) do
    puts opts
    exit
  end
end

# Parse the command-line. Remember there are two forms
# of the parse method. The 'parse' method simply parses
# ARGV, while the 'parse!' method parses ARGV and removes
# any options found there, as well as any parameters for
# the options. What's left is the list of files to resize.
optparse.parse!

pp "Options:", options
pp "ARGV is:", ARGV

p   "List is",  options[:list]

p "options[:myint]",options[:myint]
p "options[:simple]",options[:simple]
