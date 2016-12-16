# CORRECT SOLUTION
# => 31875000

def find_triples(max)
    1.upto(max).each do |c|
        1.upto(c).each do |b|
            1.upto(b).each do |a|
                puts "Trying...#{a}, #{b}, #{c}"
                return a*b*c if (a+b+c == 1000) && (a**2 + b**2 == c**2)
            end
        end
    end
end

puts find_triples(1000)










