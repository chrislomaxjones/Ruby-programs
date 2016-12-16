# 1.9 adds a curry method to Proc class
# Calling this method returns a curried Proc / lambda
# When a curried Proc / lamda is invoked with insufficient args
# it returns a new Proc object with the given args applied
# Currying is a common technique in functional programming

# Define a lambda
product = ->(x,y) { x*y }

# Curry it, and specify the first arg
triple = product.curry[3]

# Call the lambda with insufficient args 
# observe result
puts triple[10], triple[30] # => 30, 90




# My attempt
fractional_power = ->(y,x) { x**(1.0/y) }

puts fractional_power[2,100] # => 10.0
puts fractional_power[3,27] # => 3.0

sqrt =  fractional_power.curry[2]
puts sqrt[100] # => 10.0
puts sqrt[25] # => 5.0




# My next attempt
midpoint = ->(x1,y1,x2,y2){ [(x1+x2)/2.0,(y1+y2)/2.0] }
puts midpoint[2,4,6,8].to_s # => [4.0, 6.0]

midpoint_with_centre = midpoint.curry[0.0,0.0]
puts midpoint_with_centre[20,4].to_s # => [10.0,2.0]