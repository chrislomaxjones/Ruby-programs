# CORRECT SOLUTION
# => 2783915460
permutations = []
(0..9).each do |a|
  ((0..9).to_a - [a]).each do |b|
    ((0..9).to_a - [a,b]).each do |c|
      ((0..9).to_a - [a,b,c]).each do |d|
        ((0..9).to_a - [a,b,c,d]).each do |e|
          ((0..9).to_a - [a,b,c,d,e]).each do |f|
            ((0..9).to_a - [a,b,c,d,e,f]).each do |g|
              ((0..9).to_a - [a,b,c,d,e,f,g]).each do |h|
                ((0..9).to_a - [a,b,c,d,e,f,g,h]).each do |i|
                  ((0..9).to_a - [a,b,c,d,e,f,g,h,i]).each do |j|
                    permutations << "#{a}#{b}#{c}#{d}#{e}#{f}#{g}#{h}#{i}#{j}".to_i
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

puts permutations.sort[999_999]