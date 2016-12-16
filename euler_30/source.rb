i, sum = 0,0
loop do
    i+=1
    
    digits = i.to_s.each_char.collect {|c| c.to_i}
    sum += i if i == digits.inject{|s,x| s + (x**5)}
end