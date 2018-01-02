#!/usr/bin/env ruby
require 'fileutils'

FileUtils.cp 'temp.txt', 'temp1.txt'





# ################################################################################
# #Defs
# #ref only reading the board names from svn now.
# #board_names = %w[ scrt2_va  scst2_va  ktcont  dpif  other]


# ################################################################################
# SURECOM_BASE_URL = "https://chivcs.tmriusa.com/svn/tmiller/proj/surecom/fpgas/"
# ################################################################################


# ################################################################################
# def print_names_for_selection(my_array)
#   #format them for my tastes
#   i = 0
#   #print "   "
#   my_array.each do|n|
#     print "  #{i}) #{n}  \n"
#     i = i+1
#   end
   
#    print "\n"
# end
# ################################################################################


#   @board_selection_header = <<-END.gsub(/^ {2}/, '')
#   ------ Checkout a Surecom design------
#   The FPGA's are organized by board name
#   First Enter a Surecom board name
#   Enter q to quit the script\n
#     Here are some choices:
#     ----------------------
#   END
  
#   @fpga_selection_header = <<-END.gsub(/^ {2}/, '')
#   ------ Select a Surecom design FPGA------
#   Enter q to quit the script\n
#     Here are some choices:
#     ----------------------
#   END


# ################################################################################
# def print_header(my_header)
#   puts my_header
# end   
# ################################################################################


# ################################################################################
# def select_from_array(header,board_names)
#   #Allow the user to enter a number as an index rather that typing the board name.
#   #match regex with string
#   #=~ returns an index of the match, otherwise nil
#   #
#   print header
#   #
#   board_index  = gets.chop
#   # print "The index is:#{board_index}\n"
#   # print "\n\n"
#   #
#   i = 0
#   if board_index == "q"
#     print "\nUser Requested Abort\n"
#     abort
#   #
#   elsif board_index =~ /[\d]+/
#     #print "board_index is a number\n"
#     #
#     board_names.each do|n|
#     #
#       if board_index == i.to_s
#         board_name = n
#         temp = board_name 
#         #http://stackoverflow.com/questions/1402757/how-to-break-out-from-a-ruby-block
#         # Return always causes the enclosing method to return, regardless of
#         # how deeply nested within blocks it is (except in the case of
#         # lambdas)
#         return board_name 
#         print "Inside if statement Board name: #{board_name}, n= #{n}\n"
#       end
#     #
#     # print "Outside if board_index = #{board_index} i= #{i} board name is #{board_name}\n"
#     i = i+1
#     end
#   else
#        board_name = board_index
#        temp = board_name 
#   end
# end
# ################################################################################


# ################################################################################
# #found this example to determine if numeric.don't know how to use it yet
# # class String
# #     def is_i?
# #        !!(self =~ /^[-+]?[0-9]+$/)
# #     end
# # end
# ################################################################################


# ################################################################################
# #Run this code
# #
# #need to get rid if the "/" character svn list adds to the end of folders
# #need to split bc the return value is not an array.


# #SELECT BOARD NAME
# surecom_board_array = `svn list #{SURECOM_BASE_URL}`.gsub("/","").split(/\n/)
# print_header(@board_selection_header)
# print_names_for_selection(surecom_board_array)
# board_name = select_from_array("Board Name:",surecom_board_array)
# print "User selected:#{board_name}\n\n"


# #SELECT FPGA NAME
# surecom_fpga_array = `svn list #{SURECOM_BASE_URL+board_name+"/"}`.gsub("/","").split(/\n/)
# print_header(@fpga_selection_header)
# print_names_for_selection(surecom_fpga_array)
# fpga_name = select_from_array("FPGA Name:",surecom_fpga_array)
# print "User selected:#{fpga_name}\n\n"


# # url_lhs     = "https://vcs/svn/tmiller/proj/surecom/fpgas/"
# # url_sub_tot = url_lhs + url_board + "/" + url_fpga_name
# # url_tot     = url_sub_tot + "\/#{branches_tag_trunk}"
# url_tot     = SURECOM_BASE_URL.chomp("/") + "\/#{board_name}" + "\/#{fpga_name}"


# print "this is the total url"
# print "  #{url_tot}\n"


# # url_middle = gets.chop

# # url_begin ="https://subversion.assembla.com/svn/mtf_assembla_url/trunk/mfitzgerald/AppData/"
# # url_end   ="/mybin"

# # #concatination
# # my_url    =url_begin + url_middle + url_end

# # # use interpolation to include the variable in the string.
# # system("svn co #{my_url}")


# #Notes on copying files 
# # http://ruby-doc.org/stdlib-1.9.3/libdoc/fileutils/rdoc/FileUtils.html
# # http://stackoverflow.com/questions/5020710/copy-a-file-creating-directories-as-necessary-in-ruby
