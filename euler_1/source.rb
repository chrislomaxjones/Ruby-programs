# CORRECT SOLUTION:
# => 233168
x = sum = 0
while x < 1000
    sum+=x if x%5 == 0 || x%3 == 0
    x+=1
end
puts sum