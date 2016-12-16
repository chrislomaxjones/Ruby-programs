# This is a whirlwind of methods
def hello(name="world")
	puts "hello #{name}"
end

hello # => "hello world"
hello "Dave" # => "hello Dave"

# This is a cute function
def factorial(n)
	raise ArgumentError if n.nil? || n < 0

	if n == 0 || n == 1
		1
	else
		n * factorial(n-1)
	end
end

# Factorial
# Note the optional parens
puts factorial 5

# Methods can have more than one return value
def more_than_one
	return 1, 2, 3
end

x, y, z = more_than_one

#