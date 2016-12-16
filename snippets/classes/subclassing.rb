class FactoryParent
  def initialize(name)
    @name = name
  end

  def to_s
    "Factory with name: #@name"
  end
end

# Extending a class is simple`
class FactoryChild < FactoryParent
end

# You can also sublass a struct-based class
class FactoryChildTwo < Struct.new("FactoryParent", :name)
  # Superclass gives us accessor methods, ==, to_s etc
  # Point-specific methods here...
end

# Inheriting methods
# Note the code below
class WorldGreeter
  def greet
    puts "#{greeting} #{who}"
  end

  def rude_greet
    rude
  end

  def greeting
    "Hello"
  end

  def who
    "World"
  end

  private
  
  def rude
    puts "Fuck off mate"
  end

end

class SpanishWorldGreeter < WorldGreeter
  def greeting
    "Hola"
  end
end

# This will provide interesting result
SpanishWorldGreeter.new.greet # => "Hola World"

# You can also inherit private methods
SpanishWorldGreeter.new.rude_greet

# You can augment and not completely override methods with super()
class Point
  def initialize(x,y)
    @x, @y = x, y
  end
end

class Point3D < Point
  def initialize(x, y, z)
    # Super calls initialize of superclass
    # .. if you call with no args then the args supplied to
    # .. this method are passed to the super method
    super(x,y)
    # Then add in some extra code for the subclass
    @z = z
  end
end

# Inheritance and class variables
# This takes a class variable and changes its value for all
# extended classes
class A 
  @@value = 1
  def A.value; @@value; end
end

class B < A; @@value = 2; end

class C < A; @@value = 3; end

# Although the value was changed in the implementation of C
# It has been applied to A's value as well
puts A.value # => 3

# Inheritance of constants
class Circle
  # Note a unit circle constant
  ORIGIN = [0,0]

  def initialize(centre, radius)
    @centre, @radius = centre, radius
  end
end

class Sphere < Circle
  # Redefined constant
  ORIGIN = [0,0,0]

  # More implementation here...
  def initialize(centre, radius)
    super
  end
end

# Note when you extend a class, the constant can be redefined
# Different values of the constant have different ways of being
# accessed.
puts Circle::ORIGIN.to_s # => [0,0]
puts Sphere::ORIGIN.to_s # => [0,0,0]





















