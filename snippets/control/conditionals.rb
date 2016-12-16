# CONDITIONALS
#-------------

# get user input
puts "enter x:"
x = gets.chomp.to_f

if x < 10
	puts "x is less than 10"
elsif x > 10
	puts "x is greater than 10"
else
	puts "x = 10"
end

# One line if
if x < 10 then puts "x is less than 10" end

# Last expression in if statement is return value
y = if x == 0
	"zero"
elsif x == 1
	"one"
elsif x == 2
	"two"
else
	"something else"
end
# Output y
puts "y is #{y}"

# If can be put at end of expression
cond = true
puts "hello world" if cond

# unless is opposite of if
some_value = false
unless some_value
	puts "some_value is false"
else
	puts "some_value is true"
end
# Note there is no 'unlessif' clause

# Case
puts "Enter a number:"
y = gets.chomp.to_f
case
	when y == 1
		puts "One!!"
	when y == 2
		puts "Two!!"
	when y == 3
		puts "Three!!"
	else
		puts "Some other number!!"
end

# Can assign to value
z = case
	when y == 1
		puts "One!!"
	when y == 2
		puts "Two!!"
	when y == 3
		puts "Three!!"
	else
		puts "Some other number!!"
	end
puts z

x,y = 0
# Comma acts like or
case
	when x == 0, y == 0 then z = 0
	when x == 0 || y == 0 then z = 0	
end

# object can come after case
x = 5
case x
	when 1 then puts "x=1"
	when 2 then puts "x=2"
	when 3 then puts "x=3"
	when 4 then puts "x=4"
	else puts "else"
end 

# Enforces === operator
# This can be used to test for type
u = true
puts case u
	when String then "string"
	when Numeric then "number"
	when TrueClass, FalseClass then "boolean"
	else "other"
end

# Test for in range
e = 2050.423
case e
	when 0...1000 then puts "0-999"
	when 1000...2000 then puts "1000-1999"
	when 2000...3000 then puts "2000-2999"
	when 3000...4000 then puts "3000-3999"
	else "some other shitty number"
end




















	
	


	
