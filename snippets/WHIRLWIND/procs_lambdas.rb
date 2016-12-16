# Blocks can be passed explicity to a method as an object
def what_are_you(&block)
    puts "I am a #{block.class}!" #=> Proc object
end

what_are_you { } # => Proc

# Procs can be passed to methods and don't require &
def transform(data,code)
    data.each do |item|
        item = code.call item
    end
end

# A Proc is an object that wraps a block
square = Proc.new do |n|
    puts n**2
end

cube = Proc.new do |n|
    puts n**3
end

# Invoking a proc
transform([1,2,3,4], square)
transform([1,2,3,4], cube)

# You can include Procs as blocks
# This is done by prepending & and Proc name
[1,2,3,4].each &cube

# Using multiple procs as callback is fun
def callbacks(procs)
    procs[:start].call
    
    puts "This is the middle"

    procs[:finish].call
end

callbacks({
    :start => Proc.new { puts "Start" },
    :finish => Proc.new { puts "end" }
})

# Lambdas are similar to anonymous functions in other languages
# Lambdas can be defined in two ways
a = lambda() { puts "Hello world" }
b = ->(i) { puts "Goodbye #{i}" }

# Lambdas are very similar to Procs
def do_ten_times(lambda)
    10.times { lambda.call }
end

do_ten_times(a) # Passed as parameter to method
[1,2,3,4].each &b # Can be used like this as well

# Lambdas behave slightly differently
# They raise errors rather than nils when assigned wrong no of variables
c = ->(i) { puts "We have no variables" }
d = Proc.new() { |i| puts "We have no variables" }

begin
    c.call() # => raise error
rescue
    puts "OOSH an error"
end

d.call() # => No error

# A proc will stop a method and return the value provided
def proc_return
    Proc.new { return "New proc" }.call
    return "proc_return returning..."
end

puts proc_return # => "New proc, line 75 is never executed

def lambda_return
    ->() { return "New lambda" }.call
    return "lambda return returning..."
end

puts lambda_return # => "lambda return returning...", last line is executed

# A parameter shouldn't be able to return from a method
# But you can with a lambda
# This is tricky business
def demonstrate(code)
    code.call
end

puts demonstrate ->() { return "LOOK!" } # => "LOOK!"

begin
    puts demonstrate Proc.new { return "ERROR!" } # => This raises an error
rescue
    puts "LOOK an error"
end

# Here's some interesting behaviour I want to observe
def generic_return(code)
    one,two = 1,2
    three,four = code.call(one,two)
    "Give me a #{three} and a #{four}"
end

puts generic_return(->(x,y) { return x + 2, y + 2})

# This raises an error when we use a Proc
begin
    puts generic_return(Proc.new { |x,y| return x + 2, y + 2}) # This raises an error
rescue
end

# But if we don't explicity use the return keyword no error is raised
puts generic_return(Proc.new { |x, y| [x + 2, y + 2] })

# We can return one value which is stupid
puts generic_return(Proc.new { |x, y| x + 2; y + 2 }) # => "Give me a 3 and a"

# Let's look at method objects
# Some method
def f(x)
    x**2 + 4*x + 8
end

# Here the method is returned as a method object by global "method" method
fx = method :f
puts fx.class # => Method

# Can be called like a Proc/lambda
puts fx.call(18) # => 404

def call_up(code)
    puts code.call(100)
end

call_up(fx) # => 10408


def g(x)
    puts "Hello #{x}"
end

gx = method :g

# Can even do weird shit like this
[1,2,3,4].each &gx # Outputs "Hello 1, Hello 2 etc . . . "


# Note you can explicity 'grab' a passed block
def map(data, &b)
    data.each do |i|
        i = b.call i 
    end
end

puts map([1,2,3,4]) { |i| i**2 }

# Remember the block_given? global method
def was_i_given()
    if block_given? then puts "Yes, yes I was"
    else puts "Screw you" end
end

was_i_given { }
was_i_given

puts ->(){}.arity # => 0
puts ->(one){}.arity # => 1 
puts ->(one,two){}.arity # => 2

puts ->(*lots){}.arity # => -1

# I cant find the squiggle symbol on this windows keyboard
# So I have negated it and subtracted one
# This gives the true number of required arguments for a lambda
puts -(->(*tail){}.arity) - 1 # => 1
puts -(->(head, *tail){}.arity) - 1 # => 1


def sum(data)
    s = 0
    data.each do |i|
        s += yield i
    end
    s
end

puts "Look!", sum([1,1,1,1,1]) { |i| i*10 }

# Closures
# Objects which are both invocable functions and a variable binding for that function
# A proc / lambda not only holds the executable block but also all the variable bindings used by the block

def multiplier(n)
    ->(data) do
        data.collect { |x| x*n }
    end
end

doubler = multiplier(2)
puts doubler.call([1,2,3,4,5]).to_a.to_s # => [2,4,6,8,10]

# Here, the lambda "closes over", "binds" or "retains" the argument n

# A lambda extends the lifetime of a variable, it doesn't copy it or anything else
# Therefore when two lambdas bind to the same variable they can change its value
def accessor_pair(initialValue=nil)
    value = initialValue

    getter = ->(){ value }
    setter = ->(x) { value = x }

    return getter, setter
end

getter, setter = accessor_pair "Hello!"

puts getter[] # => Hello!
setter["Hola!"]
puts getter[] # => Hola!

# This can be a feature or source of bugs
# Be careful when creating lambdas in loop variables

# Closures and bindings
#----------------------

# Proc class defines a method named binding
# Object returned represents the binding element for that closure
# It can be supplied as the second arg to a call of eval()
# This determines the context in which to evaluate a string of ruby code

def prepend(prefix)
    ->(str) { prefix + str }
end

say_hello = prepend("Hello ")

puts say_hello.call("world") # => Hello world

# Show a Binding
puts say_hello.binding.class # => Binding

# Execute a string of ruby code in the context of say_hello's binding
# Assign a new value to the variable prefix
eval("prefix = \"Hola\" ", say_hello.binding)

puts say_hello.call("world") # => Hola World

# This is a feature non-specific to closures
# kernel.binding returns a Binding object at any point in program runtime


















