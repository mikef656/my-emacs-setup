class Shape
end
 
class Square < Shape
  def initialize(side_length)
    @side_length = side_length
  end
  
  def area
    @side_length*@side_length
  end

  def permiter
    @side_length*4
  end
end

class Triangle < Shape
  def initialize(base_width, height, side1, side2, side3)
    @base_width = base_width
    @height = height
    @side1 = side1
    @side2 = side2
    @side3 = side3
  end

  def area
    @base_width*@height/2
  end

  def permiter
    @side1 + @side2  + @side3
  end

end


my_square = Square.new(5)
my_triangle = Triangle.new(6, 6, 7.81, 7.81, 7.81)
puts my_square.area
puts my_square.permiter
puts my_triangle.area
puts my_triangle.permiter
