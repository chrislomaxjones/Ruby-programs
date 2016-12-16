# OBJECTS
# -------

# Create a string object
# Store reference in s
s = "Ruby"
# Copy the reference to t. s and t both refer to the same object
t = s
# The the object through the reference to it
t[-1] = ""
# Access modified object through s
puts s # -> "Rub"
# t now refers to different object
t = "java"
puts s, t # -> "Rubjava"


# Objects of other classes need to be explicitly created
# Often done with a method named new
# new allocates memory to hold new object
# most classes define an initialize method
# "factory methods" return instances
myObject = String.new

# Ruby implements garbage collections
# this means when no more references to an object exists
# ... it is then deallocated

# object_id returns a unique Fixnum for each object
i = "hello"
puts i.object_id # -> some long number


# Several ways to determine class of object
o = "test"
puts o.class # -> String

# Class hierachy can be obtained
puts o.class.superclass # - > Object
puts o.class.superclass.superclass # -> BasicObject
puts o.class.superclass.superclass.superclass # -> nil (BasicObject doesn't have a superclass)

# Checking class is easy and do same thing
o.class == String # -> true
o.instance_of? String # -> true

# is_a? determines whether object is instance of subclass
x = 1
puts x.instance_of? Fixnum # -> true
puts x.instance_of? Numeric # -> false - this method doesn't check inheritance
puts x.is_a? Fixnum # -> true
puts x.is_a? Integer # -> true
puts x.is_a? Numeric # -> true
puts x.is_a? Comparable # -> true
puts x.is_a? Object # -> true

# the Class class defines === operator to perform this method
x === Numeric # -> true; same as above

# Method checks for operator
o = "hello"
o.respond_to? :"<<"

# Have to be careful.
# Numeric also implemenet operator in a different way
# must be explicity ruled out
o.respond_to? :"<<" and not o.is_a? Numeric

# Ruby has number of ways to compare equality of objects
a = "Ruby"
b = c = "Ruby"

puts a.equal?(b) # -> false, a and b do not reference same obj
puts b.equal?(c) # -> true, b and c reference same obj
a == b # -> true, a and b reference the same values

# Comparison of object ids also checks equality
puts a.object_id == b.object_id # -> false
puts b.object_id == c.object_id # -> true

# eql? method is synonym for equal?
# Classes that override it use it for strict equality
# no type conversion
1 == 1.0 # -> true
1.eql?(1.0) # -> false

# === is called case equality operator
(1..10) === 5 # -> true, 5 in range
/\d+/ === "123" # -> true, string matches regex
String === "s" # true, "s" is instance of class String

# classes define an ordering by implementing the <=> operator
# return -1 if left is less than right
# return 0 if two operands are equal
# return 1 if left is greater than right
# If two operands cannot be meaningfully compared, return nil
1 <=> 5 # -> -1
5 <=> 5 # -> 0
9 <=> 5 # -> 1
"1" <=> 5 # -> nil
# Classes that define this operator typically inlcude the Comparable module as a mixin

nan = 0.0/0.0 # 0/0 is not a number
nan < 0 # false
nan > 0 # false
nan == 0 # false
nan == nan # false - not equal to itself
nan.equal?(nan) # this is true because same object
puts nan # -> "NaN"

# OBJECT CONVERSION
#------------------
10.to_s # converts to string
10.293.to_i # -> 10; converts to int
10.to_f # -> 10.0; converts to float
(1..3).to_a # -> [1,2,3]; converts to array

10.to_c # -> 10+0i; complex numbers
0.5.to_r # -> 1/2; rational numbers (fractions)

# Objects can be frozen
s = "ice"
s.freeze # Makes s immutable
s.freeze? # true as s is frozen
# s.upcase! # returns a type error

# Objects can be tainted
s = "untrusted"
s.taint # taint the obj
s.tainted? # -> tainted
s.upcase.tainted? # -> derived objs are tainted
s[3,4].tainted? # -> substrings are tainted




























