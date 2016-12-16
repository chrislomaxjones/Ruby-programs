[1,2,3].each {|x| puts x}
(1..3).each {|x| puts x}

File.open('iterators.rb') do |f|
  f.each {|line| print line}
end

File.open('iterators.rb') do |f|
  f.each_with_index do |line,number|
    puts "#{number+1}: #{line}"
  end
end

# Collect (also known as map)
# Executes the block for each element and collects results
squares = [1,2,3,4].collect {|x| x*x}
puts squares.to_s # => [1,4,9,16]

# Select invokes block on elements and returns an array
# of elements for which the block returns value other than
# false or nil
evens = (1..10).select {|x| x%2==0}
puts evens.to_s # => [2,4,6,8,10]

# Reject returns elements for which block returns false or nil
odds = (1..10).reject {|x| x%2==0}
puts odds.to_s # => [1,3,5,7,9]

# Inject allows for accumulated value
data = [2,5,3,4]
sum = data.inject{|sum,x| sum + x } # => 14
product = data.inject{|prod,x| prod * x } # => 120
max = data.inject{|max,x| max>x ? max : x } # => 5 (largest element)
puts sum, product, max

# Simple iterators
# Yield a sequence
def sequence(a, d, n)
  s, i = [], 0
  while i < n
    t = a+(d*i)
    yield t if block_given? # Tests whether supplied with a block
    s << t
    i+=1
  end
  s
end
# Note use of supplied block
sequence(0, 2, 10) { |x| puts x }
# Can also be used without a block
puts sequence(0,2,10).to_s

# Here is another iterator method
# Note the use of an internal iterator
def circle(r,n)
  n.times do |i|
    angle = Math::PI * 2 * i / n
    yield r*Math.cos(angle), r*Math.sin(angle)
  end
end
circle(1,4) {|x,y| puts "(#{x.to_i},#{y.to_i})" }

# Enumerators
# Example usage
[1,2,3,4].to_enum

# Another example
puts "hello".enum_for(:each_char).map {|c| c.succ}.to_s

# Lets break this down...
# Say we want to use a method like map on a string but can't
# we convert the each_char iterator method to an enumerator object
e = "hello".enum_for(:each_char)
# Then we pass that an iterator method
e.map
# Which we can pass a block
e_mapped = e.map {|c| c.succ} 
# Which we can output
puts e_mapped.to_s # => ["i", "f", "m", "m", "p"]


# .to_enum and .enum_for are actually uncessecary
# Iterators return a block object
# This is more natural
puts "hello world".each_char.map {|c| c.succ}.to_s

# More examples
enumerator = 3.times
enumerator.each {|x| puts x} # => 0, 1, 2

# downto returns an enum with a select method
puts 10.downto(1).select {|x| x%2==0}.to_s #=> [10, 8, 6, 4, 2]

# each_byte returns an enumerator with a to_a method
a = "hello".each_byte.to_a
puts a.to_s # => [104, 101, 108, 108, 111]


# You can replicate this behavior with your own iterators
def twice
  if block_given?
    yield
    yield
  else
    self.to_enum(:twice)
  end
end
twice.each{ puts "Hi"}

# .with_index returns an enumerator
# that adds an index param to an iteration
enumerator = "Hello".each_char.with_index{|x,i| puts "#{i}:#{x}"}

# Enumerators are enumerable objects...
# that can be used in a for loop
for char,number in "Helloooo".each_char.with_index
  puts "#{number}:#{char}"
end

# External iterators
# You can loop through the elements of a collection 
# by repeatedly calling the .next method
iterator = 9.downto(1)
begin
  print iterator.next while true
rescue StopIteration
  puts "...Blastoff!\n"
end

# Here's one i wrote!
hello = "Hello there world".each_char.with_index
loop do
  puts "0 for next char, anything else restarts..."
  i = 0 # gets.chomp.to_i
  if i == 0
    char, index = hello.next
    puts "#{index}:#{char}"
  else
    hello.rewind
  end
end

# How to create an external iterator
module Iterable
  include Enumerable
  def each
    loop do
      yield self.next
    end
  end
end

# You can use an external iterator to pass it
# to an internal iterator method
def iterate(iterator)
  loop do 
    yield iterator.next
  end
end

iterate(9.downto(1)) {|x| print x}

# ...









