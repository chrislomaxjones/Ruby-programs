 # CORRECT SOLUTION
# => 871198282

require './names'

names, total, Letters = Names.sort, 0, {}

# Populate the letter hash
('a'..'z').each_with_index {|x,i| Letters[x.to_sym] = i+1 }

def score_name(n,i)
    sum = 0
    n.each_char do |l|
        sum += Letters[l.downcase.to_sym]
    end
    sum*(i)
end

names.each_with_index { |n, i| total += score_name(n,i+1) }
puts total


