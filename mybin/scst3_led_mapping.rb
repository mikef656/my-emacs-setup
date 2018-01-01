#print out the Surecom SCST3 LED register meanings given a hex code.
num = "000fc220002f0000"
num_hex = num.to_i(16).to_s(2).rjust(num.size*4, '0').scan(/./)
puts "the bin num =: #{num_hex}"

#utility
# print"["
# (0..63).to_a.reverse.each{ |x| 
# print x,","}
# print"]"


led0_assignments = [63,62,61,60,59,58,57,56,55,54,53,52,"LED_GIO_RX","LED_GIO_TX","LED_GIO4_LINKRDY","LED_GIO3_LINKRDY","LED_GIO2_LINKRDY","LED_GIO1_LINKRDY",45,44,43,42,"LED_YES_PRE",40,39,38,"LEDRPOS",36,35,34,33,"LED_REALTIME","LED_PLUS1_MODE","LED_CONSOLE_CHK","LED_CONSOLE_GEN","LED_DAS_CHK","LED_DAS_GEN",26,25,"LED_SCST_DSW_MISS_SETTING","LED_SCRT_DSW_MISS_SETTING","LED_SCAN_BLOCKED","LED_SCH2_RX","LED_SCH2_TX","LED_SCH2_LINKRDY","LED_SCH1_Rx","LED_SCH1_TX","LED_SCH1_LINKRDY","LED_7SEG1-8","LED_7SEG1-7","LED_7SEG1-6","LED_7SEG1-5","LED_7SEG1-4","LED_7SEG1-3","LED_7SEG1-2","LED_7SEG1-1","LED_7SEG2-8","LED_7SEG2-7","LED_7SEG2-6","LED_7SEG2-5","LED_7SEG2-4","LED_7SEG2-3","LED_7SEG2-2","LED_7SEG2-1"]

led0_assignments.each_with_index do |x,i|
  if x.is_a? String
    #puts "its a string"
    puts x
  else 
    #puts "its not a string #{x[i]}"
  end
end



result = num_hex.each_with_index.collect {|x,i| 
  if x == "1"
    #puts "yep x is 1"
    led0_assignments[i]
  end
}


puts "The result"
puts result.inspect
puts result.count
puts "The result compacted"
puts result.compact.inspect
puts result.compact.count


#result.to_enum.with_index.reverse_each do |x,i|
result.each_with_index do |x,i|
 if x
    print "bit #{63-i}: #{x} \n"
 end
end
