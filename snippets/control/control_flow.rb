# return - causes a method to exit and return a value to caller
# break - causes loop or iterator to exit
# next - cause iterator to skip current iteration and move onto the next one
# redo - restarts a loop or iterator from the beginning
# throw/catch - sort of exception propogation and handling mechanism. multilevel break

# RETURN
#-------
# Causes the enclosing method to return a value to its caller
# May be followed by a single or comma separated multiple expressions
# Otherwise, nil is returned

# Return value is equal to expression after return
# If >1 return value, return values are returned in array
# The value of the return statement is automatically the last expression in the method.

# Most ruby programs omit return
# Return is useful to prematurely return a method or return >1 val
def double(x)
    return nil if x == nil
    return x, x.dup
end

# Blocks are not methods so return behaves differently
# If return is used in a block it does not cause the method to return
# It causes the enclosing method to return, regardless of how deeply nested it is.

# Note lambdas are different and covered later

# Return the index of the first occurrence of target within array or nil
def find(array,target)
    array.each_with_index do |element,i|
        return i if element == target # Return when first target is found
        end
    nil # If no element found, return nil
end


# BREAK
#------
# Break transfers control out of a loop to the first expression following the loop
while (line = gets.chomp)
    break if line == "quit"
    puts line
end
puts "Goodbye"

# When used in a block, break transfers control out of the block, out of the iterator that invoked the block
# To the first expression following the invocation of the iteration
["Line one", "Line two", "quit\n"].each do |line|
    break if line == "quit\n"
    puts line
end
puts "goodbye"

# Can break with a value same as return
i, values = 0, ["bar", "foobar", "foobs", "fooo", "foobar", "foo"]
found_foo = while i < values.length
    break i if values[i] == "foo"
    i+=1
end
puts found_foo

# NEXT
#-----
# Causes loop or iterator to end current iteration and begin next
while (line = gets.chomp)
    break if line == "quit"
    next if line[0,1] == "#"
    puts line
end

# When next is used in a block, it causes block to exit immediately, return control to the iterator method
# May begin new iteration by invoking the block again
["One", "Two", "Three"].each do |line|
    next if line[0,1] == "#"
    puts line
end


# NEXT AND BLOCK VALUE
#---------------------
# When next is used in a loop, expressions appended to it are ignored
# When used in a block, it becomes the "return value" of the tield statement
# If multiple comma separated expressions, array is returned

squareroots = [102, 100, 16, 64, -100].collect do |x|
    next 0 if x < 0 # Return 0 for negative values
    Math.sqrt(x)
end

# Normally value of yield is last expression in the block
squareroots = [102, 100, 16, 64, -100].collect do |x|
    if x < 0 then 0 else Math.sqrt(x) end
end
    
# REDO
#-----
# Restarts current iteration of the loop or iterator
# Note different from next as transfers control to start of loop
i = 0
while i < 3
    puts i
    i+=1
    redo if i==3
end

# Not many uses for redo
puts "Please enter first word you think of"
words = %w(apple banana cherry)
response = words.collect do |word|
    print word + ">"
    response = gets.chomp
    if response.size == 0
        word.upcase!
        redo
    end
    response
end










    















