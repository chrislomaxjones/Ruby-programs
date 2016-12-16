# Procs use yield semantics
# this means .call behaves like a yield
# examples below
p = Proc.new {|x,y| print x,y,"\n"}

p.call(1) # => x,y=1: nil used for missing rval => "1nil"
p.call(1,2) # => x,y=1,2 => "12"
p.call(1,2,3) # => x,y=1,2,3 => "12"
p.call([1,2]) # => x,y=[1,2] => "12"

# Lambas use invocation semantics
# they are not flexible like Procs
# examples below
l = ->(x,y){print x,y,"\n"}
l.call(1,2) # This works as expected
l.call(*[1,2]) # This also works
begin
	l.call(1) # This causes an error
	l.call(1,2,3) # This causes an error
	l.call([1,2]) # This causes an error
rescue
	puts "Error!"
end

