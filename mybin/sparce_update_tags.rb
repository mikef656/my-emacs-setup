#!/usr/bin/env ruby

################################################################################
#Re-consider doing everything from a spacsly updated tag, its a pain to get one
# without getting a ton of files in the tag path.  
#For netlist release this wants to find the .ngc and the zipped .ngc. to get
# the md5 of both for the release report.
################################################################################


################################################################################
# usage:
# * From command window, cd to a wc (working copy) folder named for the fpga.
# So that folders branches tags trunk and docs are direct children of the cwd
# In this example it's the ptst dir
#
# /mydata/ptst_co_at_r896/
#  +-ptst/                  <-- START SCRIPT IN THIS DIR--<
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
# * The wc should contain
#   - .bit file in the /builds foler 
#     OR
#   - ziped .ngc netlist file in the par/deliverer folder
#
#  *The wc does NOT need to contain 
#    - Completed pdf release report in the /docs folder
#  #bc one of the main reasons for this file is to help create the rel rpt.
#
# For this to work well the tags foldor should be up to date so if the newest
# tag is ./tags/rev_0604 the rev_0604 folder should exist it the wc.
# Currently the script does not do a sparce update to get the wc to this state.
# Implicit in this is that the newest tag (the one you are releasing now) 
# is made!  So make the tag and update the wc before running this to help
# with the rel rpt.
#
# run the program rel.rb
#
# Tested with Ruby 1.93
# Currently not using any Gem's
################################################################################


################################################################################
# pseudo code
# * Pre Activities
# ** CREATE WC
# *** prompt user for project that exists in SVN, using board name, fpga name
# *** Create a sparse wc in the cwd containing:
# **** docs folder 
# **** tags\builds  
#
# * DISCOVER DESIGN FOLDER AND FILES IN THE CURRENT WORKING COPY
# ** Latest tags folder example board_name\fpga_name\tags
# ** Latest .bit file under  board_name\fpga_name\tags\builds\
# ** Latest .pdf under board_name\fpga_name\doc\
#
# * COPY DESIGN FOLDER AND DESIGN FILES TO Q DRIVE
# ** create directory Q:\TOSHIBA\FPGA_Releases\CT\SureCom\fpga_name  (if not exist)
# ** Create dir like surecom_fpga-name_rev-name
#
# * POSSIBLE COMMIT Q DRIVE FILES 
#  ** https://vcs/svn/fpga_asic/FPGA_Releases/CT/SureCom/
#
# * PREPARE ZIP FILE FOR RELEASE EMAIL
# ** Create  under M:\VHDL\fpga_designs\mfitzgerald\surcom_release_temp
# ** Create more folders for design and doc
# ** Copy .bit file and .pdf file to corresponding folders.
# ** Discover latest Mem map, System Drawing, Error Management Drawing
# ** Copy to this area
# ** Zip it up.
#
# * To do Next
# Cd to correct folder if user starts in the wrong one, (message and exit)
# ** Auto generate the email text body, populating many fields.
# ** Auto populate the Word Release Report based on user input.
# ** copy zip path to windows clipboard
# ** Create pre flow
# *** copy md5, url date user-name to logfile in ./design_name folder
# *** Create tag in SVN, standard message, no user prompts
# *** Annotate params to  logfile
# *** sparce SVN update wc docs folder and builds folder (use case m:drive)
# *** SVN update wc docs folder and builds folder (use case m:drive)
# *** Prompt user for reaseon for change, put in logfile.
# ** Create template for email and populate it with what the program knows.
# ** Add option for 7-zip use, rather that GNU zip.
# Consider using this or something like it for command line help
# http://highline.rubyforge.org/
################################################################################


################################################################################
# This class-module-lib is needed by the FileUtils.cp_r() method.
require 'fileutils'
#
#This pathname class-module-lib replaces several File and Dir class-modules
#and provides nicer methods for accesing and manipulating paths
require 'pathname'
#
#Need this class-modules-lib to calculate the md5.
require 'digest/md5'
#
# Some paths that are relatively constant but could change.
# Q: drive archive location, create new pathname object
Q_DRIVE_TOSHIBA_REL_CT_SURCOM_PATH = 
  Pathname.new 'q:/toshiba/fpga_releases/ct/surecom/'
#
# M: drive path for creating the release zip file that gets emailed.
M_DRIVE_VHDL_FPGA_DESIGNS_SURECOM_REL_ZIP_FILE_BUILD_PATH =
  Pathname.new 'm:/vhdl/fpga_designs/surecom/release_zip_file_build/'
#
# M: drive path that contains Surecom documentanion
M_DRIVE_VHDL_FPGA_DESIGNS_SURECOM_SVN_DOCS_PATH =
  Pathname.new 'm:/vhdl/fpga_designs/surecom/svn/docs/'
#
#Script options
EXTRA_DEBUG_Q                      = false
EXTRA_DEBUG_M                      = true
DO_COPY_TO_Q_STEP                  = false
COPY_TO_Q_ALLOW_OVERWRITE          = false
COPY_TO_M_ALLOW_OVERWRITE          = false
VERBOSE_M_DISCOVER_DOCS            = false
DO_COPY_DOCS_TO_M_ZIP_STEP         = false
DO_COPY_DESIGN_FILES_TO_M_ZIP_STEP = false
ZIP_FILE_OUTPUT_TO_SCREEN          = false
CREATE_ZIP_FILE_FOR_EMAIL          = false
USE_GAWK_TO_GET_SVN_INFO           = true
################################################################################


#################################################################################
puts "----- WELCOME TO THE SURECOM PRE RELEASE SCRIPT -----"
#################################################################################


################################################################################
fpga_name_pn_obj = Pathname.getwd.basename
print  "FPGA_NAME: ", fpga_name_pn_obj, "\n"
################################################################################


################################################################################
if Pathname.new("./tags").directory?
  puts "tags a dir"
else
  puts "does not exist try to svn update tags"
  %x[svn update --depth immediates tags]
end
#now the tags/ folder exists in the wc
################################################################################


################################################################################
# changing dir in a block is temporary,the old cwd is restored when block exits.
  Dir.chdir("./tags") do
    puts "then pwd is" ,Pathname.pwd
    %x[svn update --set-depth immediates]
  end
#now the wc has tags/
#                    rev_01/
#                    rev_02/
#                    rev_.../
#but you don't know which is the lasest yet
################################################################################


################################################################################
# Assume these are run from the fpga design name folder which has 
# branches, tags, trunk, docs under it.  Could add some error checking
# or auto find as an advanced feature
#
#find the newest folder under the tags folder
# the sort method works for hex
# so if the canditates look like
# rev_09, rev_0A, and rev_0F .sort will choose rev_0F as the last.
# experimented in irb to get to this conclusion.
newest_tag_path_pn_obj = 
  # Pathname.glob("./tags/*/").max_by {|f| File.mtime(f)}
  Pathname.glob("./tags/*/").sort.last
#
#
unless newest_tag_path_pn_obj
  puts "No tag found in the working copy, aborting"
  abort
end
#
# genericly as reference 
# newest_dir=Dir.glob("./*/").max_by {|f| File.mtime(f)}
newest_rev_dir_name_path_obj = newest_tag_path_pn_obj.basename
puts "Newest tag par path #{newest_tag_path_pn_obj}"
puts "Newest tag dirname  #{newest_tag_path_pn_obj.basename}"
################################################################################


################################################################################
# changing dir in a block is temporary,the old cwd is restored when block exits.
  Dir.chdir(newest_tag_path_pn_obj) do
    puts "the inside pwd is" ,Pathname.pwd
    #%x[svn update --set-depth immediates]
  end
#now the wc has tags/
#                    rev_01/
#                    rev_02/
#                    rev_.../
#but you don't know which is the lasest yet
################################################################################



# Release report may not exist yet
# ################################################################################
# # find the newest release report, full relative path as a pn object
# #Could add a check here to see that a *.pdf exists, otherwise Ruby errors out.
# newest_rel_rpt_file_path = 
#   Pathname.glob("./docs/*.pdf").max_by {|f| File.mtime(f)}
# puts "Newest Release Report: #{newest_rel_rpt_file_path.basename}"
# ################################################################################


################################################################################
#find newest bit file, get it's full relative path as a pn obj
newest_wc_bit_file_path=
  Pathname.glob("./tags/#{newest_rev_dir_name_path_obj}/builds/*.bit").
    max_by {|f| File.mtime(f)}
#
  begin
    puts "Newest Bit File: #{newest_wc_bit_file_path.basename}"
    puts "Newest Bit File Path: #{newest_wc_bit_file_path}"
  rescue
    puts "There is no bit file"
  end
################################################################################


################################################################################
#find newest .ngc netlist file, get it's full relative path as a pn obj
#
# the notation **/ makes the search recursive
# Ref madebydna.com/all/code/2010/09/23/
#       introduction-to-the-pathname-ruby-standard-library.html
newest_wc_ngc_file_path = 
  Pathname.glob("./trunk/**/*.ngc").max_by {|f| File.mtime(f)}
#
  begin
    puts "Newest .ngc File: #{newest_wc_ngc_file_path.basename}"
    puts "Newest .ngc File Path: #{newest_wc_ngc_file_path}"
  rescue
    puts "There is no .ngc file"
  end
################################################################################


################################################################################
#find newest zipped .ngc netlist file, get it's full relative path as a pn obj
#
# the notation **/ makes the search recursive
# Ref madebydna.com/all/code/2010/09/23/
#       introduction-to-the-pathname-ruby-standard-library.html
newest_wc_ziped_ngc_file_path = 
  Pathname.glob("./trunk/**/*.zip").max_by {|f| File.mtime(f)}
#
  begin
    puts "Newest ziped .ngc File: #{newest_wc_ziped_ngc_file_path.basename}"
    puts "Newest ziped .ngc File Path: #{newest_wc_ziped_ngc_file_path}"
  rescue
    puts "There is no ziped .ngc file"
  end
################################################################################


################################################################################
#Assemble and create path to Q: drive
#
#
#Last dir name is 
#  - concatination of stuff
#  - string object
release_name_path_piece = 
  # "surecom_" + "designname_" + newest_rev_dir_name_path_obj.to_s
  "surecom_" + fpga_name_pn_obj.to_s + "_" + newest_rev_dir_name_path_obj.to_s
# 
#
#some debug
if EXTRA_DEBUG_Q
  print "release_name_path_piece class is: "  , release_name_path_piece.class, "\n"
  print "release_name_path_piece is: "  , release_name_path_piece, "\n"
end
#
#
#put the whole q: drive path together, expect a pathname object
entire_path_to_q_rel_dir_pn_obj = 
  Q_DRIVE_TOSHIBA_REL_CT_SURCOM_PATH + fpga_name_pn_obj + release_name_path_piece
#
#
#Creates a full path, including intermediate directories that don't yet exist.
entire_path_to_q_rel_dir_pn_obj.mkpath
################################################################################


################################################################################
#Build a string with a nice name for the project, used in the zip file name.
# For example if the fpga is named ptst use the name "proteus" in the zip file.
case
  when fpga_name_pn_obj.to_s.match(/ptst/) ||
         fpga_name_pn_obj.to_s.match(/dpifpt/) ||
           fpga_name_pn_obj.to_s.match(/ptrt/) 
    puts "zip file will be named surecom_proteus_release"
    zip_name= "surecom_proteus_release"
    project_name= "proteus"
  when fpga_name_pn_obj.to_s.match(/ptrt/)
    puts 'surecom_proteus_release'
    zip_name= "surecom_proteus_release"
    project_name= "proteus"
  when fpga_name_pn_obj.to_s.match(/scst3/)
    puts 'surecom3_release'
    zip_name= "surecom3_release"
    project_name= "surecom3"
  when fpga_name_pn_obj.to_s.match(/scrt3/)
    puts 'surecom3_release'
    zip_name= "surecom3_release"
    project_name= "surecom3"
  when fpga_name_pn_obj.to_s.match(/hbst/)
    puts 'horus_release'
    zip_name= "horus_release"
    project_name= "horus"
  when fpga_name_pn_obj.to_s.match(/hbcont/)
    puts 'horus_release'
    zip_name= "horus_release"
    project_name= "horus"
  when fpga_name_pn_obj.to_s.match(/ktst/) ||
         fpga_name_pn_obj.to_s.match(/svst/) ||
           fpga_name_pn_obj.to_s.match(/svcont/) 
    puts 'kumataka_release'
    zip_name= "kumataka_release"
    project_name= "kumataka"
  when fpga_name_pn_obj.to_s.match(/ktcont/)
    puts 'kumataka_release'
    zip_name= "kumataka_release"
    project_name= "kumataka"
  else
    puts 'surecom_release'
end
#
################################################################################



################################################################################
#Assemble & create path to M:drive to be used to create and hold the zip email
#
#format time like for the surecom delivery dirs like 20130618
delivery_time= Time.now.strftime("%Y%m%d")



#
custom_m_drive_path_piece_wdate = "surecom_delivery_" + delivery_time.to_s


unless project_name
  puts "there is no project name, need to add one to the case stanement aborting"
  abort
end


path_to_m_surecom_delivery_pn_obj = 
  M_DRIVE_VHDL_FPGA_DESIGNS_SURECOM_REL_ZIP_FILE_BUILD_PATH + 
  # fpga_name_pn_obj + 
  project_name + 
  custom_m_drive_path_piece_wdate

#
# an example of how this might look 
#   'ptst/surecom_delivery_20130715/docs'
path_to_m_surecom_delivery_docs_pn_obj = 
  path_to_m_surecom_delivery_pn_obj + 
  "docs"
#
#
# Adding on the last piece, something like
#  Surecom_delivery_20130501\surecom_ptrt_rev0908
#                            ^--------here------^  
path_to_m_surecom_delivery_rel_dir_pn_obj = 
  path_to_m_surecom_delivery_pn_obj + 
  release_name_path_piece
#
#
#some debug
if EXTRA_DEBUG_M
  print "Custom m drv path piece\\w date: ",custom_m_drive_path_piece_wdate,"\n"
  print "Path 2 m surecom delivery: ",path_to_m_surecom_delivery_docs_pn_obj,"\n"
end
#
#Creates a full path, including intermediate directories that don't yet exist.
path_to_m_surecom_delivery_docs_pn_obj.mkpath
path_to_m_surecom_delivery_rel_dir_pn_obj.mkpath
################################################################################


################################################################################
# Copy design files to q drive.  Note the attribute to allow overwrite is true
# Setting the permission to false causes Ruby to error if the destination exists
#
if DO_COPY_TO_Q_STEP
  FileUtils.cp_r(newest_wc_bit_file_path, entire_path_to_q_rel_dir_pn_obj, 
    :remove_destination => COPY_TO_Q_ALLOW_OVERWRITE)
  #
  #
  FileUtils.cp_r(newest_rel_rpt_file_path, entire_path_to_q_rel_dir_pn_obj, 
    :remove_destination => COPY_TO_Q_ALLOW_OVERWRITE)
end    
################################################################################


################################################################################
#discover newest memory map file, get it's path as a pn obj
newest_mem_map_file_path=
  Pathname.glob("#{M_DRIVE_VHDL_FPGA_DESIGNS_SURECOM_SVN_DOCS_PATH}/*map*.xls").
    max_by {|f| File.mtime(f)}.cleanpath
#
if VERBOSE_M_DISCOVER_DOCS
  puts "Newest Mem Map: #{newest_mem_map_file_path.basename}"
  puts "Newest Mem Map Full Path: #{newest_mem_map_file_path}"
end  
################################################################################


################################################################################
#discover newest error management file, get it's path as a pn obj
newest_err_mgt_file_path=
  Pathname.glob("#{M_DRIVE_VHDL_FPGA_DESIGNS_SURECOM_SVN_DOCS_PATH}/*error*.xls").
    max_by {|f| File.mtime(f)}.cleanpath
#
if VERBOSE_M_DISCOVER_DOCS
  puts "Newest Err Management File: #{newest_err_mgt_file_path.basename}"
  puts "Newest Err Management File Full Path: #{newest_err_mgt_file_path}"
end
################################################################################


################################################################################
#discover newest system drawing file, get it's path as a pn obj
newest_sys_drawing_file_path=
  Pathname.glob("#{M_DRIVE_VHDL_FPGA_DESIGNS_SURECOM_SVN_DOCS_PATH}/*system*.vsd").
    max_by {|f| File.mtime(f)}.cleanpath
#
if VERBOSE_M_DISCOVER_DOCS
  puts "Newest System Drawing File: #{newest_sys_drawing_file_path.basename}"
  puts "Newest System Drawing File Full Path: #{newest_sys_drawing_file_path}"
end
################################################################################


################################################################################
# Copy documentation files to m drive to be zipped up and emailed.  
# Note the attribute to allow overwrite is true
# Setting the permission to false causes Ruby to err if the destination exists
#
if DO_COPY_DOCS_TO_M_ZIP_STEP
  FileUtils.cp_r(newest_mem_map_file_path, path_to_m_surecom_delivery_docs_pn_obj, 
    :remove_destination => COPY_TO_Q_ALLOW_OVERWRITE)
  #
  #
  FileUtils.cp_r(newest_sys_drawing_file_path, path_to_m_surecom_delivery_docs_pn_obj, 
    :remove_destination => COPY_TO_Q_ALLOW_OVERWRITE)
  #
  #
  FileUtils.cp_r(newest_err_mgt_file_path, path_to_m_surecom_delivery_docs_pn_obj, 
    :remove_destination => COPY_TO_Q_ALLOW_OVERWRITE)
end    
################################################################################


################################################################################
  begin
    bit_file_md5 = Digest::MD5.file(newest_wc_bit_file_path).hexdigest
    puts "The .bit file md5 is: #{bit_file_md5}"
  rescue
    puts "Looks like there is no bit file to get the md5 of"
  end
################################################################################


################################################################################
  begin
    ncg_file_md5 = Digest::MD5.file(newest_wc_ngc_file_path).hexdigest
    puts "The .ngc file md5 is: #{ncg_file_md5}"
  rescue
    puts "Looks like there is no .ngc file to get the md5 of"
  end
################################################################################


################################################################################
  begin
    ziped_ncg_file_md5 = Digest::MD5.file(newest_wc_ziped_ngc_file_path).hexdigest
    puts "The ziped .ngc file md5 is: #{ziped_ncg_file_md5}"
  rescue
    puts "Looks like there is no ziped .ngc file to get the md5 of"
  end
################################################################################


################################################################################
# Copy design files to a junk location on the m drive to be zipped up & emailed. 
# Note the attribute to allow overwrite is true
# Setting the permission to false causes Ruby to err if the destination exists
#
if DO_COPY_DESIGN_FILES_TO_M_ZIP_STEP
  FileUtils.cp_r(newest_wc_bit_file_path, path_to_m_surecom_delivery_rel_dir_pn_obj, 
    :remove_destination => COPY_TO_M_ALLOW_OVERWRITE)
  #
  #
  FileUtils.cp_r(newest_rel_rpt_file_path, path_to_m_surecom_delivery_rel_dir_pn_obj, 
    :remove_destination => COPY_TO_M_ALLOW_OVERWRITE)
end    
################################################################################


################################################################################
# MAKE THE ZIP TO BE USED IN AN EMAIL
path_to_m_surecom_zip_fpga_name_pn_obj = 
  M_DRIVE_VHDL_FPGA_DESIGNS_SURECOM_REL_ZIP_FILE_BUILD_PATH + project_name
#
################################################################################


################################################################################
# changing dir in a block is temporary,the old cwd is restored when block exits.
if CREATE_ZIP_FILE_FOR_EMAIL
  Dir.chdir(path_to_m_surecom_zip_fpga_name_pn_obj) do
    # %x[zip -r temp.zip #{release_name_path_piece}]
    puts "Creating zip file for email"
    output = %x[zip -r #{zip_name}.zip #{custom_m_drive_path_piece_wdate}]
    
    
    #get the .zip file md5 
    #  looking later 9-11, don't think the md5 of the zip file is needed for
    #  a normal (non-netlist) release.
    zip_file_md5 = Digest::MD5.file(zip_name +".zip").hexdigest
    puts "The zip file md5 is: #{zip_file_md5}"
    #
    if ZIP_FILE_OUTPUT_TO_SCREEN
      puts output
    end
  end                                
  #
  # Create a windows style path to be used when creating email's
  path_to_zip_4_email_pn_obj = path_to_m_surecom_zip_fpga_name_pn_obj + "#{zip_name}.zip"
  puts "\n","Windows path to zip: #{path_to_zip_4_email_pn_obj.to_s.gsub("\/","\\")}"
end
################################################################################


#################################################################################
# Get the URL and TAG revision for the release report
# Possible, change this to Ruby so the user does not need gawk
if USE_GAWK_TO_GET_SVN_INFO
  Dir.chdir(newest_tag_path_pn_obj) do
    wc_url  = %x[svn info | gawk "/^URL: / { print $2 }"]
    tag_rev = %x[svn info | gawk "/^Revision: / { print $2 }"]
    puts "TAG URL: #{wc_url}"
    puts "TAG Revision: #{tag_rev}"
  end                                
end
#################################################################################


#################################################################################
#logfile helper.
# might want to save a log file to the \docs folder to help create rel rpt's.
#File.open(yourfile, 'w') { |file| file.write("your text") }
#################################################################################


#################################################################################
puts "----- END OF RUBY PRE RELEASE SCRIPT -----"
#################################################################################
