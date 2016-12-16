class Person 	# Creates a constant to refer to the class
							# Therefore class name must be capitalised
							# Within the class self refers to class being defined
end

# We can instantiate a new person
# All classes have a method .new that creates a new instance
p = Person.new

# Because we haven't defined any methods, we can't do much to p
# We can however access methods inherited from Object class
puts p.class # => Person
puts p.is_a? Person # => true

# Most languages have a constructor
# Ruby classes have an initialize method
class Person
	def initialize(name,age) 	# This is an instance method of class Person
														# Here the value of self is the instance of the class

		# Below are two instance variables, which always begin with @
		# "Belong to" whatever object self refers to
		# Only code in instance methods can manipulate instance variables
		@name, @age = name, age
	end
end

# The new method automatically calls the initialize method and passes it
# the required parameters
# initialize is a private method so cannot be accessed from outside the class
john = Person.new("John", 28)

# We can also define a to_s instance method
# We've included another instance variable as well
class Person
	def initialize(name,age,is_male=true)
		@name, @age, @is_male = name, age, is_male
	end

	def to_s
		"This person's name is #{@name} and #{@is_male ? "he" : "she"} is #{@age}"
	end
end

# Initialize and call to_s method
deb = Person.new("Deb", 30, false) 
puts deb # => "This person's name is Deb and she is 30"

# The values of the instance vars are only available in instance methods
# therefore we have to write accessors so we can get access them externally
class Person
	def initialize(name,age,is_male=true)
		@name, @age, @is_male = name, age, is_male
	end

	def name
		@name
	end
	def name=(n)
		@name = n
	end

	def age
		@age
	end
	def age=(a)
		@age = a
	end

	# Let's pretend you can't change gender
	# So we just define a getter
	# Note the predicate ?
	def is_male?
		@is_male
	end

	def to_s
		"This person's name is #{@name} and #{@is_male ? "he" : "she"} is #{@age}"
	end
end

# We can now access these methods to get or set the value of instance vars
dex = Person.new("Dexter", 30)
puts dex.name # => "Dexter"
puts dex.age # => "30"
dex.age = 31 
dex.name = "Some lumberjack"
puts dex.name # => "Some lumberjack"
puts dex.age # => "31"

# There are methods defined by the module class that take care of this
# these are attr_reader, attr_writer and attr_accessor
# these generate these trivial methods for you
# We can re-write the class like this
class Person

	# attr_accessor method defines a getter and setters
	# Pass method names as symbol parameters
	attr_accessor :name, :age

	# attr_reader method defines a getter
	# Note we can't include predicate ?
	attr_accessor :is_male

	def initialize(name,age,is_male=true)
		@name, @age, @is_male = name, age, is_male
	end

	def to_s
		"This person's name is #{@name} and #{@is_male ? "he" : "she"} is #{@age}"
	end
end

# Works the same as above
angel = Person.new("Angel", 40, true)
puts angel.name # => "Angel"
angel.name = "Batista"
puts angel.name # => "Batista"

# We can define methods that act like operators
# This may require a new class, because we can't add and subtract people
class Point
	attr_accessor :x, :y

	def initialize(x,y)
		@x, @y = x, y
	end

	# Here we define some operator methods
	def +(a)
		raise TypeError if not a.is_a? Point
		Point.new(@x + a.x, @y + a.y)
	end

	def -(a)
		raise TypeError if not a.is_a? Point
		Point.new(@x - a.x, @y - a.y)
	end

	def *(scalar)
		raise TypeError if not scalar.is_a? Numeric
		Point.new(@x*scalar, @y*scalar)
	end
	
	def to_s
		"(#{@x},#{@y})"
	end
end

# We can use these operators now
p1, p2 = Point.new(10,20), Point.new(3, 5)
puts (p1 + p2) # => (13,25)
puts (p1 - p2) # => (7,15)
puts p1*6			 # => (60,120)

# Note we get an error if we do this
begin
	puts 6*p2
rescue
	puts "We got an error"
end

# This is because Integer doesn't define a * operator
# that accepts a Point as a parameter
# it'll try call the coerce method on Point
# We can switch the order of operands
# see the updated class below
class Point
	attr_accessor :x, :y

	def initialize(x,y)
		@x, @y = x, y
	end

	def +(a)
		raise TypeError if not a.is_a? Point
		Point.new(@x + a.x, @y + a.y)
	end

	def -(a)
		raise TypeError if not a.is_a? Point
		Point.new(@x - a.x, @y - a.y)
	end

	def *(scalar)
		raise TypeError if not scalar.is_a? Numeric
		Point.new(@x*scalar, @y*scalar)
	end
	
	def coerce(o)
		[self, o]
	end

	def to_s
		"(#{@x},#{@y})"
	end
end

# Therefore we can now do this
p3 = Point.new(5,6)
puts 2*p3 # => (10,12)

# Array and hash access with []
# We can define a [] operator method like below
class Point
	attr_accessor :x, :y

	def initialize(x,y)
		@x, @y = x, y
	end

	def +(a)
		raise TypeError if not a.is_a? Point
		Point.new(@x + a.x, @y + a.y)
	end

	def -(a)
		raise TypeError if not a.is_a? Point
		Point.new(@x - a.x, @y - a.y)
	end

	def *(scalar)
		raise TypeError if not scalar.is_a? Numeric
		Point.new(@x*scalar, @y*scalar)
	end
	
	def coerce(o)
		[self, o]
	end

	def [](index)
		case index
		when 0, -2 then @x
		when 1, -1 then @y
		when :x, "x" then @x
		when :y, "y" then @y
		else nil 
		end
	end

	def []=(index,value)
		case index
		when 0, -2 then @x=value
		when 1, -1 then @y=value
		when :x, "x" then @x=value
		when :y, "y" then @y=value
		else nil 
		end
	end

	def to_s
		"(#{@x},#{@y})"
	end
end

p4 = Point.new(3, 6)
p4[:x]=4
puts p4[0] # => 4

# We can write an each iterator for our point class
class Point
	attr_accessor :x, :y

	def initialize(x,y)
		@x, @y = x, y
	end

	def +(a)
		raise TypeError if not a.is_a? Point
		Point.new(@x + a.x, @y + a.y)
	end

	def -(a)
		raise TypeError if not a.is_a? Point
		Point.new(@x - a.x, @y - a.y)
	end

	def *(scalar)
		raise TypeError if not scalar.is_a? Numeric
		Point.new(@x*scalar, @y*scalar)
	end
	
	def coerce(o)
		[self, o]
	end

	def [](index)
		case index
		when 0, -2 then @x
		when 1, -1 then @y
		when :x, "x" then @x
		when :y, "y" then @y
		else nil 
		end
	end

	def []=(index,value)
		case index
		when 0, -2 then @x=value
		when 1, -1 then @y=value
		when :x, "x" then @x=value
		when :y, "y" then @y=value
		else nil 
		end
	end

	def to_s
		"(#{@x},#{@y})"
	end

	# We can include the Enumerable module
	# if we define an each method
	include Enumerable

	def each
		yield @x
		yield @y
	end
end

p5 = Point.new(100,200)
p5.each {|cood| puts cood } # => 100, 200

# We must provide an implementation of the == operater
# so that two points can be tested for equality
# Remember that ruby alos defines an eql? method for testing equality
# this is usually stricter than == and tests type of operands
# this is also implemented below
class Point
	def ==(o)
		if o.is_a? Point
			@x == o.x && @y == o.y
		else false end
	end

	# Note the eql? method is called on the instance variables
	# this checks they are the same type
	def eql?(o)
		if o.is_a? Point
			@x.eql?(o.x) && @y.eql?(o.y)
		else false end
	end
end

p6, p7 = Point.new(1,2), Point.new(1.0,2.0)
puts p6==p7 # => true
puts p6.eql? p7 # => false

# NOTE:- this is the correct implementation for any class that implements
# collections. If two collection classes are being tested for equality with
# ==, then every member should be tested against another member with =
# and if eql? is used, then every member should call eql? with another collection
# member as the parameter

# Another reason may be you want your objects to behave in a special way
# when used as a hash key. Hash keys are tested for equality with .eql? and not
# ==. So you must define an appropriate .eql? like below
class Book
	attr_accessor :title, :pages

	def initialize(title, pages)
		@title, @pages = title, pages
	end

	def ==(o)
		if o.is_a? Book
			@title == o.title && @pages == o.pages
		else false end
	end
end

b1, b2, b3 = Book.new("Book One", 500), Book.new("Book One", 500), Book.new("Book three", 200)

# Now see what happens when we use them as a hash key
some_hash = { b1 => "Crawley Library", b3 => "Trash"}

# Now access the first one
puts some_hash[b1] # => "Crawley Library"
puts b1 == b2 # => true
# if b1==b2 we should expect them to return the same hash value
puts some_hash[b2] # => nil ... but they don't

# We need to open up the class and add an .eql? method
# We must also define a .hash method to compute hashcode for the object
# performance reasons mean we must compute a hash code that minimises collisions
class Book
	def eql?(o)
		if o.is_a? Book
			@title.eql?(o.title) && @pages.eql?(o.pages)
		else false end
	end

	# This hash method is suitable, but could be improved
	#def hash
	#	@title.hash + @pages.hash
	#end
	
	# This is a more useful hash method
	# Use this for other stuff
	def hash
		code = 17
		code = 37*code + @title.hash
		code = 37*code + @pages.hash
		# Insert lines for each instance variable of significance
		code # return the resultant hash code
	end
end

puts b1.eql? b2 # => true
some_hash = { b1 => "Crawley Library", b3 => "Trash"}
puts some_hash[b2] # => "Crawley Library", as we wanted

# ORDERING CLASSES
# In order to make classes oderable and comparable with equality signs,
# we must implement the <=> operator and include the comparable module
class Rect
	include Comparable

	attr_accessor :width, :height

	def initialize(width, height)
		@width, @height = width, height
	end

	def area
		@width*@height
	end

	# Sort the rectangles by their area
	def <=>(o)
		# Return nil if o isn't a rectangle
		return nil unless o.is_a? Rect
		# Otherwise compare their areas
		area <=> o.area
	end

	def to_s
		"width=#{@width}, height=#{@height}, area=#{area}"
	end
end

r1, r2 = Rect.new(100,200), Rect.new(400, 500)
puts r1 > r2 # => false
puts r1 < r2 # => true

# Comparable mixin lets us do sorting
# First create an array of random sized rectangles
rects = []
10.times { rects << Rect.new(rand(1000),rand(1000)) }

# Now sort them
puts rects.sort!








