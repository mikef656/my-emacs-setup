OUTPUT_FILE = 'test_output_file.vhd'
OUTER_PATH = './../'
OUTPUT_FILE_BACK_ONE =  OUTER_PATH +  OUTPUT_FILE
#
myarray = [ "7890" , "htns", "1234"]


#################################################################################
#write to files
def write_file(target_file,array_to_write)
  puts "Writing to file #{target_file}"
     File.open(target_file, "w+") do |f| 
    array_to_write.each { |element| f.puts(element) } 
  end
end
#################################################################################


# match several variation of -c, for copy
if ARGV[0] =~ /\s*-*\s*c/ || ARGV[0] =~ /\s*-*\s*C/
  puts "matched"                        
  puts ARGV[0]
  file_to_write = OUTER_PATH +  OUTPUT_FILE
else   
  puts "no match"
  file_to_write = OUTPUT_FILE
end   


write_file(file_to_write , myarray) 
