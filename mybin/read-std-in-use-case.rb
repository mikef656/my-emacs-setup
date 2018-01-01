print "Enter your name: "
name = gets.chop
puts "\nHello #{name}"


case name
when "bob"
  puts "read bob"
when "mike"
  puts "read mike"
else
  puts 'nothing'
end
