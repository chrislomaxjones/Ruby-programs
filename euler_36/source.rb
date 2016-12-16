# CORRECT SOLUTION
# => 872187
x = sum = 0
sum+=x if x.to_s == x.to_s.reverse && x.to_s(2) == x.to_s(2).reverse while (x+=1) < 1_000_000
puts sum