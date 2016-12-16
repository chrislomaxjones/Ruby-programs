# Calculates the value of term n in fibonacci sequence
def fibonacci(n)
    return 0 if n == 0
    return 1 if n == 1
    return fibonacci(n-1) + fibonacci(n-2)
end

# Returns an array containing fibonacci sequence upto a no of terms
def fibonacci_sequence(terms)
    sequence = []
    (terms+1).times do |n|
        if n == 0 then sequence << 0 # Insert 0 as first in sequence
        elsif n == 1 then sequence << 1 # Insert 1 as second in sequence
        else sequence << sequence[-1] + sequence[-2] end # Sum last two terms to get next term
    end
    sequence # Return the sequence
end