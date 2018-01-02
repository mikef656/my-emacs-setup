#!/usr/bin/env ruby
#################################################################################
#Develop something that writes out valid HDL code based on parameters
#Todo
#Make a complete HDL file that will compile.
#################################################################################


#################################################################################
def prepare_ports(inport_arg,num_inports_arg)
  #one time init
  group_of_inports = [] unless group_of_inports
  #
  #
  num_inports_arg.times do |i| 
    group_of_inports << inport_arg.gsub("_0",_1) 
  end
  #
  #total ports in + out + inout + whatever
  array_of_ports = group_of_inports
  #
  #Remove the ; for the last port
  #---NEED TO CHANGE THIS TO AN ARRAR TO GET THE LAST ONE---
  array_of_ports[-1] = array_of_ports.last.sub(";",'')

  #
  if nil
    puts "the 2nkd from last is #{array_of_ports[-2]}"
    puts "the last is #{array_of_ports.last}"
    puts "the length is #{array_of_ports.count}"
    puts "the group is #{array_of_ports}"
  end
  
  #Add (prepend) header and trailer (append)
  this_entity = array_of_ports.unshift(@entity_header_text) << @entity_trailer_text
end
#################################################################################


#################################################################################
def create_append_multi_port_groups(inport_arg,num_inports_arg)
  #one time init
  group_of_inports = [] unless group_of_inports
  #
  #
  num_inports_arg.times do |i| 
    group_of_inports << inport_arg
  end
  #
  if nil
    puts "the 2nkd from last is #{array_of_ports[-2]}"
    puts "the last is #{array_of_ports.last}"
    puts "the length is #{array_of_ports.count}"
    puts "the group is #{array_of_ports}"
  end
  #
  group_of_inports
end
#################################################################################


#################################################################################
def write_entity(inport_arg,num_inports_arg)
  #one time init
  group_of_inports = [] unless group_of_inports
  #
  #
  num_inports_arg.times do |i| group_of_inports << inport_arg end
  #
  #total ports in + out + inout + whatever
  array_of_ports = group_of_inports
  #
  #Remove the ; for the last port
  #---NEED TO CHANGE THIS TO AN ARRAR TO GET THE LAST ONE---
  array_of_ports[-1] = array_of_ports.last.sub(";",'')
  #
  if nil
    puts "the 2nkd from last is #{array_of_ports[-2]}"
    puts "the last is #{array_of_ports.last}"
    puts "the length is #{array_of_ports.count}"
    puts "the group is #{array_of_ports}"
  end
  #Add (prepend) header and trailer (append)
  this_entity = array_of_ports.unshift(@entity_header_text) << @entity_trailer_text
end
#################################################################################


#################################################################################
def apnd_pstpnd(orig_string_arg,prepend_string_arg,postpend_string_arg, *sub_for_semi)
  #one time init
  group_of_inports = [] unless group_of_inports
  #
  #total ports in + out + inout + whatever
  if orig_string_arg.is_a? Array
    orig_string = orig_string_arg.join
  else
    orig_string = orig_string_arg
  end
  #
  if prepend_string_arg.is_a? Array
    prepend_string = prepend_string_arg.join
  else
    prepend_string = prepend_string_arg
  end
  #
  if postpend_string_arg.is_a? Array
    postpend_string = postpend_string_arg.join
  else
    postpend_string = postpend_string_arg
  end
  #
  if sub_for_semi[0]
    orig_string = orig_string.gsub!(/(.*)(;)(.*)/m,'\1\3')
  end
  #
  tot_string = prepend_string + orig_string  + postpend_string
  #
end
#################################################################################

#this is it
#d = c.collect do |x| x.split("\n") end.flatten
#
#

#################################################################################
def increment_num_at_end_of_port_name(string_of_ports_w_int_at_end)
  #takes a sting of several VHDL ports and increments the last digit
  # expect the _<digit> format
  # so a single sting
  #  foo_0 : in std_logic;
  #  foo_0 : in std_logic;
  #becomes
  #  foo_1 : in std_logic;
  #  foo_1 : in std_logic;
  #return the new string
  #
  result = string_of_ports_w_int_at_end.gsub(/_(\d)/) {|match|   
    Regexp.last_match[1] 
    #
    #1st capture group
    local_var = Regexp.last_match[1].to_i + @inc_val
    result = "_" + local_var.to_s
    }
  #
  @inc_val += 1
  result
end
#################################################################################


#################################################################################
def function_name_as_part_of_port_name(string_of_ports_w_function0_at_begin)
  #takes a sting of several VHDL ports and increments the last digit
  # expect the _<digit> format
  # so a single sting
  #  foo_0 : in std_logic;
  #  foo_0 : in std_logic;
  #becomes
  #  foo_1 : in std_logic;
  #  foo_1 : in std_logic;
  #return the new string
  #
  def_loc = 0
  result = string_of_ports_w_function0_at_begin.gsub(/function0/) {|match|   
    Regexp.last_match[1] 
    #
    #1st capture group
    local_var = Regexp.last_match[1].to_i + @inc_val
    result = "_" + local_var.to_s
    }
  #
  @inc_val += 1
  result
end
#################################################################################


#################################################################################
#named multi-port groups
def create_named_multi_ipt_port_groups(group_arg,names_array)
  
  #puts "names array #{names_array.inspect}"
  #puts "group_arg #{group_arg.inspect}"
  #
  #check that the names array is valid
  #if true
  puts "reached before"
    group_arg.each do |i|
      puts "reached inside each loop"
      if i.nil?
        puts "REACHED INSIDE NIL DET IFP"
        begin
        rescue
          puts "Names array containn a nil, aborting, here is the array"
          puts names_array.inspect
          abort
        end
      end
    end
  #end
  puts "reached after"
  #
  puts "reached before gsub collect"
  #
  group_arg.each_with_index.collect do |group,i|
    if group
      group.gsub("function0",names_array[i])
    else
      puts "detected nil in group"
    end
  end
  #
  puts "reached after gsub collect"
  #
  #deflocal
end
#################################################################################


#################################################################################
#this code is currently (r1861) not used but save it.
#Create the increment port groups
  #@inc_val = 1
  #multiple_input_groups_w_inc = multi_ipt_port_group.collect do |port_group| 
  #  increment_num_at_end_of_port_name(port_group) 
  #end
  ##
  #@inc_val = 1
  #multiple_output_groups_with_inc = multi_opt_port_group.collect do |port_group| 
  #  increment_num_at_end_of_port_name(port_group) 
  #end
#################################################################################

#################################################################################
#keep this for reference, but for now I like the read the entire csv into
#an arrar of arrays
  #first_col = []
  #first_row_of_csv = []
  #CSV.foreach("hdl_router_input.csv") {|row| first_col << row[0]}
  ##
  ## stackoverflow.com/questions/12407035/ruby-csv-get-current-line-row-number
  #CSV.foreach("hdl_router_input.csv") do |row| 
  #  #print  $INPUT_LINE_NUMBER, ' ', row, "\n"
  #  #
  #  if  $INPUT_LINE_NUMBER == 1 then 
  #    #puts "gots here"
  #    # puts row.inspect
  #    first_row_of_csv = row
  # 
  #  end
  #end
#################################################################################


#################################################################################
#CSV stuff
#2nd part of this article describes the row object well
#sitepoint.com/guide-ruby-csv-library-part/
#read in the CSV file as an array of arrays
#
# if the specified .csv file exists (holds input and output functions) read it in
# else use the input function names given in the array below
#
def process_csv(csv_file_arg)
  if File.file?(csv_file_arg)
    puts "file exists"
    hdl_router_input = CSV.read(csv_file_arg)
    #
    #some of these intermediates could eliminated, keep them for exammples of csv
    first_row_of_csv = hdl_router_input[0]
    first_column_of_csv  = hdl_router_input.transpose[0]
    input_functions  = first_column_of_csv[1,first_column_of_csv.length]
    output_functions = first_row_of_csv
    ipt_fn_names_array = input_functions
    opt_fn_names_array = output_functions
    #
    if nil
      puts "output fn's #{output_functions}"
      puts "input fn's  #{input_functions}"
    end
  else
    puts "file does not exist"
    ipt_fn_names_array = @default_ipt_fn_names_array
    opt_fn_names_array = @default_opt_fn_names_array
  end
  [ipt_fn_names_array,opt_fn_names_array,hdl_router_input]
end
#################################################################################


#################################################################################
#write to files
def write_hdl_file(target_file,array_to_write)
  puts "Writing to files"
  #
  File.open(target_file, "w+") do |f| 
    array_to_write.split("\n").each { |element| f.puts(element) } 
  end
end
#################################################################################


#################################################################################
