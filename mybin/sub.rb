array_of_filenames_to_read = %W[ shortfile.txt shortfile2.txt]


# @first_file_as_array_of_string   = File.readlines("./shortfile.txt").each  { |x| x}
# @second_file_as_array_of_string  = File.readlines("./shortfile2.txt").each  { |x| x}


old_array = [
          /^\s*Mike\b/, 
          /\bMichelle\b/, 
          /\bChris\b/, 
          /\bHeidi\b/
      ]


new_array = %W[
                 Joht 
                 Sue  
                 Ken 
                 Shelly
              ]


################################################################################
# For each line of a file, make multiple substitutions
# Return the entire file with all subs performed
def process_one_file_make_subs(file_as_array_of_string_arg,old_subs_array_arg,new_subs_array_arg)
    # This outside loop works over all lines of a file
  new_file_as_array_of_string_with_subs = 
    file_as_array_of_string_arg.collect { |one_string_file_array_element|
      #
      # This inside loop makes multiple subs on one line. 
      old_subs_array_arg.count.times { |subs_array_index|
        one_string_file_array_element.gsub!(old_subs_array_arg[subs_array_index],new_subs_array_arg[subs_array_index]) 
        }
    #
    modified_line = one_string_file_array_element
    #
    }
  #
  new_file_as_array_of_string_with_subs
  #
end
################################################################################


array_of_filenames_to_read.each {|filename| 
          #
          current_file_as_array_of_string = File.readlines("./#{filename}").each  { |x| x}
          #
          new_file_as_array_of_string = process_one_file_make_subs(current_file_as_array_of_string,old_array,new_array)
          #
          puts "","New file1",""
          puts new_file_as_array_of_string


  }


