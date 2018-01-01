#!/usr/bin/env ruby
#Don't show all the non adds's when running svn status
case ARGV[0]
when '-u'
  blah=system("svn status -u |grep -v ^[[:space:]]*?")
when '-v'
  blah=system("svn status -v |grep -v ^[[:space:]]*?")
else
  blah=system("svn status |grep -v ^[[:space:]]*?")
end
