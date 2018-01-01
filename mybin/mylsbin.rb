#!/usr/bin/env ruby

################################################################################
# Cases for calling this
#1
# >= 2 args & first matches /^-/
# mylsbin -lrt   temp.rb  temp2.rb  temp3.rb
#         ARG[0]  ARG[1]   ARG[2]    ARG[3]
#2nd holds extension to search for
#
#
#2, combine with 4?
# >= 2 args & first does not match /^-/
# mylsbin temp.rb  temp2.rb  temp3.rb
#         ARG[0]  ARG[1]   ARG[2]    ARG[3]
#1st and 2nd hold extension to search for
#
#
#3
# 1 arg & matches /^-/
# mylsbin -lrt   
#         ARG[0] 
#No extension to search for
#
#4 combine with 2?
# 1 arg & does not match /^-/
# mylsbin file.rb   
#         ARG[0] 
# 1st holds extension to search for
#
#
#5 No args
#
#
################################################################################

require 'pathname'


case ENV['myenv']
  #
  when "home_pc"
    #puts "it's the home pc"
    search_path = 'c:/Users/family/AppData/Roaming/mybin/'  
  #
  when "work_pc"
    #puts "it's the work pc"
    search_path = 'c:/Users/mfitzgerald/AppData/Roaming/mybin/'  
  #
  when "work_linux"
    #puts "it's the work linux machine"
    search_path = '~/mybin/'  
  #
  else
    #puts "could not find a matching env var"
    search_path = 'c:/Users/mfitzgerald/AppData/Roaming/mybin/'  
 end



case 
  
  when (ARGV.length >= 2) & ( /^-/.match(ARGV[0]))
    #1
    #user gave a -l style argement and probably a wildcard
    #for example
    #mylsbin -l *.rb
    pn_new = Pathname.new(ARGV[1])
    my_extension_to_search_for = '*' + pn_new.extname
    puts "\nThe ext to list is  #{my_extension_to_search_for}"
    #     
    Dir.chdir(search_path) do
        system("ls #{ARGV[0]} #{my_extension_to_search_for}")
    end  

  when (ARGV.length >= 1) & !( /^-/.match(ARGV[0]))
    #2,4
    pn_new = Pathname.new(ARGV[0])
    my_extension_to_search_for = '*' + pn_new.extname
    puts "\nThe ext to list is  #{my_extension_to_search_for}"
    #
    Dir.chdir(search_path) do
        system("ls #{my_extension_to_search_for}")
    end  
    #puts "Got here"
  
  when (ARGV.length == 1) & ( /^-/.match(ARGV[0]))
    #3
    pn_new = Pathname.new(ARGV[0])
    my_extension_to_search_for = '*' + pn_new.extname
    puts "\nThe ext to list is  #{my_extension_to_search_for}"
    #
    Dir.chdir(search_path) do
        system("ls #{ARGV[0]}")
    end  
    #puts "Got here"

  else
    Dir.chdir(search_path) do
          #system("ls")
          #temp=`ls`
          #puts temp.gsub(/\r/,"").split("\n")
    end  

end

Dir.chdir(search_path) do
  tempnum =  Dir.new(".").entries.length
  puts "#{tempnum} Total files in the mybin dir"
end

