#!/usr/bin/env ruby
require 'pathname'


if ARGV[1]
  pn_new = Pathname.new(ARGV[1])
  my_extension_to_search_for = '*' + pn_new.extname
  puts "The ext to search for is  #{my_extension_to_search_for}"
end


puts Pathname.new("./").find { |temp|  
  if temp.to_s.include? "test.rb"
     puts "String includes 'test.rb'"
  end
 }
