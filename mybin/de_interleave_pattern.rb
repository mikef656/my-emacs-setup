#!/usr/bin/env ruby

################################################################################
#This design takes input from 4 text files that represend the output of an
#RTL pattern generator and recombines them into one file.  The original purpose
#is to compare simulation results to those sent by TMSC in spreadsheets.
#
#The pattern used to re-construct the entire view is to ping pong between the 
#first two for the first half of views then ping pong between the third and 
#fourth for the 2nd half views.
#
#The design indirectly supports the das and adc patterns and a short test pattern
#by changing the var SELECT_IN_FILES.
################################################################################

###############################################################################
#params
VERBOSE_DEBUG = TRUE

#selections are
# small_hex
# das
# adc
SELECT_IN_FILES = "adc"
################################################################################

################################################################################
#params
VERBOSE_DEBUG = TRUE

#selections are
# small_hex
# das
# adc
SELECT_IN_FILES = "adc"
################################################################################


################################################################################
#read in files
path_to_hdl_generated_files_for_das = 
  'm:/VHDL/fpga_designs/mfitzgerald/my_working_copies/ip/ddc/test_pattern/sim/das_160seg_4path/'
path_to_hdl_generated_files_for_adc = 
  'm:/VHDL/fpga_designs/mfitzgerald/my_working_copies/ip/ddc/test_pattern/sim/adc38_160seg_4path/'
#
case SELECT_IN_FILES
  #
  when "das"
    first_file  = path_to_hdl_generated_files_for_das + 'outfile1.txt'
    second_file = path_to_hdl_generated_files_for_das + 'outfile2.txt'
    third_file  = path_to_hdl_generated_files_for_das + 'outfile3.txt'
    fourth_file = path_to_hdl_generated_files_for_das + 'outfile4.txt'
    merge_result_file       = "merge_result_quadwords_das_pattern.txt"
    merge_result_words_file = "merge_result_words_das_pattern.txt"
    #
    NUM_VIEWS = 3
    NUM_QW      = 390
    NUM_ROWS    = 160
    WRITE_QW_RESULT_ARRAY_TO_STD_OUT = FALSE
  #
  when "adc"
    first_file  = path_to_hdl_generated_files_for_adc + 'outfile1.txt'
    second_file = path_to_hdl_generated_files_for_adc + 'outfile2.txt'
    third_file  = path_to_hdl_generated_files_for_adc + 'outfile3.txt'
    fourth_file = path_to_hdl_generated_files_for_adc + 'outfile4.txt'
    merge_result_file       = "merge_result_quadwords_adc_pattern.txt"
    merge_result_words_file = "merge_result_words_adc_pattern.txt"
    #
    NUM_VIEWS = 3
    NUM_QW      = 390
    NUM_ROWS    = 160
    WRITE_QW_RESULT_ARRAY_TO_STD_OUT = FALSE
  #
  when "small_hex"
    first_file  = './first_file_qw_hex.txt'
    second_file = './second_file_qw_hex.txt'
    third_file  = './third_file_qw_hex.txt'
    fourth_file = './fourth_file_qw_hex.txt'
    merge_result_file       = "merge_result_quadwords_small_pattern.txt"
    merge_result_words_file = "merge_result_words_small_pattern.txt"
    #
    NUM_VIEWS = 1
    NUM_QW      = 5
    NUM_ROWS    = 8
    WRITE_QW_RESULT_ARRAY_TO_STD_OUT = TRUE
end
#
#remove the leading 0x from hex data, remove trailing \n that you get
#when reading in files.
first_lines  = File.readlines(first_file).each  { |x| x.chomp!.gsub!(/^0x/,'')}
second_lines = File.readlines(second_file).each { |x| x.chomp!.gsub!(/^0x/,'')}
third_lines  = File.readlines(third_file).each  { |x| x.chomp!.gsub!(/^0x/,'')}
fourth_lines = File.readlines(fourth_file).each { |x| x.chomp!.gsub!(/^0x/,'')}
################################################################################


################################################################################
#declaricive
num_rows_top_bot = NUM_ROWS/2
@merge_result_array_qw = []
row_num = 1
@file1_pointer = @file2_pointer = @file3_pointer = @file4_pointer = 0
################################################################################


################################################################################
def extract_and_append_row(filename,index)
 puts "  entering file#{index} section"
 #
 (0..NUM_QW-1).to_a.each do |x| #var x is unused
    #
    case index
      when 1
        @merge_result_array_qw << filename[@file1_pointer]
        @file1_pointer += 1
        current_pointer_val = @file1_pointer
      when 2
        @merge_result_array_qw << filename[@file2_pointer]
        @file2_pointer += 1
        current_pointer_val = @file2_pointer
      when 3
        @merge_result_array_qw << filename[@file3_pointer]
        @file3_pointer += 1
        current_pointer_val = @file3_pointer
      when 4
        @merge_result_array_qw << filename[@file4_pointer]
        @file4_pointer += 1
        current_pointer_val = @file4_pointer
      end
    #
    if VERBOSE_DEBUG
      print "    Current row num:",@row_num, ", file", 
            index, "_pointer", current_pointer_val, "\n"
    end
    
    end
    #
    puts "  exiting file#{index} section",""
    #
end
################################################################################


################################################################################
def print_pointers
  print " " " pt1:",@file1_pointer, 
            " pt2:",@file2_pointer,
            " pt3: ",@file3_pointer,
            " pt4: ",@file4_pointer,"\n"
end      
################################################################################


################################################################################
def conv_qw_array_to_word_array(in_array)
  #stackoverflow.com/questions/
    #8282096/ruby-how-to-concatenate-array-of-arrays-into-one
  #@f = @b.flatten
  #
  local= in_array.collect { |x| x.to_s.scan(/..../).reverse }.flatten

  return local
end
################################################################################


################################################################################
#main loop
((1..NUM_ROWS).to_a*NUM_VIEWS).each do |local_row_num|
  #
  @row_num = local_row_num
  puts "--ROW_NUM IS #{@row_num} AT BEG OF OUTSIDE LOOP--"
    #
    if local_row_num.odd? && @row_num <= num_rows_top_bot
      print_pointers
      extract_and_append_row(first_lines,1)
    end
    #
    if local_row_num.even? && @row_num <= num_rows_top_bot
      print_pointers
      extract_and_append_row(second_lines,2)
    end
     #
    #
    if local_row_num.odd? && @row_num > num_rows_top_bot
      print_pointers
      extract_and_append_row(third_lines,3)
    end
    #
    if local_row_num.even? && @row_num > num_rows_top_bot
      print_pointers
      extract_and_append_row(fourth_lines,4)
    end
     #
#
end
################################################################################


################################################################################
#write to files
File.open(merge_result_file, "w+") do |f| 
  @merge_result_array_qw .each { |element| f.puts(element) } 
end
#
merge_result_array_words = conv_qw_array_to_word_array(@merge_result_array_qw)
File.open(merge_result_words_file, "w+") do |f|
  merge_result_array_words.each { |element| f.puts(element) }
end
################################################################################


################################################################################
#print to std_out
if WRITE_QW_RESULT_ARRAY_TO_STD_OUT
  puts "Quadword Result array #{@merge_result_array_qw}"
end
#
print "\n","Result array length words: "
puts "#{merge_result_array_words.count} qw: #{@merge_result_array_qw.count}" ,""
#
frst_lc            = first_lines.count
sc_lc              = second_lines.count
thrd_lc            = third_lines.count
frth_lc            = fourth_lines.count
infile_total_lines = frst_lc + sc_lc + thrd_lc + frth_lc
#
puts "First  in file len: #{frth_lc} lines"
puts "Second in file len: #{sc_lc} lines"
puts "Third  in file len: #{thrd_lc} lines"
puts "Fourth in file len: #{frth_lc} lines"
puts "Total  in file len: #{infile_total_lines} lines -> #{infile_total_lines*4} words"
################################################################################
