################################################################################
require "Pathname"
#
VERBOSE = false
################################################################################


################################################################################
def get_wc_url_fn
  %x[svn info | gawk "/^URL: / { print $2 }"].chomp
end
#################################################################################


#################################################################################
def get_trunk_dir_location_as_pn_object_fn 
  #get trunk dir location as a pn object
  #my_a = Array.new
@testvar=  Pathname.getwd.ascend do |dir_candidates_pn_obj| 
      #p dir_candidates_pn_obj
      if dir_candidates_pn_obj.to_s =~ /trunk$/
        if VERBOSE
          p dir_candidates_pn_obj.to_s
        end
        # trunk_absolute_dir = dir_candidates_pn_obj
        @target_dir= dir_candidates_pn_obj
      end
      #
  end
  #
  if VERBOSE
    # puts "found_dir:\n  #{trunk_absolute_dir}"
    puts "found_dir:\n  #{@target_dir}"
  end
  @target_dir
end
#################################################################################


#################################################################################
def get_trunk_url_fn (arg_dir)
  #get trunk url
  begin
  #
  # Dir.chdir(trunk_absolute_dir) do
  temp_trunk_url = Dir.chdir(arg_dir) do
    #puts`svn info`
    temp_trunk_url = get_wc_url_fn
    if VERBOSE
      puts "the trunk url is:\n  #{temp_trunk_url}"
    end
  #puts "got here"
  if VERBOSE
    puts "temp_trunk_url:\n #{temp_trunk_url.inspect}"  
  end
  temp_trunk_url
  end
  #
  rescue
    puts "  TRUNK DIR NOT FOUND ABORTING"
    abort
  end
end
#################################################################################


#################################################################################
#list tags
def list_tags_fn(arg_url)
  svn_ls_output_from_tags_url = `svn ls #{arg_url}`
  svn_ls_output_from_tags_url_array = svn_ls_output_from_tags_url.split("\n")
  #
  #print two columns if the array is long
  if svn_ls_output_from_tags_url_array.count > 10 and 
      svn_ls_output_from_tags_url_array.count < 20 
    puts "Found these tags:\n"
    svn_ls_output_from_tags_url_array.each_slice(2) do
      |a| print a[0]," ", a[1], "\n" 
                                                    end
  #
  elsif svn_ls_output_from_tags_url_array.count > 20
    puts "Found these tags:\n"
    svn_ls_output_from_tags_url_array.each_slice(3) do
      |a| print a[0]," ", a[1], " ", a[2], "\n" 
                                                    end
  #  
  else
    puts "Found these tags:\n #{svn_ls_output_from_tags_url}"
  end
  #
  svn_ls_output_from_tags_url
end
#################################################################################


#################################################################################
#query user for tag to co
def query_user_for_tag_to_co_fn
  print "Tag to checkout:"
  temp_tag_to_co = gets.chop
  puts "tag_to_co:\n  #{temp_tag_to_co}"
  temp_tag_to_co
end
#################################################################################


#################################################################################
def create_new_tag_url_fn(tags_url_arg,new_arg)
  #create_new_tag_url_fn
  new_tag_url = tags_url_arg + "#{new_arg}"
  puts "\nNEW_TAG_URL:\n   #{new_tag_url}"
  new_tag_url
end
#################################################################################


#################################################################################
# need to add an arg 'copy_from'
#  --consider copying from the path or url--
# perhaps add a comment shown to the user re URL->URL or path->URL
def create_tag_fn(tag_to_co_arg,from,to)
  #Create tag
  #                             |here is the problem its the . need trunk\
  `svn cp -m "#{tag_to_co_arg}" #{from} #{to}`
end
#################################################################################


#################################################################################
def create_tags_url_pn_obj_fn(trunk_url_arg)
  #create trunk url pn obj
  trunk_url_pn_obj = Pathname.new(trunk_url_arg)
  temp_tags_url = trunk_url_pn_obj.dirname.to_s + "/tags/"
  #
  if VERBOSE
    puts "trunk_url_pn_obj #{trunk_url_pn_obj}"
    puts "trunk_url_pn_obj dirname #{trunk_url_pn_obj.dirname}"
  end
  temp_tags_url
end
#################################################################################


#################################################################################
def get_tag_to_co_from_cli_or_query(arg)
  if arg.count == 0
    tag_to_co = query_user_for_tag_to_co_fn
  else
    tag_to_co = arg[0]
  end
end
#################################################################################
