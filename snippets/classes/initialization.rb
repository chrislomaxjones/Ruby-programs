# Factory methods
class SomePoint
  def initialize(x, y, z=nil)
    @x, @y, @z = x, y, z
  end
end

# Sometimes parameter defaults are not enough
# Below is something we could do 
class Point
  def initialize(x,y)
    @x,@y = x,y
  end

  # Un-expose the new method
  private_class_method :new
  
  # Provide two separate method to create objects
  def self.Cartesian(x, y)
    new(x,y)
  end
  def self.Polar(r, theta)
    new(r*Math.cos(theta), r*Math.sin(theta))
  end
end

# And you can create points in different ways
p1 = Point.Cartesian(1, 1)
p2 = Point.Polar(4, Math::PI)









































