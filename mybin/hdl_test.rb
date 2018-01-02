#!/usr/bin/env ruby

################################################################################
# This class-module-lib is needed by the FileUtils.cp_r() method.
require 'fileutils'
#
#This pathname class-module-lib replaces several File and Dir class-modules
#and provides nicer methods for accesing and manipulating paths
require 'pathname'
#
################################################################################

# FULLPATH = true
FULLPATH = false


################################################################################
#list .vhd files recursively
#fullpath
if FULLPATH
  Pathname.glob("**/*.vhd").each do  
    |filename_parpath| puts filename_parpath.realpath 
    end
end
#
#parpath
unless FULLPATH
  Pathname.glob("**/*.vhd").each do  
    |filename_parpath| puts filename_parpath
    end
end
################################################################################


################################################################################
# stackoverflow.com/
# questions/1727217/file-open-open-and-io-foreach-in-ruby-what-is-the-difference
#IO.foreach("file") { |line| puts line }
  #IO.foreach opens a file calls the given block for each line it reads and 
  #closes the file afterwards.
  #You don't have to worry about closing the file.
#
#File.read("file").each { |line| puts line }
  #File.read reads a file completely and returns it as a string.
  #You don't have to worry about closing the file.
  #In comparison to IO.foreach this makes it clear, that you are dealing with a file.
  #Them memory complexity for this is O(n). If you know you are dealing with a 
  #small file, this is no drawback. But if it can be a big file and you know your 
  #memory complexity can be smaller than O(n), don't use this choice.
################################################################################


################################################################################
#pathname doc
  #pn
  #pn.each_line { |line| _ }
  #regular Ruby
  #File.foreach(pn) { |line| _ }
################################################################################


################################################################################
# stackoverflow.com/questions/
#  1274605/ruby-search-file-text-for-a-pattern-and-replace-it-with-a-given-value
#Here's a solution for find/replace in all files of a given directory. 
#Basically I took the answer provided by sepp2k and expanded it.
 
## First set the files to search/replace in
#files = Dir.glob("/PATH/*")
 
## Then set the variables for find/replace
#@original_string_or_regex = /REGEX/
#@replacement_string = "STRING"
 
#files.each do |file_name|
#  text = File.read(file_name)
#  replace = text.gsub!(@original_string_or_regex, @replacement_string)
#  File.open(file_name, "w") { |file| file.puts replace }
#end
################################################################################


################################################################################
lines = File.readlines('./ptst_short.par')
matches = lines.collect { |line| line.match(/(first_param)\s*(\d+)/) }
################################################################################


