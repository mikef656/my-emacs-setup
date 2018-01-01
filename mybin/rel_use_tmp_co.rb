#!/usr/bin/env ruby
################################################################################
# usage:
# * From command window, cd to a wc (working copy) folder named for the fpga.
# * The expectation is that everything including the release report in in SVN.
# run the program rel_use_tmp_co.rb
#
# * Normal flow will prompt the user for the tag to release.
#
# * Normal flow will prompt the user if it's ok to check out from SVN to local
# dirs (it is OK, ie it is the expected method)
#
# This program will abort if it cant find an appropriately named release report
# in the tag.  For example if releasing tag rev_0101 there should be something
# like svst_release_report_rev_0101.pdf in the docs folder.
#
# Assume user started this script in the folder named for the FPGA.
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
# Tested with Ruby 1.93
# Currently not using any Gem's
################################################################################
#
################################################################################
# These notes may not be 100% up to date.
# pseudo code
# * Pre Activities
# ** CREATE WC
#
# * DISCOVER DESIGN FOLDER AND FILES IN THE CURRENT WORKING COPY
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
# * Possible helper tasks
# ** Auto generate the email text body, populating many fields.
# ** Auto populate the Word Release Report based on user input.
# ** Create tag
# ** Update M:working copy some dirs sparse
#
# * To do Next
# ** copy zip path to windows clipboard
# ** Create pre flow
# *** copy md5, url date user-name to logfile in ./design_name folder
# *** Create tag in SVN, standard message, no user prompts
# *** Annotate params to  logfile
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
# M: drive path for preparing the release zip file that gets emailed.
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
DO_COPY_TO_Q_STEP                  = true
COPY_TO_Q_ALLOW_OVERWRITE          = true
COPY_TO_M_ALLOW_OVERWRITE          = true
VERBOSE_M_DISCOVER_DOCS            = true
DO_COPY_DOCS_TO_M_ZIP_STEP         = true
DO_COPY_DESIGN_FILES_TO_M_ZIP_STEP = true
ZIP_FILE_OUTPUT_TO_SCREEN          = false
CREATE_ZIP_FILE_FOR_EMAIL          = true
USE_GAWK_TO_GET_SVN_INFO           = false
################################################################################


################################################################################
puts "\n----- WELCOME TO THE SURECOM RELEASE SCRIPT -----"
#################################################################################


#################################################################################
#
puts "Check files out of svn to new local temp dirs to be used for release?"
puts "  This would typically be yes (run)"
print "  RET to run, n to continue:"
#
if gets.chomp ==""
  #
  puts "\n----- REQUIRING\\EXECUTING co_for_rel.rb -----"
  #
  # here is where another file is run using require
  require_relative "co_for_rel.rb"
  #
  #puts "testing variable from other file in this one"
  puts "tag_to_release_wo_rev_prefix:\n  #{@tag_to_release_wo_rev_prefix}"
  #puts "pause here, RET to continue:"
  #
  #gets.chop
  #
end
#################################################################################


################################################################################
#
fpga_name_pn_obj = Pathname.getwd.basename
print  "FPGA_NAME: ", fpga_name_pn_obj, "\n"
################################################################################


################################################################################
# find release report to send, full relative path as a pn object
#Could add a check here to see that a *.pdf exists, otherwise abort.
begin
  #
  rel_rpt_file_path = 
    Pathname.glob("./temp_docs/*.pdf").max_by {|f| File.mtime(f)}
  puts "Release Report to send: #{rel_rpt_file_path.basename}"
  puts "Release Report to send file path: #{rel_rpt_file_path}"
  #
rescue
  puts "\n--DON'T SEE A RELEASE REPORT NAMED LIKE THE TAG YOU CHOOSE, ABORTING--"
  puts "  For example if the tag is:\n    rev_0101"
  puts "  Then the release report should be something like:"
  puts "    svst_release_report_rev_0101"
  abort
end
################################################################################


################################################################################
#find bit file to send, get it's full relative path as a pn obj
wc_bit_file_path=
  Pathname.glob("./temp/*.bit").
    max_by {|f| File.mtime(f)}
#
  begin
    puts "Bit File to send: #{wc_bit_file_path.basename}"
    puts "Bit File to send path: #{wc_bit_file_path}"
  rescue
    #note that not every file will have a .bit,so do not abort on missing bit
    puts "There is no bit file"
  end
################################################################################


################################################################################
#find ziped .ngc file to send for a netlist release,
# get it's full relative path as a pn obj
#
wc_ziped_netlist_file_path=
  Pathname.glob("./temp/*.zip").
    max_by {|f| File.mtime(f)}
#
  begin
    puts "Ziped netlist File to send: #{wc_ziped_netlist_file_path.basename}"
    puts "Ziped netlist File to send Path: #{wc_ziped_netlist_file_path}"
  rescue
    #Not every file will have a .ziped netlis,so do not abort on missing zip    
    puts "There is no ziped netlist file"
  end
################################################################################


################################################################################
#Assemble and create path to Q: drive
#
  release_name_path_piece = #this ends up as just a string
    "surecom_" + fpga_name_pn_obj.to_s + "_" + @tag_to_release.to_s
#
# surecom_svcont_rev03a07b                     #rev03a07b  
#
#functionally this becomes the dirertory name in the q drive releases area.
################################################################################
#
#
################################################################################
# here is what a couple of these things look like when they print:
#
#  Newest tag par path:
#    ./tags/rev03a07b/
#
#  newest_rev_dir_name_path_obj:
#    rev03a07b
#
#  Newest tag dirname:
#    rev03a07b
#
#  release_name_path_piece:
#    surecom_svcont_rev03a07b
#
# here is what a couple of these things look like when they print:
################################################################################
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
  when fpga_name_pn_obj.to_s.match(/ptst/)
    puts "Project:SURECOM_PROTEUS_RELEASE"
    zip_name= "surecom_proteus_release"
    project_name= "proteus"
  when fpga_name_pn_obj.to_s.match(/dpifpt/)
    puts "Project:SURECOM_PROTEUS_RELEASE"
    zip_name= "surecom_proteus_release"
    project_name= "proteus"
  when fpga_name_pn_obj.to_s.match(/ptrt/)
    puts 'Project:SURECOM_PROTEUS_RELEASE'
    zip_name= "surecom_proteus_release"
    project_name= "proteus"
  when fpga_name_pn_obj.to_s.match(/ecost/)
    puts 'surecom_ecotester_release'
    zip_name= "surecom_ecotester_release"
    project_name= "ecotester"
  when fpga_name_pn_obj.to_s.match(/ecort/)
    puts 'surecom_ecotester_release'
    zip_name= "surecom_ecotester_release"
    project_name= "ecotester"
  when fpga_name_pn_obj.to_s.match(/scst3/)
    puts 'Project:SURECOM3_RELEASE'
    zip_name= "surecom3_release"
    project_name= "surecom3"
  when fpga_name_pn_obj.to_s.match(/scrt3/)
    puts 'Project:SURECOM3_RELEASE'
    zip_name= "surecom3_release"
    project_name= "surecom3"
  when fpga_name_pn_obj.to_s.match(/hbst/)
    puts 'Project:HORUS_RELEASE'
    zip_name= "horus_release"
    project_name= "horus"
  when fpga_name_pn_obj.to_s.match(/hbcont/)
    puts 'Project:HORUS_RELEASE'
    zip_name= "horus_release"
    project_name= "horus"
  when fpga_name_pn_obj.to_s.match(/ktst/)
    puts 'Project:KUMATAKA_RELEASE'
    zip_name= "kumataka_release"
    project_name= "kumataka"
  when fpga_name_pn_obj.to_s.match(/svst/)
    puts 'Project:KUMATAKA_RELEASE'
    zip_name= "kumataka_release"
    project_name= "kumataka"
  when fpga_name_pn_obj.to_s.match(/svcont/)
    puts 'Project:KUMATAKA_RELEASE'
    zip_name= "kumataka_release"
    project_name= "kumataka"
  when fpga_name_pn_obj.to_s.match(/ktcont/)
    puts 'Project:KUMATAKA_RELEASE'
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
#Last dir name is 
#  - concatination of stuff
#  - string obj
custom_m_drive_path_piece_wdate = 
  # "surecom_" + "designname_" + newest_rev_dir_name_path_obj.to_s
  # "surecom_" + fpga_name_pn_obj.to_s + "_" + delivery_time.to_s
  "surecom_delivery_" + delivery_time.to_s
# 
#


unless project_name
  puts "there is no project name, need to add one to the case statement aborting"
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
  #
  unless wc_bit_file_path.nil? 
    FileUtils.cp_r(wc_bit_file_path, entire_path_to_q_rel_dir_pn_obj, 
      :remove_destination => COPY_TO_Q_ALLOW_OVERWRITE)
  end
  #
  unless wc_ziped_netlist_file_path.nil? 
    FileUtils.cp_r(wc_ziped_netlist_file_path, entire_path_to_q_rel_dir_pn_obj, 
      :remove_destination => COPY_TO_Q_ALLOW_OVERWRITE)
  end
  #
  FileUtils.cp_r(rel_rpt_file_path, entire_path_to_q_rel_dir_pn_obj, 
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
#discover newest RT led drawing file, get it's path as a pn obj
newest_rt_led_drawing_file_path=                                 #THIS GLOB IS BAD FIXME
  Pathname.glob("#{M_DRIVE_VHDL_FPGA_DESIGNS_SURECOM_SVN_DOCS_PATH}/*leds*rt*.vsd").
    max_by {|f| File.mtime(f)}.cleanpath
#
if VERBOSE_M_DISCOVER_DOCS
  puts "Newest RT LED Drawing File: #{newest_rt_led_drawing_file_path.basename}"
  puts "Newest RT LED Drawing File Full Path: #{newest_rt_led_drawing_file_path}"
end
################################################################################


################################################################################
#discover newest ST led drawing file, get it's path as a pn obj

#The name schtester causes problems whet lookind at the design name and trying
# to determine rt or st design,  Remove the string schtester from the design
#for this purpose.
fpga_name_striped = fpga_name_pn_obj.to_s.gsub("schtester",'')
fpga_name_striped_glob = "*leds*#{fpga_name_striped}*.vsd"
#
newest_st_led_drawing_file_path=                                   
  Pathname.glob("#{M_DRIVE_VHDL_FPGA_DESIGNS_SURECOM_SVN_DOCS_PATH}#{fpga_name_striped_glob}").
    max_by {|f| File.mtime(f)}.cleanpath
#
if VERBOSE_M_DISCOVER_DOCS
  puts "Newest ST LED Drawing File: #{newest_st_led_drawing_file_path.basename}"
  puts "Newest ST LED Drawing File Full Path: #{newest_st_led_drawing_file_path}"
end
################################################################################


################################################################################
# Copy documentation files to m drive to be zipped up and emailed.  
# Note the attribute to allow overwrite is true
# Setting the permission to false causes Ruby to err if the destination exists
#
if DO_COPY_DOCS_TO_M_ZIP_STEP


  if(fpga_name_pn_obj.to_s.match("st"))
  #puts "matched st"
    FileUtils.cp_r(newest_st_led_drawing_file_path, path_to_m_surecom_delivery_docs_pn_obj, 
      :remove_destination => COPY_TO_Q_ALLOW_OVERWRITE)
  end
  #
  #
  if(fpga_name_pn_obj.to_s.match("rt"))
  #puts "matched rt"
    FileUtils.cp_r(newest_rt_led_drawing_file_path, path_to_m_surecom_delivery_docs_pn_obj, 
      :remove_destination => COPY_TO_Q_ALLOW_OVERWRITE)
  end
  #
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
unless wc_bit_file_path.nil? 
  bit_file_md5 = Digest::MD5.file(wc_bit_file_path).hexdigest
    puts "The .bit file md5 is: #{bit_file_md5}"
end
#
unless wc_ziped_netlist_file_path.nil? 
  ziped_netlist_file_md5 = Digest::MD5.file(wc_ziped_netlist_file_path).hexdigest
    puts "The .bit file md5 is: #{ziped_netlist_file_md5}"
end
################################################################################


################################################################################
# Copy design files to a temp location on the m drive to be zipped up & emailed. 
# Note the attribute to allow overwrite is true
# Setting the permission to false causes Ruby to err if the destination exists
#

if DO_COPY_DESIGN_FILES_TO_M_ZIP_STEP
  #
  unless wc_bit_file_path.nil? 
    FileUtils.cp_r(wc_bit_file_path, path_to_m_surecom_delivery_rel_dir_pn_obj, 
      :remove_destination => COPY_TO_M_ALLOW_OVERWRITE)
  end
    #
  unless wc_ziped_netlist_file_path.nil? 
    FileUtils.cp_r(wc_ziped_netlist_file_path, path_to_m_surecom_delivery_rel_dir_pn_obj, 
      :remove_destination => COPY_TO_M_ALLOW_OVERWRITE)
  end
    #
  unless rel_rpt_file_path.nil? 
    FileUtils.cp_r(rel_rpt_file_path, path_to_m_surecom_delivery_rel_dir_pn_obj, 
      :remove_destination => COPY_TO_M_ALLOW_OVERWRITE)
  end
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
  path_to_zip_4_email_pn_obj = 
    path_to_m_surecom_zip_fpga_name_pn_obj + "#{zip_name}.zip"
  puts "\n","Windows path 2 zip 4 email:
  #{path_to_zip_4_email_pn_obj.to_s.gsub("\/","\\")}"
end
################################################################################


#################################################################################
# Get the URL and TAG revision for the release report
# Possible, change this to Ruby so the user does not need gawk
if USE_GAWK_TO_GET_SVN_INFO
  Dir.chdir(newest_tag_par_path_pn_obj) do
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
puts "----- END OF SURECOM RELEASE SCRIPT -----"
#################################################################################
