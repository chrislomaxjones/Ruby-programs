# Here is a simple method
def fibonacci(n)
	raise ArgumentError unless n.is_a? Integer
	return 1 if n == 0 || n == 1
	fibonacci(n-1) + fibonacci(n-2)
end
10.times {|x| puts fibonacci(x) }

# Here is a method that has some default values
def sub_string(s, i=0, l=1)
	s[i,l]
end
# Default values allow arguments to be omitted
puts sub_string("Hello") # => "H"puts sub_string("Hello", 4) # => "o"
puts sub_string("Hello", 1, 4) # => "ello"

# These can be expressions and not just literals
def product(a, b=a, c=b)
	a*b*c
end

# And with the whole variety of arguments
puts product(5) # => 5 * 5 * 5 => 125
puts product(5, 4) # => 5 * 4 * 4 => 80
puts product(5, 4, 3) # => 5 * 4 * 3 => 60

# You can also accept an arbitray
# number of expressions
def sum(*terms)
	terms.inject{|s,x|s+=x}
end

# We can now give any number of args
puts sum(1, 5, 7) # => 13
puts sum(1, 5, 2, 35, 542, 21) # => 606

# You can include other arguments to
def max(first, *last)
	max = first
	last.each {|n| max = n if n > max }
	max
end

puts max(20) # => max(20, []) => 20
puts max(20, 40, 30, 20) # => max(20, [40, 30,20]) => 40

# Can be in the middle > version 1.9
def replace(insert, *arr, position)
	arr[position] = insert
	arr
end
puts replace(5, 1, 1, 1, 1, 4).to_s # => [1, 1, 1, 1, 5]

# You can pass arrays to methods as well
data = [1,2]
def sum(x,y)
	x+y
end
# sum(data) # => sum([1,2]), x=[1,2] y=nil => ERROR
puts sum(*data) #=> sum(1,2) => 3

# Could also be used with method above
data = [1,2,3,4,5,6]
puts replace(200, *data, 0).to_s # => [200, 2, 3, 4, 5, 6]

# Enumerators are also splattable objects
def summation(*a)
	a.inject{|s,x|s+=x}
end
# Therefore we could do this
puts summation(*(1..100).each) # => 5050

# We can also pass a sick hash as arguments
def y(args)
	m, x, c = args[:m] || 1, args[:x] || 1, args[:c] || 0
	m*x + c
end

# And pass them as a hash
puts y({m:5, x:1, c:2}) # => 7

# We can improve this by passing a bare hash
puts y(m:7, x:3, c:1) # => 22

# Or even omit the brackets
puts y m:2, x:4, c:5 # => 13



# You can also include block arguments
# These are Proc objects that contain blocks of code
# These blocks are executed with the .call method
def thrice(&b)
	b.call
	b.call
	b.call
end

# The method invocation is the same as normal
thrice { puts "Hello three times"}

# You can pass Proc objects specifically as well
# there's more on Procs in another file btw...
def geometric(a, r, n, b)
	s, i = [], 0
	i.upto(n) do |x|
		t = a*(r**(x-1))
		b.call t
		s << t
	end
	s
end

# We decalre a Proc
out = Proc.new {|x| puts x }

# And pass it without ampersand to the method
geometric(5, 2, 5, out)

# The order of parameters gets interesting now...

# See this combined with a hash
def scores(players_scores, &b)
	players_scores.each do |player, score| 
		b.call [player,score]
	end
end

# And here we go...
# Note the hash params and associated block
scores(John: 12, Harry: 6) do |p,s|
	puts "Player #{p} has score #{s}"
end

# We can also use block arguments with splatted arguments
def foobar(foo, *bar, &b)
	bar.each {|i| b.call (foo + " " + i) }
end

foobar("Hello", "England", "America", "Scotland") {|x| puts x } 
# =>	Hello England
#   	Hello America
# 	 	Hello Scotland

# You can use & in method invocation as well 
a, b = [1,2,3], [40, 50]
summation = Proc.new {|t,x| t+x }
puts sum = a.inject(0, &summation) # => 6
puts b.inject(sum, &summation) #=> 96

# You can also use some fuckin weird hash thing
# I'll probably never even use this
words = ['and', 'but', 'car']
uppercase = words.map &:upcase
puts uppercase.to_s # => ["AND", "BUT", "CAR"]

# This is the same as
words = ['for', 'who', 'duh']
uppercase = words.map {|w| w.upcase }
puts uppercase.to_s # => ["FOR", "WHO", "DUH"]
