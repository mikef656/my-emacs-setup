#!/usr/bin/env ruby
#Remove status ?

blah=system("svn status |grep  ^[[:space:]]*?")

require 'highline/import'
def yesno(prompt = 'Continue?', default = true)
  a = ''
  s = default ? '[Y/n]' : '[y/N]'
  d = default ? 'y' : 'n'
  until %w[y n].include? a
    a = ask("#{prompt} #{s} ") { |q| q.limit = 1; q.case = :downcase }
    a = d if a.length == 0
  end
  a == 'y'
end
 
a= yesno("Remove these non-versioned files?", true)

if a 
 system("svn status |grep ^[[:space:]]*?|xargs rm -rf")
 puts "OK removed them"
end
