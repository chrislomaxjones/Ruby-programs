# Below are 2 lambdas
# They both do the same thing
succ_1 = lambda { |x| x+1 }
succ_2 = ->(x){ x+1 }

# can be called the usual way
succ_2.call(2) # => 3

# Can include declaration of local variables
# which definitely override globals
f = ->(x,y; i,j,k) { }

# Can also be declared with argument defaults
zoom = ->(x,y,factor=2) { [x*factor, y*factor] }

# Lambdas do not have to take arguments
a = -> { }

# This syntax is helpful for passing a lambda as an argument to method etc
def compose(f,g)
  -> (x) { f.call(g.call(x)) }
end
succOfSquare = compose(->x{x+1}, ->x{x*x})
puts succOfSquare.call(4) # => 17; computes (4*4)+1

# My personal lambda swag
power = ->(x,n=1){ x**n }
def powers(vals, p)
  new_vals = []
  vals.each_with_index do |val,i|
    new_vals << p.call(val,i)
  end
  new_vals
end
puts powers([1,2,3,4,5], power).to_s

# Lambda literals and block comparison
[1, 2, 3].sort { |a,b| b-a } # The block version
[1, 2, 3].sort &->(a,b) { b - a} # Lambda literal version

# My own juicy lambda
3.times &-> (x){ puts "Hello world #{x}" }

# Procs and lambdas are objects and not methods
# They cannot be invoked the same way methods are
# Proc.new declares a new proc object with parameters and a block
f = Proc.new { |x,y| 1.0/(1.0/x + 1.0/y) }
# Call executes the block, accepts arguments and returns the block value
z = f.call(100,200)
# Return value store in z and output
puts z.to_s

# Array access operator of proc class aslo designated to act as call
z = f[100,200] # same as above
# or...
z = f.(100,200)

# When a curried proc or lambda is invoked with insufficient arguments,
# it returns a new Proc object with the given arguments applied.
product = -> (x,y) { x*y } # Define a lambda
triple = product.curry[3] # Curry it, then specify first argument
puts triple[4].to_s # => 3 * 4 = 12

# My own curry goodness
area_of_triangle = -> (c, b, a) { 0.5 * a * b * Math::sin(c.to_f/180.0*Math::PI) }
area_of_equi_triangle = area_of_triangle.curry[60]
puts area_of_equi_triangle[10, 10]

# Arity of a proc
# Arity = no of arguments it expects
# .arity returns no of expected args
puts ->{}.arity # => 0
puts ->(x){ x }.arity # => 1
puts lambda {|x,y| x*y }.arity # => 2

# Note this returns the one's compliment if splat is used
puts ->(*args) { puts args.to_s }.arity # => -1
# use ~ bitwise op to deduce actual required no of arguments
puts ~->(*args) { puts args.to_s }.arity # => 0 required args
puts ~->(first, *args) { }.arity # => 1 required arg

# Proc class defines == method
# Only true if Procs are clones / duplicates of each other
p = lambda { |x| x*x }
q = p.dup
puts "Look it works!" if p == q # This doesn't work find out why
puts "They are not the same object" unless p.object_id == q.object_id

# You can determine whether a Proc or lambda with .lambda? method
a,b = Proc.new {}, ->{}
puts "a is a Proc" unless a.lambda? # => returns false for Procs
puts "b is a lambda" if b.lambda? # => returns true for lambdas

# Return in blocks, procs, lambdas
# A block returns from the method that invokes the iterator
def stop_at_nil(*vals)
  vals.each do |x|
    return if x.nil?
    puts x
  end
  puts "No nils detected."
end
stop_at_nil(30, 40, nil, 50) # => 30...40 note no "No nils detected." print

# If you return from within a Proc, it does the same
def test
  puts "Enter method"
  p = Proc.new { puts "Enter proc"; return }
  p.call
  puts "Exiting method" # => this line is never executed
end
test

# Procs can get tricky when they're passed around between methods
def proc_builder(message) # Create and return a proc
  Proc.new { puts message; return } # Return returns from proc_builder
  # but proc_builder has already returned here
end

def test_two
  puts "Enter method"
  p = proc_builder("entering proc")
  # p.call - raises localJumpError
  puts "Exiting method" # => this line is never executed
end
test_two

# A return statement in a lambda returns from the lambda
# Work more like methods than blocks
def test_three
  puts "Enter method"
  p = ->{ puts "Entering lambda"; return }
  p.call
  puts "Exiting method"
end
test_three

# We don't have to worry about localJumpError
def lambdaBuilder(message)
  ->{ puts message; return }
end

def test_four
  puts "Entering method"
  l = lambdaBuilder("entering lambda")
  l.call
  puts "Exiting method"
end
test_four

# Breaks in procs, blocks, lambdas

# By the time we invoke a proc with a break in the body...
# it has already returned
def test
  puts "Entering test method"
  proc = Proc.new { puts "Entering proc"; break }
  proc.call # => localJumpError - iterator has already returned
  puts "Exiting test method"
end

# Creating a proc with an & argument to the iterator method,
# then we can invoke it and make iterator return
def iterator(&proc)
  puts "Entering iterator"
  proc.call # invoke proc
  puts "Exiting iterator" # Never executed if the Proc breaks
end
def test_five
  iterator { puts "Entering proc"; break }
end
test_five

# Lambdas are method-like, so putting a break statement
# at the top level of a lambda, it doesn't make sense
# just acts like return
def test_six
  puts "Entering test method"
  lambda = ->{ puts "Entering lambda"; break; puts "Exiting lambda" }
  lambda.call
  puts "Exiting test method"
end
test_six

# Argument passing to procs
p = Proc.new { |x,y| print x,y }
p.call(1) # => x,y = 1 // nil used for missing y
p.call(1,2) # => x,y = 1,2
p.call(1,2,3) # => x,y = 1,2 // extra val discarded
p.call([1,2]) # => x,y = [1,2] // array automatically unpacked

# Lambdas however must be invoked with the precise no of methods
l = ->(x,y) { print x,y }
l.call(1,2) # Works
begin
  l.call(1) # Nope
  l.call(1,2,3) # Nope
  l.call([1,2]) # Nope
rescue ArgumentError
  puts "See they raised an error!"
end
l.call(*[1,2]) # Works - array unpacked by splat


