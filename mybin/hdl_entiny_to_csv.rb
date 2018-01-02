#!/usr/bin/env ruby

################################################################################
#run this from the command line like this
#>hdl_entiny_to_csv.rb file_to_convert.vhd
#
#when run with no argument, use a small Ruby heredoc as input.  This is useful
#for debug of this program.
#
#Use this program to create port map table as part of FPGA documentation.
#
#Some variations put --in the first column, when opening in excel, excell
#thinks this is part of a formula and gives an error in each cell.  To overcome
#this use the import wizard and tell excel that the first column in plain text.
################################################################################


################################################################################
require 'csv'
################################################################################


################################################################################
#params
VERBOSE_DEBUG = TRUE
WRITE_TO_FILES = TRUE
################################################################################


################################################################################
  entity_header_text = <<-END.gsub(/^ {2}/, '')
  entity ptst is
     generic (CHIPSCOPE                         : boolean := FALSE);
   
     port ( 
           -- Main Clocks and Reset Inputs
           fpga_reset          : in    std_logic;  -- async active high reset
           clk175M_ref_p       : in    std_logic;  -- 175 MHz clock
           -- SCH RocketLink Interface
           sch_sfpplus1_rx_p   : in    std_logic;
           sch_sfpplus1_rx_m   : in    std_logic;
           dbg_rxd             : in    std_logic
     );
  end ptst;
END
  #
################################################################################


#################################################################################
if ARGV.empty?
  puts "--No command line file given--\n\n" 
  hdl_file = 
    'c:/Users/mfitzgerald/mydata/ptst/trunk/src/ptst/design/scst3_clocks.vhd'
  hdl_file_lines  = File.readlines(hdl_file).each  { |x| x.chomp!}
  hdl_file_as_string  = hdl_file_lines.join("\n") # 
  hdl_file_as_string  = entity_header_text
else
  puts "\n--file given as argument:--\n  #{ARGV.first.inspect}\n\n"
  hdl_file_lines  = File.readlines(ARGV.first).each  { |x| x.chomp!}
  hdl_file_as_string  = hdl_file_lines.join("\n")
end
#################################################################################


################################################################################
#read in files
################################################################################


################################################################################
#get the entity name
entity_regex = /entity\s+(\w+)/

begin
  entity_name = hdl_file_as_string.scan(entity_regex)[0][0]
rescue
  puts "--No entity found in the file #{ARGV.first}, aborting--"
  abort
end
################################################################################


################################################################################
#capture ports remove extra whitespace, remove :
#
port_regex = /port\s*\((.*?)\);\s*end/m
#
puts "port_regex is a Regexp? #{port_regex.is_a? Regexp}\n\n"
#
port_capture_filter_clean = hdl_file_as_string
  .scan(/port\s*\((.*?)\);\s*end/m)[0][0] #when you ask for groups Ruby rtrns an aoa
  .gsub(/^\s+/,'')
  .gsub(/\s+$/,'')
  .gsub(/:/,'')
################################################################################


################################################################################
def proc(arg_lines)
  #
  lsowtc= arg_lines.collect do |entity_lines|
    #
    if entity_lines =~ /(^\w+)\s+(\w+).*(--.*)/
      #matches to this regex look like: name mode --comment
      [Regexp.last_match(1) , Regexp.last_match(2),Regexp.last_match(3).gsub(/--\s*/,'')]
    elsif entity_lines =~ /(^\w+)\s+(\w+)/
      #matches to this regex look like: name mode
      [Regexp.last_match(1) , Regexp.last_match(2)]
    else
      #matches to this regex look like: --comment
      [entity_lines.gsub(/--\s*/,'--').upcase]
    end
    #
  end
  lsowtc
end
################################################################################


################################################################################
process_lines = proc(port_capture_filter_clean.split("\n"))
process_lines.unshift ["PORT/INTF NAME","MODE","DESCRIPTION"]
process_lines.unshift ["module name: #{entity_name}".upcase]
#
puts "process_lines\n: #{process_lines}"
################################################################################


################################################################################
#write to files
filename_to_write = "./" + entity_name + ".csv"
puts "will write #{filename_to_write}"
#
if WRITE_TO_FILES
  CSV.open(filename_to_write, 'w') do |csv_object|
    process_lines.each do |row_array|
       p row_array
       csv_object << row_array
      
    end
  end
end
################################################################################


################################################################################
if entity_name
  puts "\nFound this entity name in scanning:\n  #{entity_name.inspect}"
  #puts "\nFound this port related thing in scanning #{port_capture_filter_clean}"
else
  puts "\nnothing found"
end
################################################################################
