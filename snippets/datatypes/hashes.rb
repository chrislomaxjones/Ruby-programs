# Hashes
# Hashes are sets of key-value pairs
numbers = Hash.new
numbers["one"] = 1
numbers["two"] = 2
numbers["three"] = 3

# Accessed like this
puts numbers["two"] + numbers["three"] # -> 5

# Hash literals
# Another way of writing above
numbers = { "one" => 1, "two" => 2, "three" => 3}

# Can also be written as symbols
# more on symbols later
numbers = { :one => 1, :two => 2, :three => 3 }

# Can also be written as below
numbers = { one: 1, two: 2, three: 3 }

# There's some writing in the book (page 68)
# ... might be important
# ... read up when more knowledgable