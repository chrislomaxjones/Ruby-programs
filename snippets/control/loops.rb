# While loop
x = 10
while x >= 0 do
	puts x
	x-=1
end

# Until loop
x = 0
until x > 10 do
	puts x
	x+=1
end

# While and until can be used as modifiers
x = 0
puts x+=1 while x < 10

# This does the same thing as
x = -1
while x < 10 do puts x+=1 end

# Until can also be used as a modifier
a = [1,2,3]
puts a.pop until a.empty?

x = 10
begin
	puts x
	x-=1
end until x == 0

# for/in loop
# can be performed on any object with an .each method
array = [1,2,3,4,5]
for element in array
	u = 100
	puts element
end

# variables defined in the loop continue to exist
# variables can be declared in loop and used outside
puts element
puts u

# Can be done with key value pairs of hash
hash = { a: 1, b: 2, c: 3 }
for key,value in hash
	puts "#{key} => #{value}"
end

# Implies for loops are much like iterators
# Hash output above code be rewritten as follows
hash.each do |key,value|
	puts "#{key} => #{value}"
end

# Iterators and enumerable methods
3.times { puts "Thank you" }

3.times do |x|
	puts x.to_s
end

f = [1,2,3].map { |x| x*x }
puts f.to_s

n, factorial = 5, 1
2.upto(n) { |x| factorial *= x}
puts factorial

data = ["Item 1", "Item 2", "Item 3"]
data.each { |x| puts x }

4.upto(6) {|x| print x.to_s + " \n"}

0.step(Math::PI, Math::PI/10) { |x| puts Math.sin(x) }

# Enumerable objects
[1,2,3].each { |x| print x }
puts "\n"
(1..3).each { |x| print x }
puts "\n"
("A".."Z").each { |x| print x } 

# collect executes  the code for each item in the collection
# then collects them together at the end into array
# also called map
names = ["John", "Dave", "Jean", "Bob"]
names.collect! do |name|
	name + " Doe"
end
puts "\n" + names.to_s

# Iterator which executes a block of code twice
def twice
	yield
	yield
end

# This method expects a block. It generates n values of the form
# m*i+C, from 0..n-1, and yields them, one at a time,
# to the associated block
def sequence(n, m, c)
	i = 0
	while i < n
		yield m*i + c
		i += 1
	end
end
sequence(5, 5, 1) { |y| puts y }

# Combines two arrays
def combine(collection_one, collection_two)
	if collection_one.length > collection_two.length
		long_collection, short_collection = collection_one, collection_two
	else collection_two.length > collection_one.length
		long_collection, short_collection = collection_two, collection_one
	end

	long_collection.length.times do |i|
		yield [long_collection[i], short_collection[i]] unless short_collection[i].nil?
		yield [long_collection[i]] if short_collection[i].nil?
	end
end
combine([1], [2,3]) { |x| puts x.to_s }

# Generate n points evenly spaced around the circumference of a circle
# of radius r centre (0,0). Yield x and y coords
def circle(r, n)
	n.times do |i|
		angle = Math::PI * 2 * 2 * i / n
		yield r*Math::cos(angle), r*Math::sin(angle)
	end
end
circle(1, 4) { |x,y| puts "x:" + x.to_s + " y:" + y.to_s }

# Improved sequence code
def sequence_two(n, m, c)
	i, s = 0, []
	while i < n
		y = m*i + c
		yield y if block_given?
		s << y
		i += 1
	end
	s
end
puts sequence_two(5, 5, 1).to_s

data = [10,20,30,40,50]
puts data.to_enum.to_s




























