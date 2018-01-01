require 'fileutils'

#p Dir['*.rb'].sort_by{ |f| File.ctime(f) }.last(5) # 
dot_rb_files = Dir['*.rb'].sort_by{ |f| File.mtime(f) }.last(1) 
dot_pl_files = Dir['*.pl'].sort_by{ |f| File.mtime(f) }.last(1) 

my_files = [ dot_pl_files , dot_rb_files ].flatten
#p dot_rb_files                  # 
p my_files

FileUtils.cp my_files , "./junk"
#FileUtils.cp "myfiles.rb", "./junk"

inp = $stdin.read
puts inp
