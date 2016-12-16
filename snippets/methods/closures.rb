# Look at this mate
def multiply(n)
  ->(x){x*n}
end

double,triple = multiply(2), multiply(3)
d = [1,2,3].collect &double # => [2,4,6]
t = [1,2,3].collect &triple # => [3, 6, 9]
puts d.to_s, t.to_s

# Define a getter and setter attribute
def attribute(initial=nil)
  value = initial
  getterX = ->(){ value }
  setterX = ->(new) { value = new }
  [getterX, setterX]
end

get, set = attribute(20) # => Set an initiial value of 20
puts get[] # => 20
set[200]
puts get[] # => 200

# Closures and bindings
# Proc class defines a method called binding
# Returns a Binding object that represents the bindings in effect
# we can usew the eval function 
def add(n)
  ->(x){x+n}
end

# Here we define a lambda with binding n=20
addsome = add(20)
puts ([1,2,3].map &addsome).to_s # => [21, 22, 23]

# The eval method allows us to change the value of n
addsome.binding.eval("n=40")

# Now the operation is different
puts ([1,2,3].map &addsome).to_s # => [41, 42, 43]

# Here's another method
def prefix(pre)
  ->(x){ pre + x }
end

# Set a prefix and output
prefix_string = prefix("Hello ")
puts (["world", "england", "christ"].collect &prefix_string).to_s
# => ["Hello world", "Hello england", "Hello christ"]

# Now redefine the prefix
prefix_string.binding.eval "pre=\"Goodbye \""
puts (["world", "england", "christ"].collect &prefix_string).to_s
# => ["Goodbye world", "Goodbye england", "Goodbye christ"]









































