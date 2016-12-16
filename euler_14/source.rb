# CORRECT SOLUTION
# => 837799

# Iterative collatz sequence rules
# n → n/2 (n is even)
# n → 3n + 1 (n is odd)

x, longest_chain, largest_x = 1, 0, 0
while x <= 1_000_000
  n, chain_count = x, 1
  
  while n != 1
    if n % 2 == 0 # n is even
      n = n/2
    else  # n is odd
      n = 3*n + 1
    end
    chain_count +=1  
  end
    
  if chain_count > longest_chain
    longest_chain = chain_count
    largest_x = x
  end
  
  x+=1
end
  
p largest_x