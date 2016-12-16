# Blocks must follow a method invocation
# If a method does not yield, then the block is ignored
# Delimited by do/end keywords or curly braces

# These both print the numbers 1 to 10
1.upto(10) { |x| puts x }

1.upto(10) do |x|
	puts x
end
# Convetion - curly braces if block fits on one line.
# 			- do/end if extends over multiple lines.


# Parameters of block enclosed in ||
# Mutliple parameters separated by commas
hash = { :one => 1, :two => 2, :three => 3 }
hash.each do |key,value|
	puts "#{key}: #{value}"
end

[1,2,3].collect do |x|
	next 0 if x == nil
	next x, x*x
end

[1,2,3].collect do |x|
	if x == nil
		0
	else
		[x, x*x]
	end
end

# Variables defined in a block exist only in the block
# Variabled defined outside a block can be accessed inside a block
total = 0
[1,2,3,4,5].each do |x|
	total+=x
end
puts total.to_s

# Parameters separated with semicolons are local 
x = y = 0
1.upto(4) do |x;y|
	y = x+1
	puts y * y
end
puts [x,y].to_s

# Passing arguments to a block
def two
	yield 1, 2
end
two { |x,| puts x.to_s } # => 1
two { |*x| puts x.to_s } # => [1,2]