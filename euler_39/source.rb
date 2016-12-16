

def find_b(p,a)
   ((p**2) - (2*p*a))/(2*(p-a))
end



p = 1
while p <= 1000
    puts p
    solutions = 0
    a = 1
    while a < p
        # Find a p
        b = find_b(p,a)
        break if b % 1 != 0
        c = Math.sqrt(a**2 + b**2)
        a+=1
    end
end