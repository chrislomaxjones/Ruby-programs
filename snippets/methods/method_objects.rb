# We can get a method object like this
o = Object.new
to_string = o.method(:to_s)
puts to_string.call # => #<Object:0x8716f94>

# Create a simple class to show it
class Hello
	def greet
		"Hello world"
	end
end

# Store a reference to new Hello object in hey
hey = Hello.new
# Output return of .greet method
puts hey.greet #=> "Hello world"

# Store the method in a method object
greet = hey.method(:greet)
puts greet[] # => "Hello world" (note the intentional lambda-like syntax)

# You can even convert method objects to Procs
def exponent(a=1, x)
	a*(Math::E**x)
end

# Note we call this on the global "method" method
expo_proc = method(:exponent).to_proc

# We can now do Proc-like stuff to it
puts expo_proc.call(20) # => 485165195.40978974

# We can even pass it directly to a method in place of a block
# with ampersand
expos = [1,2,3].collect &method(:exponent) 
puts expos.to_s #	=> [2.718281828459045, 7.3890560989306495, 20.085536923187664]

# More methods
puts method(:exponent).name #=> "exponent"
puts method(:exponent).owner #=> "Object" (due to being global)
puts method(:exponent).receiver #=> "main" (object which method is bound)

# You can also return unbound method objects
# They return an UnboundMethod obj with no binding to method invocation
# therefore you cannot .call or [] them
unbound_plus = Fixnum.instance_method(:"+")

# Note the class of the object returned
puts unbound_plus.class # => "UnboundMethod"

# To invoke an unbound method, it must be bound to an object with the bind mehtod
plus_2 = unbound_plus.bind(2) # Bind method to object 2

# Note the class of this object now
puts plus_2.class #	=> "Method"

# This can be called
puts plus_2.call(100) # => 102

# NOTE:- name and owner work the same as for Method class.

# My attempt at this now...
append = Array.instance_method(:"<<")
append_word = append.bind(["Hello"])
puts append_word.call("World").to_s

# My second attempt??
def sum(y)
	self + y
end

some_sum = Object.instance_method(:sum)
add = some_sum.bind(20)
puts add.call(40) # => 60













