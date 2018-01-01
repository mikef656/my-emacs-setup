#!/usr/bin/env ruby
# PRINT THE NEWEST DIR IN THE CURRENT FOLDER.

# How to do it with Dir
# Dir object created
newest_rev_path_dir_obj      = Dir.glob("./tags/*/").max_by {|f| File.mtime(f)}

# How to do it with Pathname
# Pathname object created
newest_rev_path_pathname_obj = Pathname.glob("./tags/*/").max_by {|f| File.mtime(f)}


# Here the File.split method looks procedural
newest_rev_dir_name_dir_obj  = File.split(newest_rev_path_dir_obj).last

# With the Pathname lib-class-module, the Ruby pipeline is strictly L-R (easier to read)
newest_rev_dir_name_path_obj = newest_rev_path_pathname_obj.split.last

# With the Pathname lib-class-module,can get even cleaner .split.last is replaced with .basename 
newest_rev_dir_name_path_obj = newest_rev_path_pathname_obj.basename


#
puts "Newest Rev Path Dir Obj:      #{newest_rev_path_dir_obj}"
puts "Newest Rev Path Pathname Obj: #{newest_rev_path_dir_obj}"


puts "Newest Rev Path Name Dir Obj:      #{newest_rev_dir_name_dir_obj}"
puts "Newest Rev Path Name Pathname Obj: #{newest_rev_dir_name_path_obj}"
