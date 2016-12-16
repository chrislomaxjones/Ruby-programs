# Procs.new is the iterator that break would return from
# By the time we invoke the proc obj, the iterator
# has already returned
# therefore it never makes sense to have a top-level
# break statement in a proc created with Proc.new
def test
	puts "Entering method"
	p = Proc.new { puts "Entering Proc"; break }
	begin 
		p.call # => LocalJumpError
	rescue 
		puts "We got an error breaking!" 
	end
	puts "Exiting method"
end
test

# If we create a proc object with & argument to an 
# iterator method, then we can invoke it and make
# the iterator return
def iterator(&proc)
	puts "Entering iterator"
	proc.call
	puts "Exiting iterator" # This code is never executed
end

def test2
	iterator { puts "Entering proc"; break }
end
test2

# Lambdas are method-like, so break doesn't make sense!
# break just acts like return
# note "Exiting lambda" is never printed in code below
def test3
	puts "Entering test method"
	l = ->{ puts "Entering lambda"; break; puts "Exiting lambda" }
	l.call
	puts "Exiting test method"
end
test3

# OTHER CONTROL STATEMENTS IN PROCS AND LAMBDAS
#----------------------------------------------

# NEXT
#-----
# a next statement causes the yield or call method method that
# invoked the block/proc/lambda to return
# if next is followed by an expression these are returned to yield
def triangles(n)
	s = []
	1.upto n do |i|
		n, triangle_n = yield i
		s << [n, triangle_n]
	end
	s
end

# Note how next works for block (as usual)
t = triangles(5) do |n| 
	next n, n*(n+1)/2 # => [[1, 1], [2, 3], [3, 6], [4, 10], [5, 15]]
end
puts t.to_s

# here in Proc
p = Proc.new {|n| next n, n*(n+1)/2 }
puts triangles(5, &p).to_s # => [[1, 1], [2, 3], [3, 6], [4, 10], [5, 15]]

# here in lambda
l = ->(n){ next n, n*(n+1)/2 }
puts triangles(5, &l).to_s # => [[1, 1], [2, 3], [3, 6], [4, 10], [5, 15]]




# REDO
#-----
# Works the same 




# RETRY
#------
# Never allowed




# RAISE
#------
# Behaves the same in procs and lambdas. 