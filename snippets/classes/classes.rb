# Classes are created in ruby with the class keyword
# Also creates a new constant that refers to the class
class Point
end
# Within the body of a class, the self keyword refers 
# to the class being defined.

# Instantiate a class like below
# p holds a class object that represents the new class
p = Point.new

# Can ask the object what kind of object it is
puts p.class # => Point
puts p.is_a? Point # => true

# Initializing a point
# This is done in an initialize method (constructor)
class Point
	# Def defines an instance method within the class
	# Method that is invoked on instance of a class
	# When an instance method is called, value of self is 
	# an instance of the class where the method is being defined
	def initialize(x,y)
		# Assign the value to instance variables
		# Belong to the object self refers to
		# Each instance of Point has their own copy
		# Instance variables do not need to be declared
		@x, @y = x,y
	end
end

# Initialize method has a special purpose
# Arguments passed to new are passed to initialize
p = Point.new(0,0)

# Defining a to_s method to return a string representation of the object
class Point
	def initialize(x,y)
		@x, @y = x,y
	end

	def to_s
		"(#{@x}, #{@y})"
	end

end
# Print the points out
p = Point.new(0,0)
puts p # => (0, 0)

# Accessors and attributes
# Values of instance variables are only available to instance methods
# Accessor methods must be provided to expose the values
class Point
	def initialize(x,y)
		@x, @y = x,y
	end

	def to_s
		"(#{@x}, #{@y})"
	end

	def x
		@x
	end
	def y
		@y
	end

	def x=(x)
		@x = x
	end
	def y=(y)
		@y = y
	end
end

# This allows code like below to be used
p = Point.new(3, 4)
# Allows gets
puts p.x, p.y # => 3, 4
# Allows values to be set
p.x, p.y = 5, 6 

# Accessors can be used to simplify this code
# Accessors can be used to simplify this code
class Point
	def initialize(x,y)
		@x, @y = x, y
	end

	attr_writer :x, :y # Define accessor methods for instance variables
	attr_reader :x, :y
end

# This can be further simplified
class Point
	def initialize(x,y)
		@x, @y = x, y
	end

	attr_accessor :x, :y # Define accessor methods for instance variables
end

p = Point.new(10, 10)
puts p.x, p.y # => 10, 10 : works like above class

# Defining operators is simple
# Method-based operators are simply methods with punctuation for names
class Point
	attr_reader :x, :y

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
end

# Create some instances
p1, p2 = Point.new(2, 4), Point.new(3, 8)

# Add em together
puts p1+p2

# Wrong type raises error
begin
	puts p1+4
rescue TypeError
	puts "Told you it'd raise an error!"
end

# Multiply by scalar
puts p1*2

# However, look what happens here
begin
	2*p1
rescue TypeError
	puts "The integer class doesn't know how to Multiply by a point."
	# Therefore it looks in the point's coerce method
	# and switches the order
end

# Updated with coerce below
class Point
	attr_reader :x, :y

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

	# If we try passing a point to * method of Integer,
	# it will call this method on the Point and then try
	# to multiply the elements in the array
	# We switch order of operands so * method in this class
	# is used
	def coerce(other)
		[self, other]
	end
end
# It works now
p3 = Point.new(20,2)
puts 2*p3


# Array and hash access with []
class Point
	attr_reader :x, :y

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

	# Define an array access method for the points
	def[](index)
		case index
		when 0, -2 then @x
		when 1, -1 then @y
		when :x, "x" then @x
		when :y, "y" then @y
		else nil
		end
	end

	def coerce(other)
		[self, other]
	end
end

p4 = Point.new(10, 43)
p4[0] # => 10
p4[1] # => 43
p4[:x] # => 10
p4[:y] # => 43

# We could even build in enumeration method
class Point
	# Including this as a mixin with an each method is very powerful
	include Enumerable
	attr_reader :x, :y

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

	# Define an array access method for the points
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

	def coerce(other)
		[self, other]
	end
end

# Look at the fancy each method
p = Point.new(1,2)
p.each { |x| puts x } # => 1, 2

# Look at the even more fancy enumerator stuff
puts p.all? { |x| x == 0 } # => false, True if point = (0,0)

# Equality
# We can add an == method to check if x and y are same
class Point
	include Enumerable
	attr_reader :x, :y
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

	def coerce(other)
		[self, other]
	end
end

p1 = p2 = Point.new(1,3)
puts p1 == p2 # => true


# Ordering points
class Point
	include Enumerable
	include Comparable
	attr_reader :x, :y
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

	def coerce(other)
		[self, other]
	end
end

# A mutable point
# The point class so far has no way to change x and y
# we could do
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

	def add!(p)
		@x += p.x
		@y += p.y

	def coerce(other)
		[self, other]
	end
end
















































