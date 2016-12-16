# Throw in copy of Point object from last classes.rb
class Point
	include Enumerable
	include Comparable
	attr_accessor :x, :y
	alias eql? ==

	def initialize(x, y)
		@x, @y = x, y
	end

	def +(other)
		raise TypeError, "Point argument expected" unless other.is_a? Point
		Point.new(@x + other.x, @y + other.y)
	end

	def -@
		Point.new(-@x, -@y)
	end

	def *(scalar)
		Point.new(@x*scalar, @y*scalar)
	end

	def[](index)
		case index
		when 0, -2 then @x
		when 1, -1 then @y
		when :x, "x" then @x
		when :y, "y" then @y
		else nil
		end
	end

	def each
		yield @x
		yield @y
	end

	def ==(other)
		if other.is_a? Point
			@x==other.x && @y==other.y
		else
			false
		end
	end

	def <=>(other)
		return nil unless other.instance_of? Point
		# This effectively calculates pythagoran distance
		@x**2 + @y**2 <=> other.x**2 + other.y**2
	end

	def add!(p)
		@x += p.x
		@y += p.y
	end

	def coerce(other)
		[self, other]
	end
end


# Quick and easy mutable clases
# Structs can be used to make quick and easy mutable point classes
# Struct is a core class that generates other classes
# These generated classes have accessor methods for the named fields you specify
Struct.new("Point", :x, :y) # Creates new class Struct::Point
Point = Struct.new(:x, :y) # Creates new class, assigns to point

# Naming anonymous classes
# If you assign an unnamed class object to a constant,
# The name of that constant becomes the name of the class
# You can observe this same behavior if you use Class.new
C = Class.new # A new class with no body, assigned to a const
c = C.new # An instance of the class
c.class.to_s # => "C": constant becomes class name

# Once a class has been created with Struct.new, you can use it like any other class
p = Point.new(1,3)
p.x
p.y
p.x = 21
p.y = 24

# Structs also define the [] and []= operators for indexing (array/hashing)
# Even provides .each and .each_pair methods
p[:x] = 4
puts p[:x]
puts p[1] # => same as p.y
p.each { |c| puts c } # => 424
p.each_pair { |b,c| print b,c,"\n" }

# Class methods
# These are methods invoked on the class object itself
class Colour
	def initialize(r=255,g=255,b=255)
		@red, @green, @blue = r, g, b
	end

	# Can also be written as def Colour.black ... end
	def self.black
		Colour.new(0,0,0)
	end

	def to_s
		"(red:#{@red}, green:#{@green}, blue:#{@blue})"
	end
end
# Call class method on class and not on any instance
puts Colour.black.to_s

# Open up the Colour object so we can add methods to it
# can also use class << self in body of class definition
class << Colour # Syntax for adding methods to a single object
	def white
		Colour.new()
	end
end

# Note now white can be accessed
puts Colour.white.to_s

# Constants may also be useful
class Circle
	def initialize(centre_x, centre_y, radius)
		*@centre, @radius = centre_x, centre_y, radius
	end

	ORIGIN = [0,0]
	UNIT_CIRCLE = Circle.new(0,0,1)

	def to_s
		"Circle with centre #{@centre.to_s} and radius #@radius"
	end
end

# Output constants
puts Circle::ORIGIN.to_s
puts Circle::UNIT_CIRCLE.to_s

# Class variables can also be used
# Begin with @@
class GeometricTerm
	def initialize(a, r, n)
		@a, @n, @r = a, n, r
	end

	@@sequence = []
	
  # Note the use of super, which calls initialize()
	def self.new(a,r,n)
		super
	end

	def self.sequence
		@@sequence.collect do |item|
			puts item.class
		end
	end

	def self.sum(limit)
		# Do some code here...
	end

	def term
		@a*(@r**(@n-1))
	end
end

# Create some terms and display output
GeometricTerm.new(10, 2, 1)
GeometricTerm.new(10, 2, 2)
GeometricTerm.new(10, 2, 3)
puts GeometricTerm.sequence.to_s

# Class instance variables
# Class is an object - so can have instance variables
# Demonstrated in the code below
class Person
  @personCount = 0
   
  def initialize(name, age)
    @name, @age = name, age
  end
  
  # Class method is used every time new is called
  # As class instance variables cannot be used in
  # instance methods, such as initialize
  def self.new(name, age)
    @personCount+=1 # Increment the person count
    super # Call the actual new method which creates the object
  end
  
  # A way to expose the person count
  def self.count
    @personCount
  end
  
  # This code allows the actual variable to be accessed
  class << self
    attr_accessor :personCount
  end
end

p = Person.new("John", 26)
puts Person.count # => 1
p = Person.new("Terry", 31)
p = Person.new("Jas", 17)
puts Person.count # => 3

# Shows the actual accessor being used...
puts Person.personCount


           

