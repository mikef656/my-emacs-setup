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
puts "----- WELCOME TO THE VHDL HELPER SCRIPT -----"
#################################################################################


################################################################################
local_dir_pn_obj = Pathname.getwd.basename
print  "Local dir name: ", local_dir_pn_obj, "\n"
################################################################################


################################################################################
# Assume these are run from the fpga design name folder which has 
# branches, tags, trunk, docs under it.  Could add some error checking
# or auto find as an advanced feature
#
#find the newest folder under the tags folder
vhdl_files_pn_obj = Pathname.glob("./*.vhd")
#
#
unless vhdl_files_pn_obj
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

