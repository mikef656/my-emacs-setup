################################################################################
require_relative "./tagslib.rb"
################################################################################


trunk_absolute_dir = get_trunk_dir_location_as_pn_object_fn


trunk_url = get_trunk_url_fn(trunk_absolute_dir)


tags_url = create_tags_url_pn_obj_fn(trunk_url)


list_tags_fn(tags_url)
#################################################################################



