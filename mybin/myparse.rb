#!/usr/bin/env ruby
#best pattern matching tut
#http://pleac.sourceforge.net/pleac_ruby/patternmatching.html

contents = File.open('alr20_top_level.vhd', 'rb') { |f| f.read }
modified_contents = contents.gsub /\r\n?/, "\n"


port_map_re = /
              (           # start group entire port map
                ^\s*\w+:  # instance name, start group entire port map
                .*?       # space including newlines
                (\w+)     # module-entity name, a group
                .*?        
                \);\s*$   # end of port map close paren and semi, eol
               )          # end group entire port map group
              /xm
#note .*? is non greedy, otherwise multiple port maps are
# captured 
#greedy means "match as much as possible"
#non greedy means "match as little as possible"
# the selected answer here helped
# stackoverflow.com/questions/5239997/regex-how-to-match-multiple-lines
#test = modified_contents.scan /^\w+:.*?\);$/m
test = modified_contents.scan port_map_re


puts test[0]

