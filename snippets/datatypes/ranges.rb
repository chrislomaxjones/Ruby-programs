# Ranges represent the values between start and end value

# two dots is inclusive
a = 1..10 # -> 1 - 10

# three dots is exclusive at the end
b = 1...10 # -> 1 - 9

#include? method checks if value is included in range
# Get a year from the user
values = 1..10

# Output whether in range
puts values.include? 2 # -> true
puts values.include? 11 # -> false

# Can also be done with strings
r = 'a'..'c'
r.each { |l| print "#{l}"} # -> [a, b, c]
r.step(2) { |l| print "#{l}" } # -> [a, c]
r.to_a # -> ['a', 'b', 'c']

# Can be converted to arrays
# Remember parentheses
some_array = (1..10).to_a
puts some_array.to_s

# Testing range membership
triples = "AAA".."ZZZ"
puts triples.include? "ABC" # -> true; fast in 1.8 and slow in 1.9
puts triples.include? "ABCD" # -> true in 1.8, false in 1.9 ??? 2+??
puts triples.cover? "ABCD" # -> true and fast in 1.9
puts triples.to_a.include? "ABCD" # -> true and slow in 1.8 and 1.9

