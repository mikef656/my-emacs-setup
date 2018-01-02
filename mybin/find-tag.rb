#!/usr/bin/env ruby
################################################################################
# Make this into a create tag, here is how to do it from the cli.
  # svn cp -m "PTST Design create tag rev_0908" 
  # https://chivcs.tmriusa.com/svn/tmiller/proj/surecom/fpgas/scst2va_fpga/ptst/trunk 
  # https://chivcs.tmriusa.com/svn/tmiller/proj/surecom/fpgas/scst2va_fpga/ptst/tags/rev_0908
  # Ruby code like this
    # svn cp -m "PTST Design create tag rev_0908" . #{target_new}
  

################################################################################
# This class-module-lib is needed by the FileUtils.cp_r() method.
require 'fileutils'
#
#This pathname class-module-lib replaces several File and Dir class-modules
#and provides nicer methods for accesing and manipulating paths
require 'pathname'
################################################################################

USE_GAWK_TO_GET_SVN_INFO           = true
#################################################################################
puts "\n----- BEGIN:PROMPT USER FOR TAG TO RELEASE-----"
#################################################################################


################################################################################
# Assume user started this script in the folder named for the FPGA.
# in this example it's the ptst dir
#
# /mydata/ptst_co_at_r896/
#  +-ptst/                  <-- START SCRIPT IN THIS DIR (named for FPGA) --<
#     |-docs/
#     |-tags/
#     |  |-rev_0901/
#     |  |-rev_0902/
#     +-trunk/
#        |-builds/
#        |-par/
#        |-ruby/
#        |-sim/
#        |-src/
#        |-synth/
#
fpga_name_pn_obj = Pathname.getwd.basename
print  "FPGA_NAME: ", fpga_name_pn_obj, "\n"
################################################################################


################################################################################
cwd_pn_obj = Pathname.pwd()
cwd_tags_dir_pn_obj = cwd_pn_obj + "tags"
puts "CWD = \n  #{cwd_pn_obj}"
#puts cwd_tags_dir_pn_obj
################################################################################


################################################################################
# changing dir in a block is temporary,the old cwd is restored when block exits.
Dir.chdir(cwd_tags_dir_pn_obj) do
  @tags_url  = %x[svn info | gawk "/^URL: / { print $2 }"].chomp
  puts "The tags url is:\n  #{@tags_url}"
  @tags_array = `svn list #{@tags_url}`.gsub("/","").split(/\n/)
  #don't care which is newest anymore
  # @newest_tag_in_svn = @tags_array.sort.last
end                                
################################################################################


################################################################################
puts "\nThese are the tags I found in SVN 
  #{@tags_array}\n"
#puts @tags_array.class
#puts "newest_tag_in_svn : #{@newest_tag_in_svn}"
#puts @newest_tag_in_svn.class
################################################################################


################################################################################
print "Choose a tag to release\n"
tag_to_release  = gets.chop
print "OK will release :#{tag_to_release}\n"
################################################################################


################################################################################
# changing dir in a block is temporary,the old cwd is restored when block exits.
tags_selected_for_rel_dir_pn_obj = cwd_tags_dir_pn_obj + tag_to_release
@tags_selected_for_rel_url = @tags_url + "/" + tag_to_release

puts "tags_selected_for_rel_url : 
  #{@tags_selected_for_rel_url}"

#file:///C:/work/junkrepo/svst/tags/rev_0002

@selected_tags_listing_array_url_based =                    #match fwd slash at eol
  `svn list #{@tags_selected_for_rel_url} -R`.gsub(/\/$/,"").split(/\n/)

#why does puts make a mess of this?
#puts "selected_tags_listing_array: #{@selected_tags_listing_array_url_based}"

#there are a lot, they clog the display
# @selected_tags_listing_array_url_based.each do |x|
#   print "#{x}\n"
# end

tag_to_release_wo_rev_prefix = tag_to_release.gsub(/rev_|rev/,"").split(/\n/).join
print "rev wo the rev_ prefix:
  #{tag_to_release_wo_rev_prefix}\n"
#print "var tag_to_release_wo_rev_prefix class:#{tag_to_release_wo_rev_prefix.class}\n"

#puts "is it an array? #{tag_to_release_wo_rev_prefix.kind_of?(Array)}"

selected_tags_listing_array_bit_files_url_based = 
  @selected_tags_listing_array_url_based.collect do |x| 
    if /#{tag_to_release_wo_rev_prefix}.bit/.match(x)
      x
    else
      nil
    end
  end.compact.join
  #compact removes the nil enteries fromt the array

puts "The matches are: #{selected_tags_listing_array_bit_files_url_based}"

url_of_bit_file_to_co_for_release = 
  @tags_selected_for_rel_url + 
  "/" + 
  selected_tags_listing_array_bit_files_url_based

puts "URL of the bit file to co and later release:
  #{url_of_bit_file_to_co_for_release}"

#{tag_to_release}

#Need to pick the .bit file out of this array, then check it out to somewhere?
  #Need a better match

new_temp_dir = Pathname.new("./temp")
begin
  new_temp_dir.mkdir
rescue
 puts "--TRIED TO CREATE DIR THAN ALREADY EXITS--"
end


temp_dir_full_pn = cwd_pn_obj + new_temp_dir

#print puts temp_dir_full_pn


################################################################################
# changing dir in a block is temporary,the old cwd is restored when block exits.

#cwd_pn_obj = Pathname.pwd()
#cwd_tags_dir_pn_obj = cwd_pn_obj + "tags"

pn = Pathname.new("#{url_of_bit_file_to_co_for_release}")
pn_wo_filename = pn.dirname
pn_just_filename = pn.basename
#puts "pn_wo_filename: #{pn_wo_filename}"  

Dir.chdir(temp_dir_full_pn) do
 `svn co --depth empty #{pn_wo_filename} .`
 #puts "getting \n   #{url_of_bit_file_to_co_for_release}"
 #
 # `svn up #{url_of_bit_file_to_co_for_release} .`
 #
 #interisting that svn did not want to co when I used the full url it only 
 #took the filename.
 `svn up #{pn_just_filename} .`
 puts "Listing dir"
 puts `ls -lrt .`
end                                
################################################################################

# Dir.chdir(tags_selected_for_rel_dir_pn_obj) do
#   @tag_selected_for_release_url  = %x[svn info | gawk "/^URL: / { print $2 }"].chomp
#   puts "The tag selectod for release url is: #{@tag_selected_for_release_url}"
#   #don't care which is newest anymore
#   # @newest_tag_in_svn = @tags_array.sort.last
# end                                
# ################################################################################



################################################################################
# match two hex chars at the end of the line. \h{2}$
# fpga_rev_two_dig_hex_matchdata_obj = /\h{2}$/.match(newest_tag)
fpga_rev_two_dig_hex_matchdata_obj = /\h{2}$/.match(@newest_tag_in_svn)
fpga_rev_two_dig_hex_fixnum        = fpga_rev_two_dig_hex_matchdata_obj.to_s.to_i(16) 
fpga_rev_two_dig_hex_fixnum_plus1  = fpga_rev_two_dig_hex_fixnum + 1
################################################################################


#want to get the rest of the match to be used below.

#stackoverflow.com/questions/84421/converting-an-integer-to-a-hexadecimal-string-in-ruby
fpga_rev_two_dig_hex_string_plus1 = sprintf("%02X",fpga_rev_two_dig_hex_fixnum_plus1).to_s


#new 9-12-2013 try to get the rev_06 part for the cases where it's not rev_06
#beginning_of_rev_string = fpga_rev_two_dig_hex_matchdata_obj.pre_match
#puts "beginning_of_rev_string #{beginning_of_rev_string}"
#puts "end_of_rev_string #{fpga_rev_two_dig_hex_string_plus1}"
# 
#new_fpga_rev_string = "rev_06" + fpga_rev_two_dig_hex_string_plus1
# 
# 
#puts "The new rev will be: #{new_fpga_rev_string}"
#puts new_fpga_rev_string.inspect


#might want to prompt the user "Use sequential tag" if answer no then prompt


#might want to create a def called "discover_newest_svn_tag"


#Create a new tag based on var new_fpga_rev_string

#################################################################################
# Get the URL and TAG revision for the release report
# Possible, change this to Ruby so the user does not need gawk
if USE_GAWK_TO_GET_SVN_INFO  
  wc_url  = %x[svn info | gawk "/^URL: / { print $2 }"].chomp
  tag_rev = %x[svn info | gawk "/^Revision: / { print $2 }"].chomp
  #puts "TAG URL: #{wc_url}"
  #puts "TAG Revision: #{tag_rev}"
end  
  
  wc_tags_url = wc_url + "/tags"
  #puts "With tags on the end #{wc_tags_url}"
  #wc_tags_url = wc_url + "/tags" + "/" + "#{new_fpga_rev_string}"
  #puts "the new url will be #{wc_tags_url}"
#################################################################################


#################################################################################
def get_wc_url_fn
  %x[svn info | gawk "/^URL: / { print $2 }"].chomp
end
#
#puts "The cwd svn URL is #{get_wc_url_fn}"  
#################################################################################


#################################################################################
def get_wc_rev_fn
  %x[svn info | gawk "/^Revision: / { print $2 }"].chomp
end
#
#puts "The rev #{get_wc_rev_fn}"
#################################################################################


#################################################################################
puts "----- END:PROMPT USER FOR TAG TO RELEASE-----"
#################################################################################

