################################################################################
# Call two ways
# 1) with a single command line argemunt like this
#   mycreatetag.rb rev_0001
#
# 2) No command line args will cause this prog to prompt the user
#
# One purpose of this is to have a ruby create the tag called from
# emacs lisp.  So call this in lisp and pass it an arg that has the
# name of the tag you want to create.  Perhaps prompt the user in emacs.
################################################################################


################################################################################
require_relative "./tagslib.rb"
################################################################################


################################################################################
trunk_absolute_dir = get_trunk_dir_location_as_pn_object_fn
puts "trunk_absolute_dir is #{trunk_absolute_dir}"

trunk_url = get_trunk_url_fn(trunk_absolute_dir)
puts "trunk_url is #{trunk_url}"


tags_url = create_tags_url_pn_obj_fn(trunk_url)

#don't list
# list_tags_fn(tags_url)

#tag_to_co is a simple string
tag_to_co = get_tag_to_co_from_cli_or_query(ARGV)


new_tag_url = create_new_tag_url_fn(tags_url, tag_to_co)

#need to pass trunk_absolute_dir as a from arg
#  --consider copying from the path or url--
# perhaps add a comment shown to the user re URL->URL or path->URL
create_tag_fn(tag_to_co,trunk_url,new_tag_url)


#don't list
#list_tags_fn(tags_url)
#################################################################################
