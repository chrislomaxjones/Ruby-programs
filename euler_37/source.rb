# For a prime to be truncatable, it must only contain digits 1, 3, 7, 9
# 2, 3, 5, 7 are not considered truncatable

require '../sieve_of_eratosthenes/source'


# Generate some primes
# Remove unsuitable ones
sum, primes = 0, []
eratosthenes(1_000_000).each do |prime|
    acceptable = true
    if prime.to_s.length == 1
      acceptable = false
    else
      prime.to_s.each_char do |char|
          acceptable = false if not ["1", "3", "7", "9"].include? char
      end
    end
    primes << prime if acceptable
end

# Determine if each prime is truncatable
primes.each do |prime|
  is_truncatable = true
  
  str = prime.to_s
  (str.length-1).times do |i|
    str[0] = ""
    is_truntable = false unless primes.include? str.to_i
  end
  
  str = prime.to_s
  (str.length-1).times do |i|
    str[-1] = ""
    is_truncatable = false unless primes.include? str.to_i
  end
  
  p "#{prime} is #{is_truncatable}"
  
  sum += prime if is_truncatable
end
  
p sum