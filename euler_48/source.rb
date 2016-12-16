# CORRECT SOLUTION
# => 9110846700
puts (1..1000).to_a.inject{|s,i| s + i**i}.to_s[-10, 10]