# In ruby, procs and lambdas ARE closures
# Note that blocks can access variables outside their scope
def multiply(data,n)
    data.collect { |x| x*n }
end
puts multiply([1,2,3], 2).to_s

# If block were turned into proc or lambda,
# it could access n after the method to which 
# it was an arg has returned
def multiplier(n)
    ->(data){ data.collect { |x| x*n } }
end
doubler = multiplier(2) # Gets a lambda that knows n=2
puts doubler.call [1,2,3] # => prints 2, 4, 6

# Here I practice it myself
def exponent(constant, time)
    ->(x_points) do
        x_points.collect do |x|
            Math::E**(x*constant*time)
        end
    end
end
fixed_expo = exponent 1, 2
puts fixed_expo.call [1, 2, 3, 4]

# Closures and shared variables
# Closures do not retain the value of variables,
# they actual retain the variable and extend its lifetime

def accessor_pair(initial_value=nil)
    value = initial_value
    getter = ->{ value }
    setter = ->(x){value=x}
    return getter, setter
end
getX, setX = accessor_pair(0)
puts getX[] # => 0
setX[10]
puts getX[] # => 10

# Anytime a method has > 1 closure,
# attention should be paid to the variables they use
def multipliers(*args)
    x = nil
    args.map { |x| ->(y){ x*y } }
end

doubles,triples = multipliers(2,3)
puts doubles.call(2) # This works nicely...

# Closures and bindings
# Proc class defines methods for bindings
# a binding holds all information necessary to execute a method
# use of binding and eval allows us a back door through which,
# behavior of a closure can be manipulated
def multiplier(n)
    ->(data){ data.collect { |x| x*n} }
end

doubler = multiplier(2)
puts doubler.call [1,2,3]

# Now suppose we went to alter behaviour of the doubler
doubler.binding.eval("n=3")
puts doubler.call [1,2,3]

# Now lets try it ourselves
def add_constant(constant)
    ->(data) { data.collect { |x| x+constant } }
end
adder = add_constant(100)
puts adder.call([1,2,3]).to_s # => 101, 102, 103
adder.binding.eval("constant=400")
puts adder.call([1,2,3]).to_s # => 401, 402, 403
    







