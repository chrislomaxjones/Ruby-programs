# This a whirlwind of the ruby programming language.
# I'm doing this to prepare for a cambridge interview
# stay tuned...

# Iterators are a noteworthy feature of Ruby
3.times do
	puts "Hello world..."
end

# Single-line iterators commonly use curly braces
# Although this is not strict only convention
factorial = 1
1.upto(10) { |x| factorial *= x } 
puts factorial

# Note that iterators don't have to be about iterating
# They can be about enumerating
[1, 2, 3].each do |i|
	puts "Numero: #{i}"
end

[1,2,3].map do |i|
		i**2
end

# This is how to write an iterator
def twice
	yield
	yield
end

# This is how to use an iterator
twice do
	# The code in this do ... end block is executed twice
	puts "this gets done"
end

# You can even pass parameters
def compliment(names)
	names.each do |name| # Note the use of a block in the method
		yield "Nice hat " + name + "!"
	end
end

compliment ["Alex", "Bob", "Charlie", "David"] do |c|
	puts c
end

# You can return > 1 parameter
# This method really demonstrates the power of the Ruby programming language
def powers(values, max)
	values.each do |v|
		powers = (1..max).to_a.map do |i|
			v**i
		end
		yield *powers
	end
end

# And here it is being passed a block
powers([1,2,3,4], 3) do |m,n,o|
	puts "#{m} / #{n} / #{o}"
end

# We can even check if the method was passed a block
def were_we_given_a_block?
	if block_given?
		"WE GOT A BLOCK"
	else
		"WE DIDN'T GET A BLOCK"
	end
end

puts were_we_given_a_block? { 1 } # => "WE GOT A BLOCK"
puts were_we_given_a_block? 	  # => WE DIDN'T GET A BLOCK"

# It seems as though you can store iterators in objects
a = [1,2,3].each

# Next method calls on object returns parameter
loop do
	puts a.next
end

# External iterator can be rewound to the start
a.rewind
puts a.next

# You could even create an iterate method like this
def iterate(iterator)
	loop do
		yield iterator.next
	end
end

# Here is the method call with the block construct
iterate(1.upto(10)) { |i| puts i }

# Here shows some cool things you can do with block parameters
def two
	yield 1, 2
end

# Note this weird behavior
two { |x| puts x } # => 1
two { |*x| puts x } # => [1,2]
two { |x,| puts x } # => 1

def five
	yield 1, 2, 3, 4, 5
end

five do |head, *body, tail|
	puts "#{head} and #{body} and #{tail}" # => 1 and [2, 3, 4] and 5
end

# You can even do weird lambda shit
printer = ->(&b){ puts "Calling... #{b.call}" }
printer.call { "HELLO G" }

 















