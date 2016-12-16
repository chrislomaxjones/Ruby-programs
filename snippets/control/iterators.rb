enumerator = 3.times
enumerator.each { |x| puts x }

puts "hello".each_byte.to_a.to_s

def twice
	if block_given?
		yield
		yield
	else
		self.to_enum(:twice)
	end
end
twice { puts "Done twice" }

iterator = 9.downto(1)
begin
	print iterator.next while true
rescue StopIteration
	puts "...blastoff"
end

