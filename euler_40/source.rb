# CORRECT SOLUTION
# => 210

# Generate the long irrational constant
# Treat as a string
# There's actually no need to include the decimal point
# As this messes with indexing later
counter, product, decimal_string = 0,1,"0"
1.upto(1_000_000) do |n|
  decimal_string << n.to_s
end

# Find the product
1.upto(6) {|i| product *= decimal_string[10**i].to_i }

# Output the product
puts product