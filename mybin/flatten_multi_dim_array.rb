##
################################################################################
#@a = %w(0123456789ABCDEF 0123456789ABCDEF 0123456789ABCDEF )


@a = %w(0003000200010000 0007000600050004 000B000A00090008 FFFFAAAA5555FFFF)

@b = @a.collect { |x| x.to_s.scan(/..../) }
@b1 = @a.collect { |x| x.to_s.scan(/..../).reverse }


@c = []


@d = @b.join


result = @b.collect do |x|
            # if x.is_a? Array
            #   puts "found array"
            # end
            @c.push x
            #puts x
          end


#stackoverflow.com/questions/
  #8282096/ruby-how-to-concatenate-array-of-arrays-into-one
@f = @b.flatten

#this does the whole operation
@g = @a.collect { |x| x.to_s.scan(/..../) }.flatten

################################################################################
def convert_quadword_array_to_word_array(in_array)
  #stackoverflow.com/questions/
    #8282096/ruby-how-to-concatenate-array-of-arrays-into-one
  #@f = @b.flatten
  #
  #local= in_array.collect { |x| x.to_s.scan(/..../) }.reverse.flatten # 
  local= in_array.collect { |x| x.to_s.scan(/..../).reverse }.flatten
  return local
end
################################################################################


@j = convert_quadword_array_to_word_array(@a)


@h = @f.collect { |x| x.to_i}
@i = @f.collect { |x| x.hex}


puts "This is  @a #{@a}"
puts "Length of  @a #{@a.count}"
puts "This is  @b #{@b}"
puts "This is  @b1 #{@b1f}"
puts "This is  @b[0] #{@b[0]}"
puts "This is  @d.join #{@b.join}"
puts "This is  result #{result}"
puts "This is @b[0] + @b[1] #{@b[0] + @b[1]}"
puts "This is @d #{@d}"
puts "This is @e #{@e}"
puts "This is @f #{@f}"
puts "This is @g #{@g}"
puts "This is @h #{@h}"
puts "This is @i #{@i}"
puts "This is @j #{@j}"
puts "Length of  @j #{@j.count}"
################################################################################
##
