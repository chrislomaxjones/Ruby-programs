# Note already learned a lot of this on codecademy

def sum(x1,x2)
	x1+x2
end
puts sum(100, 200)
undef sum
# puts sum(100, 200) # => undefined method error


# Alias allow methods to be given new identifiers
def some_method(x1, x2)
	return x1 if x1 > x2
	return x2 if x2 > x1
end

alias new_method_name some_method

def some_method(x1) x1*x1 end

puts new_method_name(100, 200)
puts some_method(100)

# Parameters can be given default values
def first_characters(some_string, length=1)
	some_string[0, length]
end
# Note param can be supplied and then that value is used
puts first_characters("Hello", 4) # => "Hell"
# Or can not be supplied and the default value is used
puts first_characters("Hello") # => "H"

# Expressions can be used as well as literals for default values
def first_characters_improved(some_string, length=some_string.length)
	some_string[0, length]
end
puts first_characters_improved("Hello") # => "Hello"

# returns the max values from function
# Sort of functionality can be used when number of params is unkown
def max(x, *rest)
	top = x
	rest.each do |y|
		top = y if y > top
	end
	top # Return top
end
# Note number of parameters is > 2 in method definition
puts max(100, 200, 300, 200, 100) # => 300

# How would you pass an array to max method
puts max( [100, 200, 300] ).to_s # => [100, 200, 300] - wrong!!
puts max( *[100, 200, 300] ) # => 300 - right!!

# Enums are splattable objects
# This below would work
puts max(*"hello world".each_char) # => 'w'

# Arguments could be supplied as a hash and accessed like below.
def sequence(args)
	n, m, c, a = args[:n] || 0, args[:m] || 1, args[:c] || 0, []

	n.times do |i|
		a << m*i+c
	end
	a
end
puts sequence(:n => 5, :m => 3).to_s # => [0,3,6,9,12]
puts (sequence c:1, m:3, n:5).to_s	# => [1, 4, 7, 10, 13]





