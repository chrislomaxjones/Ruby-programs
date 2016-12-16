# CORRECT SOLUTION
# => 25164150
puts (1..100).inject{|sum,x| sum + x}**2 - (1..100).inject{|sum,x| sum + x**2 }