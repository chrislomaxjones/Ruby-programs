# We can create proc objects with the Proc.new method
# It accepts no arguments
# Has to be invoked with a block
# Returns a proc (not a lambda) that represents a block
p = Proc.new {|x,y| x + y}

# If Proc.new is not associated with a block
# then it returns a proc representing a block
# that is associated with the containing method
def some_method()
	Proc.new
end

# Arbitray code called on a proc
def some_other_method(&b)
	b.call "Hello world"
end

# Associate proc with the method's associated proc
new_proc = some_method {|x| puts x} # new_proc now represents {|x| puts x}
# Execute this method to demonstrate assocation
some_other_method(&new_proc) # => "Hello world"




# lambdas can be created with the lambda global function
# they expect no arguments
# differs from Proc.new as returns a lambda objects
# must have an associated block
is_positive = lambda { |x| x > 0}

# We can also define it this way in versions >1.9
is_positive = ->(x){x > 0}

# We call this like a Proc
puts is_positive.call(100) # => true

# This lambda takes 2 args and declares 3 locals
some_lambda = ->(a,b;i,j,k){ }

# They can be declared with argument defaults
area_of_triangle = ->(b,h=b) { 0.5 * b * h }
puts area_of_triangle.call(2) # => 2.0
puts area_of_triangle.call(2, 4) # => 4.0

# Brackets can be removed
sum = ->x,y {x + y}

# Empty lambda
empty = ->{}

# Its a very succint way of writing lambdas
# For example, this lets us create composites
def composite_of(f,g)
	->(x) { f.call( g.call(x) ) }
end
# Create some lambdas
a = ->(x){x*5}
b = ->(x){x**2}
# Compose them and store in c
c = composite_of(a, b)
# Call c
puts c.call(10) #=> 500

# You can pass lambda literals as anon blocks
# use & like below
evens = (1..10).select &->(x) { x%2 == 0 }
puts evens.to_s

# You can also pass it in the params with &
odds = (1..10).reject(&->(x) {x%2 == 0})
puts odds.to_s

# call provides a return value
# Here is some dumb sample method
def sum(*values, &b)
	s = 0
	values.each do |v|
		# Note the use of call having a value
		s+= b.call(v)
	end
	s
end
# We pass it a dumb lambda
puts sum(*(1..100), &->(x) { x*10 }) # => 50500

# We can also use array access op [] to call
f = ->(x) {x**2 + 4*x + 8}
puts f[10] # => 148

# Here with multiple arguments
g = ->(a,b,c) { a*b*c }
puts g[2,4,6] # => 48

# Wait and this!
puts f.(5) # => 53
puts g.(1, 3, 9) # => 27