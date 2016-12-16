# CORRECT SOLUTION
# => 1366

puts (2**1000).to_s.each_char.inject { |s,x| s.to_i + x.to_i }