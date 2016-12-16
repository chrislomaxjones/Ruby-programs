# Require the sieve library
require '../sieve_of_eratosthenes/source' 

# get the primes up to 1 million
primes = eratosthenes(1_000_000)

target, i, sum = 0, 0, []

while true
	target += primes[i]

	

	if primes.include? target
		sum << target
		puts target
	end

	if target >= 1_500_000
		break
	end

	i+=1
end

puts sum.to_a