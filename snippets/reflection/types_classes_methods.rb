# The most commonly used reflective methods are those for determining the type
# of an object. - what class it is an instance of and what methods it responds to

o = "Hello world"

p o.class # => String (returns class of object o)

p o.class.superclass # => Object (returns superclass of class c)

p o.instance_of? String # => true (determines whether o.class == String)

p o.is_a? String # => true 
# Determines whether o is an instance of class String, or any of its subclasses
# If the class object is a module, this tests whether o.class has module c included

p o.kind_of? String # => true (synonym for is_a?)

p String === o # => o.is_a?(String)

p o.respond_to? "split" # => true
# Determines whether the object has a public or protected method with the specified
# name. Pass true as the second argument to check private methods as well.


# Ancestry and Modules
#---------------------
module A
end

module B
  include A
end

module C
  include B
end

p C < B # => true: C includes B
p B < A # => true: B includes A
p C < A # => true

p Fixnum < Integer # => true
p Integer < Comparable # => true
p Integer < Fixnum  # => false
p String < Numeric # => false

p A.ancestors # => [A]
p B.ancestors # => [B,A]
p C.ancestors # => [C,B,A]
p String.ancestors # => [String, Comparable, Object, Kernel, BasicObject]

p C.include? B # => true
p C.include? A # => true
p B.include? A # => true
p A.include? A # => false
p A.include? B # => false

p A.included_modules # => []
p B.included_modules # => [A]
p C.included_modules # => [B, A]

# A method related to the private include is Object.extend
# This method extends an object by making the instance methods of 
# each of the specified modules into singleton methods of the object
module Greeter
  def hi
    "Hello"
  end
end

s = "String Object"
s.extend Greeter
p s.hi # => "Hello"
String.extend Greeter
p String.hi # => "Hello"

# The class module Module.nesting is not related to model inclusion
# it returns array that specifies the nesting of modules at the current location
module M
  class C
    puts Module.nesting.to_s # => [M::C, M]
    module MM
      puts Module.nesting.to_s # => [M::C::MM, M::C, M]
    end
  end 
end

# Defining classes and modules
#-----------------------------

# Classes and modules can be created dynamically
M = Module.new # Define module M
C = Class.new  # Define class C
D = Class.new(C) { include M } # Define subclass of C including module M

# Evaluating strings and blocks
# eval() is a very powerful ruby function
# eval() executes a string of ruby code
x = 1
p eval "x + 1" # => 2

# Bindings and eval
#------------------

# A binding object represents the state of Ruby's variable bindings at some moment
# The kernel.binding object returns the bindings in effect at the location of the call
# You may pass a binding object as 2nd arg to eval, and the string you specify will
# be evaluated in the context of those bindings.
class Object    # Open Object to add a new method
  def bindings  # Note plural on this method
    binding     # This is the predefined kernel method
  end
end

class Test  # A simple object with an instance variable
  def initialize(x)
    @x = x
  end
end

t = Test.new(10)       # Create new test object
p eval("@x", t.bindings) # => 10: We've peeked inside t

# instance_eval and class_eval
#-----------------------------

# ....