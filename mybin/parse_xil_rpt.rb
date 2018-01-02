# -*- coding: iso-8859-1 -*-
# Todo
# - Adapt for more than one file
#   .generically
#   .
# match method vs =~
# There's another method that you can use to match regexp\w strings: that's the
# =~ (the equals-tilde operator). Remember that operators are methods in
# Ruby. Like match, this method returns nil on no match. However, if theres
#
#match, it will return the numerical position of the string where the match
# started. Also like match, both strings and regexps have =~.


#perhaps use this:
#If a block is given, invoke the block with MatchData if match succeed, 
#so that you can write:
#  "abcde".match("^a(bc)") {|m| puts m[1]} #=> bc


#ff operator
#stackoverflow.com/questions/1111286/when-would-a-ruby-flip-flop-be-useful


lines = File.readlines('./ptst_short.par')
matches = lines.collect { |line| line.match(/(first_param)\s*(\d+)/) }
temp = matches[2]


# Reference:
#stackoverflow.com/
#  questions/1720932/create-two-dimensional-arrays-and-access-sub-arrays-in-ruby


@a = Array.new
@c = Array.new
util_lines = Array.new
@b = 0


def mypush(line_arg , start_col, index)
  A[[index,start_col]] = line_arg
end


A = Hash.new
#a[[1,2]]= 23
#a[[5,6]]= 42


#-------------------------------------------------------------------------------
# ONE TIME EVENTS
# just the lines of interest from original file, cleaned into an array
lines.each { |line| 
             if line[/Device Utilization Summary:/] .. line[/Number of STARTUPs/] 
               unless line =~ /^\n|^\r\n/ 
                 util_lines.push(line.chomp.strip) 
               end
             end
           }
#
#Push header into the first column of the hash, strip leading\trailing whtspc
util_lines.each_with_index { |line, index| 
               my_match = line.match /^(\s*[a-zA-Z]+)+/ 
                 mypush(my_match[0].strip, 0, index) 
                }
#-------------------------------------------------------------------------------


# util_lines.each { |line| 
util_lines.each_with_index { |line, index| 
               my_match = line.match /^(\s*[a-zA-Z:]+)+/ 
               mypush(my_match.post_match.strip, 1, index) 
                }


util_lines.each_with_index { |line, index| 
               my_match = line.match /^(\s*[a-zA-Z:]+)+/ 
               mypush(my_match.post_match.strip, 2, index) 
                }


C = [0].product((0..4).to_a).collect { |index| A[index] }
D = [0].product((0..4).to_a).collect { |index| A[index] }


require 'csv'


first_row  = [0].product((0..4).to_a).collect { |index| A[index] }
second_row = [1].product((0..4).to_a).collect { |index| A[index] }
third_row  = [2].product((0..4).to_a).collect { |index| A[index] }
fourth_row = [3].product((0..4).to_a).collect { |index| A[index] }


puts "nuber rows in A #{A.length}"
puts "nuber rows in util_lines is #{util_lines.length}"



#
#calculate the hash size parameters
max_index_col = 0
max_index_row = 0
#
  A.each {|key, value|
  # 
     if key[0].inspect.to_i > max_index_row
       max_index_row = key[0]
     end
  #  
     if key[1].inspect.to_i > max_index_col
       max_index_col = key[1]
     end
   #
   }


my_hash_size = 0..(max_index_row)
puts "my hash size is #{my_hash_size}"


CSV.open("file.csv", "wb") do |csv|
  #
  my_hash_size.each {|myindex|
  csv << [myindex].product((0..max_index_row).to_a).collect { |index| A[index] }
  #
  }
end


puts "Hash Number cols = #{max_index_col}"
puts "Hash Number rows = #{max_index_row}"
puts A.inspect
puts my_hash_size.inspect
