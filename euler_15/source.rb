# CORRECT SOLUTION
# => 137846528820
def factorial(x)
  raise ArgumentError, "Argument must be positive integer" if !(x.is_a? Integer) || x < 0
  return 1 if x == 1 || x == 0
  return x * factorial(x-1)
end

def n_choose_r(n,r)
  factorial(n)/(factorial(r)*factorial(n-r))
end

def square_lattice(side_length)
  n_choose_r(2*side_length, side_length)
end

# This should be the solution to a 20x20 grid
puts square_lattice(20) # => 137846528820
