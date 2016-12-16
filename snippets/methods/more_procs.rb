# the arity of a Proc or lambda is the no of args it expects
# .arity can be used to find the arity

puts ->{}.arity # => 0 arguments
puts ->(x){}.arity # => 1 argument
puts ->(x,y){}.arity # => 2 arguments

# If the proc accepts an arbitrary no of args with splats
# then this becomes more confusing...
# it will return the no of arguments in the form -n-1
# this is the one's complement of n and can be inverted with ~
puts a = ->(x, *args){}.arity # => -2
# -n-1 = -2
# -n = -1
# n = 1
puts ~a # => 1
# This means at least one argument is required

# Proc class defines == method to determine whether Procs are equal
# Having the same source code does not make 2 Procs equal
puts ->(x){x**2} == ->(x){x**2}	# => false

# == only returns true if one Proc is clone or dup of another
p = ->(x){x**2}
q = p.dup
puts p == q # => true
puts p.object_id == q.object_id # => false