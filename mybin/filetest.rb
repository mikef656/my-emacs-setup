#good example of how to read from a file into an array, and remove the /n 
# and remove any other unwanted characters (this on gets rid of the #x in hex numbres)
#http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/158212
#contents of the test file
# 0x1234
# 0x5678
# 9ABC
first_lines = File.readlines('./my_file.txt').each { |x| x.chomp!.gsub!(/^0x/,'')}
puts first_lines.inspect
