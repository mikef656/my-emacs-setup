#!/usr/bin/env ruby
#
################################################################################
# At the prompt like this my_conv_to_hex.rb < some_file.txt
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

# FORCE_IN_DOUBLE_QUOTES = true
FORCE_IN_DOUBLE_QUOTES = false


if FORCE_IN_DOUBLE_QUOTES
  my_regex = /\"[0-9a-fA-F]+\"/
else
  my_regex = /[0-9a-fA-F]+/
end


puts ARGF.read.gsub(my_regex) { |match| 
  temp = match.sub(/"/,"").to_i(16) + 1
  sprintf("\"%04X\"", temp) 
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
