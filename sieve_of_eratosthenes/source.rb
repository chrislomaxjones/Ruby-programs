def eratosthenes(limit)
	# Instantiate an array of consecutive integers 2 through to the limit
	n = [nil, nil, *(2..limit)]
	p = 2

	# Iterate through all values of p
	while p <= Math.sqrt(limit)

		# Set c to double p
		c = 2*p

		# Iterate through all values of c up to limit
		while c <= limit
			# Set multiples of p to nil (not including p)
			n[c] = nil
			# Increment c by p
			c += p
		end
		# Increment p by 1
		
		p+=1
	end

	# Return n without nils
	n.compact
end

puts eratosthenes(10000)