# CORRECT SOLUTION
# => 76576500

# Import the prime sieve
require '../sieve_of_eratosthenes/source'

# Return the triangle number with term k
def triangle(k)
    k*(k+1)/2
end

# Get the first 500 primes
# We only need the first 500
Primes = eratosthenes(500)

# Find the number of divisiors for integer n
def find_divisiors(n)
    # Find the primes up to n
    primes, product, exponents = Primes, 1, []

    # For each prime
    primes.each do |p|
        # Create a copy of n and attempt to divide evenly by prime number
        n_copy, exponent = n, 0
        while n_copy % p == 0
            # Divide n_copy by p and store in n_copy
            n_copy /= p
            # Increase the exponent
            exponent+=1
        end
        # Append this exponent to the array of exponents
        exponents << exponent if exponent > 0
    end
    
    # Multiply together the product of the exponents array
    # +1 to each element
    # product = no of divisiors
    exponents.each { |e| product *= (e+1) }
    
    product # Return product
end

# Start the loop at one
x = 1
loop do
    # Break from the loop if a triangle with > 500 divisiors found
    break if find_divisiors(triangle(x)) > 500
    # Otherwise increment x by 1 and repeat
    x+=1
end
# Once loop has been broken, output the triangle with term x
puts triangle(x)


























