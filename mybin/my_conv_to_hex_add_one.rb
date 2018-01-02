#!/usr/bin/env ruby
#
################################################################################
#Take a string from std_in, find numbers in it and convert those numbers to hex
#This can be used to convert a whole file to hex 
# at the prompt like this my_conv_to_hex.rb < some_file.txt
# or
#Can be used to convert a region using emacs shell-command-on-region
#Recall than C-u shell-command-on-region replaces text in an emacs buffer
################################################################################
VERBOSE = false

if VERBOSE
  puts "\n","begin"
end
################################################################################


################################################################################
#one liner
puts ARGF.read.gsub(/\d+/) { |match| 

  temp = match.to_i + 1
  sprintf("%04X", temp) 
}
################################################################################


################################################################################
if VERBOSE
  puts "done"
end
################################################################################


################################################################################
#this shows an example of using shell-command-on-region in a lisp program
# (defun tidy-html ()
#   "Tidies the HTML content in the buffer using `tidy'"
#   (interactive)
#   (shell-command-on-region
#    ;; beginning and end of buffer
#    (point-min)
#    (point-max)
#    ;; command and parameters
#    "tidy -i -w 120 -q"
#    ;; output buffer
#    (current-buffer)
#    ;; replace?
#    t
#    ;; name of the error buffer
#    "*Tidy Error Buffer*"
#    ;; show error buffer?
#    t))
################################################################################


################################################################################
#below here are other ways to process data from std_in using Ruby
################################################################################
#
# STDIN.read.split("\n").each do |a|
#    puts a.inspect
# end

# ARGF.read.split("\n").each do |a|
#    puts a.inspect
# end

#simplest of all
#puts ARGF.read

# ARGF.each { | line |
#   # puts ("%x" % line)
#   #puts ( line)
#   puts sprintf("%02X", line)
# }



# ARGF.each_with_index do |line, idx|
#     print ARGF.filename, ":", idx, ";", line
# end

# ARGF.each_with_index do |line, idx|
#     print line
# end
