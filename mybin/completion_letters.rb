#!/usr/bin/env ruby
################################################################################
# This class-module-lib is needed by the FileUtils.cp_r() method.
require 'fileutils'


#This pathname class-module-lib replaces several File and Dir class-modules
#and provides nicer methods for accesing and manipulating paths
require 'pathname'
################################################################################


################################################################################
#Parameters
vhdl_file_location_root ="./"
#
days_back_window = 160
#
array_element_needed_in_path = 2

COPY_ALLOW_OVERWRITE = true

#note a space OK in the path
#path_to_save_files_for_cmpltion_ltters = "./tempb other/"
path_to_save_files_for_cmpltion_ltters = "./tempd_other/"
################################################################################


################################################################################
#this is how to update the docs and trunk
# ruby to do this?
# under what conditions?
#
  #find -iname "docs" -type d -not -path "*/tags/*"|svn update -set-depth infinity
  #find -iname "trunk" -type d -not -path "*/tags/*"|svn update -set-depth infinity
################################################################################


################################################################################
#intro banner
puts "\n----START OF COMPLETION_LETTERS.RB----"
################################################################################


################################################################################
#shell find command
puts "Running time sensitive shell find now"
#
#Note extra escaping \\ required for ruby  compared to bash \ for thefind command
vhdl_files_recursive_array = 
  # `find #{vhdl_file_location_root} -iname "*.vhd" -mtime -#{days_back_window}`.split(/\n/)
  `find #{vhdl_file_location_root} \\( -iname "*.vhd"  -o -iname "*.doc" \\)  -mtime -#{days_back_window}`.split(/\n/)
#
puts "Time sensitive shell find complete"
#
puts "Running time insensitive shell find now"
#
vhdl_files_recursive_array_no_time = 
   `find #{vhdl_file_location_root} \\( -iname "*.vhd"  -o -iname "*.doc" \\)`.split(/\n/)
  #`find #{vhdl_file_location_root} -iname "*.vhd" `.split(/\n/)
#  
puts "Time insensitive shell find complete"
#
#a way to get the nix style find -mtime, without using a shell command
#stackoverflow.com/questions/14782869/finding-files-older-than-x-hours-using-ruby
# require 'fileutils'
# Dir.glob("/var/log/myservice.log.*").
#   select{|f| File.mtime(f) < (Time.now - (60*120)) }.
#   each{|f| FileUtils.cp(f, '/home/myhomedir/mylogs/') }
################################################################################


################################################################################
#filter
vhdl_files_recursive_array_filtered = vhdl_files_recursive_array.reject do |x|
  x=~/temp/
end
#
vhdl_files_recursive_array_filtered_no_time = vhdl_files_recursive_array_no_time.reject do |x|
  x=~/temp/ || x=~/tags/ || x =~ /managed_ip_project/
end
################################################################################

  
################################################################################
vhdl_design_names = vhdl_files_recursive_array_filtered.collect do |x| 
  x.chomp.split("/")[array_element_needed_in_path]  
end
#
vhdl_design_names_unique = vhdl_design_names.uniq
################################################################################


################################################################################
#netsed each loops
puts "vhdl_design_names_unique #{vhdl_design_names_unique.inspect}"

#compact removes nil (don't know why in is getting a nil)
vhdl_files_recursive_array_filtered_no_time_cmpt = vhdl_files_recursive_array_filtered_no_time.compact
vhdl_design_names_unique_cmpt = vhdl_design_names_unique.compact


vhdl_files_to_save = []
vhdl_files_recursive_array_filtered_no_time_cmpt.each do |x|
  #
  vhdl_design_names_unique_cmpt.each do |y|
    #
    # if x =~ /#{y}/ 
    if x.include?(y)
      #puts "matched adding #{x} to the temp array"
      # vhdl_files_to_save << "#{x} because it contained #{y}"
      vhdl_files_to_save << x
    end
  #
  end
  #
  #
end
puts vhdl_files_to_save
################################################################################


################################################################################
puts "\nThe vhdl design names that have changed in the last #{days_back_window} days:"
vhdl_design_names_unique.each do |x|
  print "  #{x}\n"
end
################################################################################


################################################################################
# Copy design files.  Note the attribute to allow overwrite is true
# Setting the permission to false causes Ruby to error if the destination exists
#

# temp_dir_name = "temp3"
# if true
# puts "Copying files now"
#   #
#   #for some reason cp_r does not want to create a dir 1.87 and Linux,
#   # with 1.93 on Windows it's makes it.  Need to add a seperate call to mkdir_p
#   FileUtils.mkdir_p(temp_dir_name)
# end    
  #
  
  # vhdl_files_to_save.each do |file|
  #   FileUtils.cp_r(file, temp_dir_name, 
  #     :remove_destination => COPY_ALLOW_OVERWRITE)
  # end
  

  #FileUtils.cp_r(vhdl_files_to_save, temp_dir_name,:remove_destination => COPY_ALLOW_OVERWRITE)

################################################################################
#iterate over this tomorrow to create the full hierarchitical structure
def copy_with_path(src, dst)
  FileUtils.mkdir_p(File.dirname(dst))
  p dst
  # FileUtils.copy_file(src, dst)
  # FileUtils.copy_file(src, dst) does not like source file path with spaces in the name 
  # such as we have with most of the fpga release reports.
  system "cp #{src} #{dst}"
  # the command line is Ok with the space in the src, however it has trouble with 
  # space in the dst path if there is one.  The copy is executed well but it 
  # messages a bunch of stuff that the user does not want.  The target dir provided
  # by management seems to always include spaces in the name.
  # Perhaps the space should be escaped in Ruby then passed to the shell.
end



vhdl_files_to_save.each do |file_to_save_parpath|
   tempvar = path_to_save_files_for_cmpltion_ltters + file_to_save_parpath
   copy_with_path(file_to_save_parpath,tempvar)
end
   

# #make temp3 a named folder
# new_dest = "./temp3/" + "svcont_fpga/svcont/trunk/src/tmru_top/tmru_top.vhd"

# copy_with_path("./svcont_fpga/svcont/trunk/src/tmru_top/tmru_top.vhd",new_dest)


################################################################################

#these are the files we want
# dpifpt
# dpifpta
# ptst
# svst
# svcont
 



################################################################################
puts "\n----END OF COMPLETION_LETTERS.RB----"
################################################################################
