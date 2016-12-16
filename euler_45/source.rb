def triangle(n)
    (n*(n+1))/2
end

def pentagonal(t)
    Math.sqrt( (t**2 + t + (1.0/12.0)) / 3 ) + (1.0/6.0)
end

def hexagonal(t)
    Math.sqrt( (t**2 + t + (1.0/4.0)) / 4) + (1.0/4.0)
end

t = 286
loop do
    break if pentagonal(t) % 1 == 0 && hexagonal(t) % 1 == 0
    t+=1
end
p triangle(t)

