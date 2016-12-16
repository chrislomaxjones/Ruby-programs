prime, prime_counter, x, sum = true, 1, 2, 0

puts "Enter number of primes"
limit = gets.chomp.to_i

loop do
    break if prime_counter > limit
    
    (2..(x-1)).each do |y|
        prime = false if x % y == 0
    end
    
    unless prime then prime = true
    else
        puts "prime number #{prime_counter}: #{x} is a prime // Current sum: #{sum}"
        sum += x
        prime_counter += 1
    end
    
    x+=1
end

puts "Sum of primes first #{limit} primes is #{sum}"