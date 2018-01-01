#!/usr/bin/env ruby

################################################################################
#http://technicalpickles.com/posts/parsing-csv-with-ruby/
# This blog post shows how to take a CSV and transform it into an array of
# hash where the keys are the 'headers' in the first row.
################################################################################


################################################################################
require 'csv'
################################################################################

body = "Test Name,Second Column\n q, r\n1,2\n\n,\nfoo,bar\n"

CSV::Converters[:blank_to_nil] = lambda do |field|
  field && field.empty? ? nil : field
end

CSV::Converters[:mystrip] = lambda do |field|
  field.strip
end


csv = CSV.new(body, 
              :headers           => true, 
              :skip_blanks       => true, 
              #:skip_lines       => true, 
              :header_converters => :symbol, 
              :converters        => [:all, :blank_to_nil,:mystrip]
              )

puts "Here is the array of hash"
p my_array_of_hash = csv.to_a.map {|row| row.to_hash }
puts "Here is the first hash"
puts my_array_of_hash[0][:test_name]


my_array_of_hash.each do |one_hash|
  #p one_hash[:test_name]
 if one_hash[:test_name]  =~ /q/
   puts "the test name that matches the regex is #{one_hash[:test_name]}"
   puts "its from the hash  #{one_hash}"
 end
end




# p my_array_of_hash
