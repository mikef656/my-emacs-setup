#!/usr/bin/env ruby
################################################################################
#PRINT SOME HEX NUMBERS
################################################################################

Number_of_rows = 190
Dec_width = 4
@start_index = 1

#Initialize array
Dec_arr_init_left  = 62620
Dec_arr_init_right = 62623
#
dec_arr = (Dec_arr_init_left..Dec_arr_init_right).to_a
dec_arr_rev = dec_arr.reverse



# note use x for lowercase hex, X for uppercase
Number_of_rows.times do 
  print "   x\"%0#{Dec_width}x%0#{Dec_width}x%0#{Dec_width}x%0#{Dec_width}x\", --#{@start_index} \n" % dec_arr_rev
  # 
  #http://www.tutorialspoint.com/ruby/ruby_arrays.htm 
  #the bang makes collect operate on the original object
  dec_arr = dec_arr.collect! {|x| x+4}
  dec_arr_rev = dec_arr.reverse
  @start_index = @start_index +1
  #
end


#ANOTHER WAY AND AN EXAMPLE OF A FOR LOOP
# startval = 1
# a =  startval
# b =  startval + 1
# c =  startval + 2
# d =  startval + 3
#  
#
# for i in 1..5
#   my_array = [a, b, c, d]
#   print "%04X%04X%04X%04X\n" % my_array
#   a = a + 4 
#   b = b + 4
#   c = c + 4 
#   d = d + 4
# end


