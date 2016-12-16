# CORRECT SOLUTION
# => 648

# Require the factorial function
require '../factorial/source'

sum = 0
factorial(100).to_s.each_char { |c| sum += c.to_i }
puts sum