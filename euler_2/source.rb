# CORRECT
# => 4613732

limit = 4_000_000
x = 0
i = 0
s = [1,1]
sum = 0

loop do
    break if s[-1] > limit
    s << s[-1] + s[-2]
end

s.collect do |val|
    sum += val if val % 2 == 0
end

puts sum