# CORRECT SOLUTION
# => 55

require '../sieve_of_eratosthenes/source'

# Method returns array of circular numbers of n
def rotations(n)
    n = original = n.to_s
    rots = [n.dup]
    
    (n.length-1).times do
        n << n[0]
        n[0] = ""
        rots << n.dup
    end
    rots.uniq
end

primes, counter = [], 0

# Trim the prime array down
eratosthenes(1_000_000).each do |prime|
    acceptable = true
    prime.to_s.each_char do |char|
        acceptable = false if not ["1", "3", "7", "9"].include? char
    end
    primes << prime if acceptable || prime == 2 || prime == 5
end

# Iterate through each prime
primes.each do |prime|
    # Initially determine its a circular
    is_circular = true
    # then prove otherwise by inspecting each rotation
    rotations(prime).each do |rotation|
        # determine its not circular if the rotation is not in the primes array
        is_circular = false unless primes.include? rotation.to_i
    end
    # Increment the counter if its circular
    counter += 1 if is_circular
end

# Output the counter value
p counter
