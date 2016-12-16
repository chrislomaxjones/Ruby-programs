# Procs are blocks that have identifiers

def sequence(n, m, c, &b)
	i = 0
	while(i < n)
		b.call(i*m+c)
		i+=1
	end
end
sequence(3,5,6) { |x| puts x }

# Proc could also be passed explicitly
def sequence_2(n, m, c, b)
	i = 0
	while i < n
		b.call(i*m+c)
		i+=1
	end
end
p = Proc.new { |x| puts x }
sequence_2(3,5,6,p)

# The block must always be passed at the end
# Pass args as a hash and then follow with a block
def sequence_3(args, &b)
	i, n, m, c = 0, args[:n], args[:m], args[:c]
	while i < n
		b.call(i*m + c)
		i += 1
	end
end

# Expects one or more arguments followed by a block
def max(first, *rest, &block)
	top = first
	rest.each do |value|
		top = value if value > top
	end
	block.call(top)
	top
end

# NOTE: Yield can still be used in these methods.
a,b = [1,2,3], [4,5]
sum = a.inject(0) { |total, x| total+x }
sum = b.inject(sum) { |total, x| total+x }
puts sum

summation = Proc.new { |total, x| total + x}
sum = a.inject(0, &summation)
sum = b.inject(sum, &summation)
puts sum

# Prefixing a symbol after an enum has interesting effect
words = ['and', 'but', 'car']
uppercase = words.map &:upcase
puts uppercase.to_s # => ['AND', 'BUT, 'CAR']

# This does the same as below
uppercase = words.map { |word| w.upcase }





