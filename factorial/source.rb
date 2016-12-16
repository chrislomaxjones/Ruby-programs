# Recursive function determines the factorial of argument x
def factorial(x)
    raise ArgumentError if (! x.is_a? Integer) || x < 0
    return 1 if x == 1 || x == 0
    x * factorial(x-1)
end

p factorial(5)
p factorial(-100)