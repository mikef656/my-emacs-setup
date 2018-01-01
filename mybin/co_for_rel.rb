#!/usr/bin/env ruby
################################################################################
#  Usage
#  Start this script in from a Windows cmd line in the folder named for the FPGA.
#  There are no command line options, just type co_for_rel.rb
#
#  In this example it's the ptst dir
#
#  /mydata/ptst_co_at_r896/
#   +-ptst/                  <-- START SCRIPT IN THIS DIR (named for FPGA) --<
#      |-docs/
#      |-tags/
#      |  |-rev_0901/
#      |  |-rev_0902/
#      +-trunk/
#         |-builds/
#         |-par/
#         |-ruby/
#         |-sim/
#         |-src/
#         |-synth/
#
#  Two new directories are created by this program, that are checkouts from
#  SVN of the files to be released. The main release script should look down
#  in these dirs for its sources to push.  This program will prompt the user
#  to choose a tag to pull the design files from.
#   
#  /mydata/ptst_co_at_r896/
#   +-ptst/                  <-- START SCRIPT IN THIS DIR (named for FPGA) --<
#      |-docs/
#      |-tags/
#      +-trunk/
#      |-temp_doc                  <--Created   by this program 
#         |-rel_rep                <--Chckd out by this program
#      |-temp                      <--Created   by this program
#         |-tmru_top.ngc           <--Chked out by this program
#         |-tmru_top_rev03a07b.zip <--Chked out by this program
#
# co_for_rel.rb uses the url is obtained from the working copy's 
#   ptst/tags
#   ptst/docs
# folder.
# This works if the working copy is a checkout that contains this folder.
# Stated otherwise this program assumes that the wc contains the 
#   ptst/tags
#   ptst/docs
################################################################################


################################################################################
LIST_ALL_PATHS_FOUND_IN_SVN_VERBOSE = false
CO_FN_VERBOSE = FALSE
PROCESS_ZIP = true
DONT_PROCESS_ZIP = false
REMOVE_OLD_DIRS = true
################################################################################


################################################################################
# This class-module-lib is needed by the FileUtils.cp_r() method.
require 'fileutils'
#
#This pathname class-module-lib replaces several File and Dir class-modules
#and provides nicer methods for accesing and manipulating paths
require 'pathname'
################################################################################


################################################################################
def url_of_co_file_for_rel_fn(arg1, arg2)
    arg1 + "/" + arg2
end
################################################################################


################################################################################
def cd_to_tempdir_and_co_fn(full_path,full_url,look_for_zip,fname)
  #
  Dir.chdir(full_path) do
    #
      `svn co --depth empty #{full_url.dirname} .`
      #
      #puts "full_url.basename: #{full_url.basename}"
      #
      if full_url.basename.to_s.length == 0
        puts "detected 0 length filename"
      end
      `svn up #{full_url.basename} .`
      #
      if look_for_zip
        # if /zip/ =~ file_in_temp_docs_dir_just_filename_pn_obj.to_s
        if /zip/ =~ full_url.basename.to_s
          puts "\nZip file detected, unziping"
          `unzip #{full_url.basename}`
        else
          puts "No zip file detected"
        end
      end
      #
      #embed the rev string, so that downstream programs can read it.
      unless fname == ""
        FileUtils.touch("#{fname}")
      end
      puts "\n----LISTING ./#{Pathname.pwd().basename} DIR WHERE FILE(S) TO BE RELEASED WERE CHKD OUT----"
      puts `ls -lrt .`
      #
  end                                
end
################################################################################


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


################################################################################
#pass this an array of a bunch of stuff, then it filters the array down if
# a regex match occurs.
#arg file name fragment is optional, introduced it bc in netlist release cases
# there can be more than one match to rev_01.  The rocketlink is also delivered
# as a zipped core with rev_xxx in it's name.
#                                                            * means optional (packs an array)
def match_arrary_to_file_type_fn(array_name, tag, file_type, *file_name_fragment)
  #selected_pdf_file_url_based = 
    # @docs_array.collect do |x| 

  if file_name_fragment[0]
  #   
    #convert both args to lower case so that 0b01 matches 0B01
    array_name.collect do |x| 
      if /#{file_name_fragment[0].downcase}.*#{tag.downcase}}#{file_type}/.match(x)
        x
      else
        nil
      end
     
    end.compact.join
  #   
  else
  # 
    #convert both args to lower case so that 0b01 matches 0B01
    array_name.collect do |x| 
      if /#{tag.downcase}#{file_type}/.match(x.downcase)
        x
      else
        nil
      end
     
    end.compact.join
  #
  end
  #
   #compact removes the nil enteries front the array
end
################################################################################


################################################################################
def maybe_remove_old_dirs_fn
  tempdirs_array =  Pathname.glob('*temp*')
  #
  unless tempdirs_array.length ==0
    #
    puts "FOUND OLD DIRECTORIES:\n"
    tempdirs_array.each { |f| puts "  .\/#{f}" } 
    #
    puts "\nConsider Removing old temp* dirs produced by earilier runs of this tool."
    puts "  Type n-RET to prevent removal of old temp dirertories, RET to continue wo removing."
    print "  THE TYPICAL WORK FLOW SHOULD REMOVE THE OLD DIRS:"
    #
    unless gets.chop == "n"
    #
      begin
        #this produces an array of dirs that match the glob 
        tempdirs_array.each do|f|
          #puts f
          #remove each dir that matched the glob
          FileUtils.remove_dir(f,force=true)
        end
      #
      rescue
        puts "Reached the error rescue for dir removal"
        puts "Something prevented temp dirs or files from being removed"
      end
    #
    end
    #
  end
end
#################################################################################


#################################################################################
puts "\n----- BEGIN:PROMPT USER FOR TAG THEN CO FILES FOR RELEASE-----"
#################################################################################


#################################################################################
#
maybe_remove_old_dirs_fn
#################################################################################


################################################################################
#   
fpga_name_pn_obj = Pathname.getwd.basename
print  "FPGA_NAME: ", fpga_name_pn_obj, "\n"
################################################################################



################################################################################
cwd_pn_obj = Pathname.pwd()
tags_dir_pn_obj = cwd_pn_obj + "tags"
docs_dir_pn_obj = cwd_pn_obj + "docs"
puts "CWD = \n  #{cwd_pn_obj}"
puts "\nDOCS FOLDER= \n  #{docs_dir_pn_obj}"
################################################################################


################################################################################
# cd into tags tags url and listing of tags
Dir.chdir(tags_dir_pn_obj) do
  @tags_url  = get_wc_url_fn
  puts "\nThe tags url is:\n  #{@tags_url}"
  @tags_array = `svn list #{@tags_url}`.gsub("/","").split(/\n/)
end                                
################################################################################


################################################################################
# 
Dir.chdir(docs_dir_pn_obj) do
  @docs_url  = %x[svn info | gawk "/^URL: / { print $2 }"].chomp
  puts "\nThe docs url is:\n  #{@docs_url}"
  @docs_array = `svn list #{@docs_url}`.gsub("/","").split(/\n/)
end                                
################################################################################


################################################################################
puts "\nThese are the docs items I found in SVN 
  #{@docs_array}\n"
################################################################################

################################################################################
puts "\nThese are the tags I found in SVN 
  #{@tags_array}\n"
################################################################################


################################################################################
print "Choose a tag to release, RET will sort and choose the last\n:"
#
temp_to_release = gets.chop

if temp_to_release == ""
  #puts "reached the true part"
  @tag_to_release  = @tags_array.sort.last
else
  @tag_to_release  = temp_to_release
  #puts "reached the else"
  puts "temp_to_release:\n#{temp_to_release}"
end
#
print "OK will release :#{@tag_to_release.inspect} 
  Are you sure q-RET to quit, RET-anything else to continue\n:"
#
if gets.chomp =="q"
  puts "Aborting"
  abort
end
################################################################################


################################################################################
# changing dir in a block is temporary,the old cwd is restored when block exits.
tags_selected_for_rel_dir_pn_obj = tags_dir_pn_obj + @tag_to_release
@tag_selected_for_rel_url = @tags_url + "/" + @tag_to_release
#
puts "tags_selected_for_rel_url : 
  #{@tag_selected_for_rel_url}"
#
@selected_tag_listing_array_url_based =                    #match fwd slash at eol
  `svn list #{@tag_selected_for_rel_url} -R`.gsub(/\/$/,"").split(/\n/)
#
#why does puts make a mess of this?
#puts "selected_tags_listing_array: #{@selected_tag_listing_array_url_based}"
#
#there are a lot, they clog the display
#
if LIST_ALL_PATHS_FOUND_IN_SVN_VERBOSE
  @selected_tag_listing_array_url_based.each do |x|
    print "#{x}\n"
  end
end
#
@tag_to_release_wo_rev_prefix = @tag_to_release.gsub(/rev_|rev/,"").split(/\n/).join
print "\nrev wo the rev_ prefix:
  #{@tag_to_release_wo_rev_prefix}\n"
################################################################################


################################################################################
selected_pdf_file_url_based = 
  match_arrary_to_file_type_fn(@docs_array, 
    @tag_to_release_wo_rev_prefix,
      /.pdf/)
puts "*** @tag_to_release_wo_rev_prefix \n  #{@tag_to_release_wo_rev_prefix}"
puts "*** @docs_array \n  #{@docs_array}"
puts "*** selected_pdf_file_url_based \n  #{selected_pdf_file_url_based}"

#
selected_tag_array_bit_files_url_based = 
  match_arrary_to_file_type_fn(@selected_tag_listing_array_url_based, 
    @tag_to_release_wo_rev_prefix,
      /.bit/)


#
#puts "**@selected_tag_listing_array_url_based \n  #{@selected_tag_listing_array_url_based}"
#puts "**@tag_to_release_wo_rev_prefix \n  #{@tag_to_release_wo_rev_prefix}"
#
selected_tag_array_zip_files_url_based =
  match_arrary_to_file_type_fn(@selected_tag_listing_array_url_based, 
    @tag_to_release_wo_rev_prefix,
      /.*.zip.*/,
      "tmru_top")


#puts "***selected_tag_array_zip_files_url_based \n  #{selected_tag_array_zip_files_url_based}"
################################################################################


################################################################################
#one or the other
# unless selected_tag_array_bit_files_url_based.length == 0
unless selected_tag_array_bit_files_url_based.length == 0
  puts "\nThe .bit matches are:\n  #{selected_tag_array_bit_files_url_based}"
  #below does not mean much
  #puts "Length of the .bit matches: #{selected_tag_array_bit_files_url_based.length}"
  #
  url_of_file_to_co_for_release = 
  url_of_co_file_for_rel_fn(@tag_selected_for_rel_url, selected_tag_array_bit_files_url_based)
#
end
#
unless selected_tag_array_zip_files_url_based.length == 0
  puts "\n.zip matches are:\n  #{selected_tag_array_zip_files_url_based}"
  #below does not mean much  
  #puts "Length of the .zip matches are: #{selected_tag_array_zip_files_url_based.length}"
  #
  url_of_file_to_co_for_release = 
  url_of_co_file_for_rel_fn(@tag_selected_for_rel_url, selected_tag_array_zip_files_url_based)  
end
#
#unless selected_tag_array_zip_files_url_based.length == 0
  if selected_pdf_file_url_based.length != 0
    puts "\n.pdf matches are:\n  #{selected_pdf_file_url_based}"
    pdf_file_present = true
  end
  #below does not mean much  
  #puts "Length of the .zip matches are: #{selected_tag_array_zip_files_url_based.length}"
  #
  url_of_docs_file_to_co_for_release = 
  url_of_co_file_for_rel_fn(@docs_url, selected_pdf_file_url_based)  
  
puts "pdf_file_present #{pdf_file_present}"
puts "as a temp test docs url #{@docs_url}"
puts "as a temp test selected_pdf_file_url_based #{selected_pdf_file_url_based}"
puts "as a temp test #{url_of_docs_file_to_co_for_release}"
#end
################################################################################


################################################################################
puts "\nURL of the file to co and later release:
  #{url_of_file_to_co_for_release}"
################################################################################


################################################################################
new_temp_dir_rel_path_pn_obj = Pathname.new("./temp")
begin
  new_temp_dir_rel_path_pn_obj.mkdir
rescue
 puts "\n--TRIED TO CREATE DIR THAN ALREADY EXITS, PROBALY OK--"
 puts "--RUN rm -rf ./temp BEFORE RUNNIG THIS SCCIPT TO AVOID THIS MESSAGE--"
end
#
temp_dir_url_oriented_pn_obj = Pathname.new("#{url_of_file_to_co_for_release}")
temp_dir_wo_filename_pn_obj = temp_dir_url_oriented_pn_obj.dirname
file_in_temp_dir_just_filename_pn_obj = temp_dir_url_oriented_pn_obj.basename
#puts "temp_dir_wo_filename_pn_obj: #{temp_dir_wo_filename_pn_obj}"  
#
temp_dir_full_pn_obj = cwd_pn_obj + new_temp_dir_rel_path_pn_obj
################################################################################


################################################################################
new_temp_docs_dir_rel_path_pn_obj = Pathname.new("./temp_docs")
begin
  new_temp_docs_dir_rel_path_pn_obj.mkdir
rescue
 puts "\n--TRIED TO CREATE temp_docs DIR THAN ALREADY EXITS, PROBALY OK--"
 puts "--RUN rm -rf ./temp BEFORE RUNNIG THIS SCCIPT TO AVOID THIS MESSAGE--"
end
#
temp_docs_dir_url_oriented_pn_obj = Pathname.new("#{url_of_docs_file_to_co_for_release}")
file_in_temp_docs_dir_just_filename_pn_obj = temp_docs_dir_url_oriented_pn_obj.basename
#puts "temp_dir_wo_filename_pn_obj: #{temp_dir_wo_filename_pn_obj}"  
#
temp_docs_dir_full_pn_obj = cwd_pn_obj + new_temp_docs_dir_rel_path_pn_obj
puts "\nurl_of_docs_file_to_co_for_release\n  #{url_of_docs_file_to_co_for_release}"
puts "\ntemp_docs_dir_full_pn_obj\n  #{temp_docs_dir_full_pn_obj}"
################################################################################



################################################################################
#two args dir to change to, and url to co
#CO DESIGN FILES
if CO_FN_VERBOSE
  puts "\nLook at a couple of objects before calling def that does the co\n"
  puts "temp_dir_full_pn_obj\n:  #{temp_dir_full_pn_obj}"
  puts "temp_dir_url_oriented_pn_obj\n:  #{temp_dir_url_oriented_pn_obj}"
   
  print "RET to continue:"
  tempvar =gets.chop
end
#
cd_to_tempdir_and_co_fn(temp_dir_full_pn_obj, 
                       temp_dir_url_oriented_pn_obj,
                         PROCESS_ZIP,
                           "")
################################################################################


################################################################################
#two args dir to change to, and url to co
#CO DOCS FILES
if CO_FN_VERBOSE
  puts "\nLook at a couple of objects before calling def that does the co\n"
  puts "temp_docs_dir_full_pn_obj\n:  #{temp_docs_dir_full_pn_obj}"
  puts "temp_docs_dir_url_oriented_pn_obj\n:  #{temp_docs_dir_url_oriented_pn_obj}"
   
  print "RET to continue:"
  tempvar =gets.chop
  puts "@tag_to_release_wo_rev_prefix #{@tag_to_release_wo_rev_prefix.class}"
end
#
if pdf_file_present
  cd_to_tempdir_and_co_fn(temp_docs_dir_full_pn_obj, 
                         temp_docs_dir_url_oriented_pn_obj,
                           DONT_PROCESS_ZIP,
                             @tag_to_release_wo_rev_prefix + ".txt")
else
    puts "\n.Found no pdf file with a name matching the tag"  
end                           
################################################################################


#################################################################################
puts "\n----- END:PROMPT USER FOR TAG THEN CO FILES FOR RELEASE-----"
################################################################################# 
