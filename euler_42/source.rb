# CORRECT SOLUTION
# => 162

words = File.open("words.txt").read.split(',').collect{|s| s = s[1..s.length-2]}

letters = {}
('a'..'z').each_with_index {|l,i| letters[l.to_sym] = i+1}

def is_triangle?(tn)
    (Math.sqrt(2*tn + 1.0/4.0) - 1.0/2.0) % 1 == 0
end

count = 0
scores = words.each do |word|
    score = 0
    word.each_char do |char|
        score += letters[char.downcase.to_sym]
    end
    count += 1 if is_triangle? score
end
puts count

