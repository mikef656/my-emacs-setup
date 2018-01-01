#!/usr/bin/env ruby
#Some different ways to set the load path
#
#Micheal Morin
#http://ruby.about.com/od/rubyfeatures/a/require.htm
# $LOAD_PATH << 'c:/Users/mfitzgerald/AppData/Roaming/mybin/'
#
#$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__))) unless $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))
#
#http://stackoverflow.com/questions/837123/adding-a-directory-to-load-path-ruby
$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__))) unless
    $LOAD_PATH.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
#
require "sandbox_lib"
#the file we're loading is relative to the file we're loading it from
# - they're both in the same directory.

get_wc_url_fn
