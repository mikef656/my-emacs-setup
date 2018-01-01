################################################################################
# Starting at the pwd where invoked, walk down the dir tree pwd
# until an named dir (@expected_project_dir) is reached then
# run find on a specific extension re-directing find output to a named file.
#
# The named file will be used by other code as a project.
#

# find . \( -iname "*.el" -o -iname "*.vhd" -o -iname "*.do" -o -iname "*.tcl"   -o -iname "*.xdc"  \) -not -path "*/.Xil/*" -not -path "*/managed_ip_project/*" | grep -v -P dir-locals > .project_files.txt
################################################################################
require 'pathname'
################################################################################


################################################################################
# parameters
# @expected_project_dir= "Roaming"
@expected_project_dir= ".emacs.d"
@expected_project_dir2= "trunk"
VERBOSE = TRUE
################################################################################

@location_of_project_file = FALSE


if VERBOSE
  puts ""
end


# temp_path = Pathname.new("./").expand_path
# puts "the path is #{temp_path}"


Pathname.pwd.ascend {|pth|
  #
  if pth.basename.to_s.downcase.match(/.*#{@expected_project_dir.downcase}|#{@expected_project_dir2.downcase}/)
    #
    if VERBOSE
      puts " #{pth} MATCHES an expected dir"
    end
    #
    @location_of_project_file = pth
    #
    # get out of the loop
    break
    #
  end
  }

#
#################################################################################


#################################################################################
unless @location_of_project_file
;
@location_of_project_file = "./"
  if VERBOSE
    puts " No matching folder found for expected project dir names walking up the tree"
  end
end
##############################################################################
  

#################################################################################
if @location_of_project_file
# 
  if VERBOSE
    puts ""," #{@location_of_project_file} is the location of the project file",""
  end
  #
  Dir.chdir(@location_of_project_file) do
    if VERBOSE
      puts "HERE IS A LISTING OF THE FOLDER THAT CONTAINS THE PROJECT FILE"
    end

    my_file_list  = %x[ls -lrt|grep -P -v ^d|tail -5]
    
    #files
    # note that findme.sh was created because I could not get the %x find command to work in here
    # there seemed to be a problem with the shell not liking the \( and \) around the find.  Spent an hour
    # trying stuff, then moved it to it's own .sh and it works.  This is not a solution for windows.
    # Maybe check to see if windows or linux then do the right thing or put the find all in ruby.
    %x[~/mybin/findme.sh]
    
    #dirs
    %x[find . -type d -not -path "*/.svn*" -not -path "*.Xil*" | grep -v -P managed_ip_project > .project_dirs.txt]
    #
    if VERBOSE
      puts my_file_list
    end
  end
else
  if VERBOSE
    puts "","--Project folder not found--"
  end
end
################################################################################


################################################################################
if FALSE
  f = ".project_files.txt"
   
  ext = ".el"
   
  a = "ls f*.rb"
  b = "find . -iname \"*.rb\""
  c = "find . -iname \"*#{ext}\"> #{f}"
   
  # system(a)
  temp = %x[ #{c} ]
  
  if VERBOSE
    puts "blah"
    puts temp
    puts "blah"
  end
end 
################################################################################


################################################################################
# Dir.glob explanation http://ruby.about.com/od/beginningruby/a/dir2.htm 
if FALSE
  array_of_all_files =
    Dir.glob("**/*.{el,elc}").reject { |file_path| File.directory? file_path }
  if VERBOSE
    puts array_of_all_files
  end
end
################################################################################


                
