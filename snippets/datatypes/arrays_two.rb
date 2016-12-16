# Additional array info
# ---------------------

# Clear method clears the array
a = ["Dennis", "Mark", "John"]
a.clear
puts a.to_s # -> []

# compact! removes all nils
a = [nil, 30, nil, 20, nil, 10, nil]
a.compact!
puts a.to_s # -> [30, 20, 10]

scores = [95, 66, 31, 29, 145]
scores.delete_if { |x| x < 80 }
puts scores.to_s # -> [95, 145]

# each_index passes the index instead of the element
foo = [100, 200, 300, 400, 500]
foo.each_index { |x| print x, " -- "}

# empty? method returns if array is empty
foo = []
puts foo.empty? #-> true

# fill method provides different ways to modify elements
b = ('a'..'d').to_a
b.fill("foo") #-> ["foo", "foo", "foo", "foo"]
b.fill("bar", 2, 2) #-> ["foo", "foo", "bar", "bar"]
b.fill("foobar", 0..1) #-> ["foobar", "foobar", "bar", "bar"]
b.fill {|i| i*i } # => [0, 1, 4, 9]
b.fill(-2) {|i| i*i*i} #=> [0, 1, 8, 27]

# flatten returns 1D array
c = [1, 2, 3, [4, 5], 6, 7, [8, [9, 10]]]
d = c.flatten # -> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
# The number of dimensions to flatten can be supplied
e = c.flatten(1) # -> [1, 2, 3, 4, 5, 6, 7, 8, [9, 10]]
# flatten! flattens self
c.flatten!
# Output results
puts c.to_s
puts d.to_s
puts e.to_s

# include? method checks for presence of an element
f = [10, 20, 30, 40, 50]
puts f.include?(10) # -> true
puts f.include?(100) # -> false

# index returns index of matching element
g = ["foo", "foob", "fooba", "foobar"]
puts g.index("foob") # -> 1
puts g.index("fo") # -> nil (THIS IS WEIRD)
puts g.index { |x| x == "foobar" } # -> 3

# rindex gets index of last matching object
g = ["foobar", "foob", "foo", "foo", "bar"]
puts g.rindex("foo") # -> 3
puts g.rindex { |x| x == "foo" } # -> 3

# join converts to string and adds optional separater
names = ["Steve", "Bill", "Mark", "Steve", "Peter"]
puts names.join # -> "SteveBillMarkStevePeter"
puts names.join(" and ") #-> "Steve and Bill and Mark and Steve and Peter"

# pop Removes last element and returns it
h = [1, 2, 3, 4, 5]
puts h.pop # -> 5
puts h.pop(2).to_s # -> [3,4]
puts h.to_s # - > [1, 2]

# push appends an element onto end of array
h = [1, 2, 3, 4, 5]
h.push 5, 6, 7 # -> [1, 2, 3, 4, 5, 6, 7] (same as h.push())
# Output
puts h.to_s
# Can be chained
[1, 2, 3].push(4).push(5) # -> [1, 2, 3, 4, 5]

# shift removes 1st element and returns it
words = ["One", "Two", "Three", "Four"]
puts words.shift # -> "One"
puts words.shift(2).to_s #-> ["Two", "Three"]
puts words.to_s # -> "Four"

# unshift prepends element onto array
more_words = ["hello", "hey", "good day"]
more_words.unshift("hi", "hello")
puts more_words.to_s # - > ["hi", "hello", "hello", "hey", "good day"]

# Reverse reverses order of elements
i = ["x", "y", "z"]
puts i.reverse

# Reverse each is the same as each iterator
# ... however iterates in reverse
j = ["a", "b", "c"]
j.reverse_each { |x| print x + " " }

# Sort method sorts the array and returns it
u = [1, 405, 40, 304, 302, 182]
puts u.sort.to_s
u.sort! # sorts itself
puts u.to_s

# uniq! removes dupes from array
n = [1, 4, 4, 16, 36, 512]
n.uniq! # ->[1, 4, 16, 36, 512]
puts n.to_s



