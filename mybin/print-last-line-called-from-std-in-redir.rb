#!/usr/bin/env ruby
#call me like this 
# print-last-line-called-from-std-in-redir.rb *.vhd
# to print the last line of all the .vhd files in the cwd
ARGV.each do |file|
  puts IO.readlines(file).last
end
