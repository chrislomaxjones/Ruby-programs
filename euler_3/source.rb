# CORRECT SOLUTION
# => 6857
def find_largest_prime_factor(a)
    b, c = 2, 0
    while a != 1
        if a % b == 0
            a/= b
            c = b
            b = 2

            
        else
            b+=1
        end

        puts "a: #{a}"
            puts "b: #{b}"
            puts "c: #{c}"
        
    end
    c
end
puts find_largest_prime_factor(100)
puts find_largest_prime_factor(600851475143)