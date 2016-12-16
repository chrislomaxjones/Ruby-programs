# CORRECT SOLUTION
# => 142913828922

# Load the sieve from another project
require '../sieve_of_eratosthenes/source'

puts eratosthenes(2_000_000).inject { |sum,x| sum + x }








































