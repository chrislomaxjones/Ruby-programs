# SOLUTION CORRECT
# => 906609

largest = 0

1.upto(9).each do |x1|
    1.upto(9).each do |y1|
        1.upto(9).each do |z1|
            1.upto(9).each do |x2|
                1.upto(9).each do |y2|
                    1.upto(9).each do |z2|
                        p = "#{x1}#{y1}#{z1}".to_i * "#{x2}#{y2}#{z2}".to_i
                        largest = p if p.to_s == p.to_s.reverse && p > largest
                    end
                end
            end
        end
    end
end

puts largest