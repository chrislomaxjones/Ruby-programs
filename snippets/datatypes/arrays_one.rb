# ARRAY CODE ETC...

[1, 2, 3] # Array holds 3 Fixnum objs
[-10...0, 0..10,] # Array of 2 ranges (trailing commas are allowed)
[ [1, 5], [2, 6], [3, 7]] # Array of nested arrays 
x,y = 1,2
[x+1, y+1, y*x] # Elements can be expressions
[] # Empty array

# Special case syntax for array literals of short strings

words = %w[this is a test] # ['this', 'is', 'a', 'test']
open = %w|([{<| # ['(', '[', '{', '<']
white = %w(\s \t \r \n) # ["\s", "\t", "\n", "\s"]

empty = Array.new # You can also do this
nils = Array.new(3) # Inits array with 3 nil elements
zeros = Array.new(4,0) # [0, 0, 0, 0]
copy = Array.new(zeros) # Copies the array supplied as argument to new
count = Array.new(3) { |i| i+1 } # [1, 2, 3]

# Output some to the console
puts copy.to_s
puts count.to_s

# Finding specific array elements
a = [0, 1, 4, 9, 16]

a[0] # -> 0 (First element)

a[-1] # -> 16 (Last element)
a[a.size-1] # -> 16

a[-2] # -> 9 (Second to last element)
a[a.size-2] #-> 9

a[8] # -> nil
a[-8] # -> nil

# These expressions can be used for assignment
a[0] = "zero"
puts a[0].to_s # -> "zero"
a[-1] = 1..16
puts a[-1].to_s # -> "1..16"

# Ranges can be converted to arrays
b_range = 1..10
b = b_range.to_a
puts b.to_s

# Ranges can be accessed from within array
b[0,0] # -> []
b[1,1] # -> [1]
b[-2, 2] # -> [9, 10] last two elements
b[0..2] # -> [1, 2] first three elements
b[-2..-1] # -> [9, 10] last two elements
b[0...-1] # -> [1, 2, ..., 9] all but last element

# Can also be used for insertion or deletion
c = (10..20).to_a
c[0..4] = [1, 2, 3, 4] # Replace
c[0,0] = [-2, -1, 0] # Insert at beginning
c[-1, 2] = [10] # Change last element
c[-2, 2] = nil # Make last 2 elements nil

# Output this
puts c.to_s

# Array addition
d = [1,2,3] + [4,5,6]
d = d + [7, 8, 9]
# d = d + 10 (Not an array so error, see below)
d = d + [10]
# Output
puts d.to_s

# << appends element to end of array
e = []
e << 1
e << 2 << 3
e << [4, 5, 6 ] # This array will be nested
e.concat [7,8] # Appends elements to end of array

# Output this
puts e.to_s

# Arrays can be subtracted from each other
some_numbers = [1, 2, 6, 4, 4, "undefined", 6, 4, 1, 4, "undefined", 5, 6, 79, 1, 3]
clean_numbers = some_numbers - ["undefined"]
puts clean_numbers.to_s

# Multiplication of arrays...
f = [1, 2, 3] * 4
puts f.to_s # [1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2 3]

# Boolean | operator applied to arrays
# ... concats 2 arrays and removes duplicates
g = [1, 1, 2, 2, 3, 3, 4]
h = [5, 5, 4, 4, 3, 3, 2]
i = g | h # -> [1, 2, 3, 4, 5]
i = h | g # -> [5, 4, 3, 2, 1] (note order change)

# Boolean & operator appleid to arrays
# ... holds elements that appear in both applied arrays
j = g & h # -> [2, 3, 4]
j = h & h # -> [4, 3, 2]

# Output both
puts i.to_s
puts j.to_s

# Each method used to iterate through every element
k = ('A' .. 'Z').to_a
k.each {|x| print x }

















