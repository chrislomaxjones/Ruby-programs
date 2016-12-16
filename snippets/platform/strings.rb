s = "Hello"

# Some synonyms for prior methods...
p s.concat " world" # Synonym for <<. Mutating append to s. Returns new s.
p s.insert(5, " there") # Same as s[5,0] = " there". Alters s. Returns new s.
p s.slice(0,5) # Same as s[0,5]. Returns a substring.
p s.slice!(5,6) # Deletion. Same as s[5,6]="". Returns deleted substring
p s.eql?("Hello world") # True. same as ==.

# Methods for querying length of a string...
p s.length
p s.size # synonym for length
p bytesize # 11 - length in bytes
p.empty? # false
"".empty? # true

# String methods for finding and replacing content...
#...