# EXPRESSIONS
# -----------

# Expressions evaluate to produce a value
# Expressions and statements are not distinguishable in ruby

# Certain ruby keywords are primary expressions
puts nil
puts true
puts false
puts self
puts __FILE__
puts __LINE__
puts __ENCODING__

# Variable is a name for a value.
# Assignment expressions give var a value
one = 1.0
puts one

# $ - global vars
# @ @@ - instance and class variables
# lowercase or undercore beginning - local

# Constants begin with an uppercase
# Changing the value does not produce error but a warning instead
ConstantValue = 100
ConstantValue = 200 # -> produces a warning

# Assignment
x = 1

# Assignments can be chained
x = y = 100

# Parallel Assignment
x, y, z = 1, 2, 3 # x=1, y=2, z=3
x,y = y,x # swap vals of two vars
x = 1, 2, 3 #-> [1,2,3]
x, = 1, 2, 3 #-> 1 (note trailing comma)
x, = [1, 2] #-> 1 (note trailing comma)
x, y = 1, 2, 3 #-> x=1, y=2, 3 is discarded

# Splat operator *
x, y, z = 1, *[2,3] #-> x = 1, y = 2, z = 3

x, *y = 1, 2, 3 # -> x=1, y=[2,3]
x, *y = 1, 2 # -> x=1, y=[2]
x, *y = 1 # -> x = 1, y=[]

x, y, *z = 1, *[2,3,4] # x= 1, y = 2, z = [3,4]

# Parallel assignment can also use parentheses
x,(y, z) = 1, 2
# this is the same as...
x = 1
y,z = 2

x, y, z = 1, [2,3] # -> x = 1, y = [2,3], z=nil
x,(y,z) = 1, [2,3] #-> x = 1, y = 2, z = 3
a,(b,(c,d)) = ["a", ["b", ["c", "d"]]] #-> a="a", b="b", c="c", d="d"

# Bitwise operators
# ~ Inverts the bits (makes negative and adds 1)
a = ~0b1111
puts a.to_s(2) # output in base 2

# & is bitwise and
a = 0b1001 & 0b1110 # -> 1000
puts a.to_s(2)

# | is bitwise OR
a = 0b1000 | 0b0010 # -> 1010
puts a.to_s(2)

# ^ is bitwise XOR
a = 0b1000 ^ 0b0100 # -> 1100
puts a.to_s(2)

# Conditional operator
# Only ternary operator in ruby
a, b = 100, 200
c = b > a ? "a" : "b"






















