# Return in blocks, procs and lambdas
# -----------------------------------

# When you return from a block, it returns from the method
# that contains the block
# this can cause some code not to be executed (see below)
def some_damn_method
	puts "Enterng method"
	1.times { puts "Entering block!"; return }
	puts "Exiting method" # Never gets executed!
end
some_damn_method

# Procs do the same thing as blocks
def blastoff
	print "Initiating... "
	10.times do |i| 
		return if i == 9
		print i.to_s + " "
	end
	print "...blastoff!\n" # This never gets printed :(
end
blastoff

# Procs are often passed around between methods
# By the time a Proc is invoked, the lexically enclosing
# method may already have returned
def proc_builder(message)
	Proc.new { puts message; return }
end

def test
	puts "Enter method"
	p = proc_builder("entering proc")
	begin
		p.call # prints "entering proc" and raises LocalJumpError!
	rescue
		puts "We got an error entering proc!"
	end
	puts "Exiting method"
end
test

# Lambdas work more like methods than blocks
# A return from a lambda returns from the lambda itself
# not the method that surrounds the lambda creation site
def test2
	puts "Entering method"
	l = ->{ puts "Entering lambda"; return }
	l.call
	puts "Exiting lambda" # this gets executed
end
test2

# We never have to worry about LocalJumpError
def lambda_builder(message)
	->{ puts message; return }
end

def test3
	puts "Entering method"
	l = lambda_builder("Entering lambda")
	l.call # No error
	puts "Exiting lambda"
end
test3



