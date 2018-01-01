################################################################################
# The purpose of this design is to take a file received from TMRU, representing
# ADC pattern data containing * (don't check) and transform it to something
# to be compared to an RTL models output by substinuting EE pattern for the *'s
# Also note the adjustment in the first batch of stars that has the view num
# in the middle of it.  The RTL model we have for comparision does not create
# row num, and the checker does not check it.  Therefore for this effort put
# in EE pattern.
################################################################################

################################################################################
#files
input_text = File.read('c:/Users/mfitzgerald/desktop/c-surecom/Proteus_test_patterns/temp_new/adc_3views_1col.txt')
output_text = 'c:/Users/mfitzgerald/desktop/c-surecom/Proteus_test_patterns/temp_new/adc_3views_1col_sub.txt'
################################################################################


################################################################################
#patterns
srch_ee0_ee11_regex =/\*\n\*\n\*\n\*\n\*\n\d*\n\d*\n\*\n\*\n\*\n\*\n\*\n/
rplc_ee0_ee11_str = "EE00\nEE01\nEE02\nEE03\nEE04\nEE05\nEE06\nEE07\nEE08\nEE09\nEE10\nEE11\n"
#
srch_ee16_ee27_regex =/\*\n\*\n\*\n\*\n\*\n\*\n\*\n\*\n\*\n\*\n\*\n\*\n/
rplc_ee16_ee27_str = "EE16\nEE17\nEE18\nEE19\nEE20\nEE21\nEE22\nEE23\nEE24\nEE25\nEE26\nEE27\n"
#
srch_ee29_ee34_regex =/\*\n\*\n\*\n\*\n\*\n\*\n/
rplc_ee29_ee34_str = "EE29\nEE30\nEE31\nEE32\nEE33\nEE34\n"
#
srch_ee36_ee39_regex =/\*\n\*\n\*\n\*\n/
rplc_ee36_ee39_str = "EE36\nEE37\nEE38\nEE39\n"
################################################################################


################################################################################
#Substitutions
# result = sub1(xxx).sub2(xxx).sub3(xxx).sub4(xxx)
result_newtext = input_text
  .gsub(srch_ee0_ee11_regex,rplc_ee0_ee11_str)
  .gsub(srch_ee16_ee27_regex,rplc_ee16_ee27_str)
  .gsub(srch_ee29_ee34_regex,rplc_ee29_ee34_str)
  .gsub(srch_ee36_ee39_regex,rplc_ee36_ee39_str)
################################################################################
#

################################################################################
#printing
newfile_array = result_newtext.split
#
newfile_array[0..45].each_with_index {|x,i| print i+1,": ",x,"\n"}
#
################################################################################


################################################################################
# WRITE TO FILE
#Both class methods open and readlines belong to the IO class, whose sub-class
#is File.these two methods are inherited by the sub-class File from the class IO.
#Note 
#  There is more comprenensive doc in the IO class.
#  The block is not necessary, but it closes the file handle automatically
#
#Two ways
# -Write an array to a file
# -Write a string to a file
#
USE_ARRAY_TO_WRITE = false
#
if USE_ARRAY_TO_WRITE
  File.open(output_text, "w+") do |f| 
    newfile_array.each { |element| f.puts(element) } 
  end
else
  File.open(output_text, "w+") do |f| 
    f.puts result_newtext 
  end
end
################################################################################
