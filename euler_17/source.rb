# CORRECT SOLUTION
# => 21124

N20 = ["", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine","ten","eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]

T = ["", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]


def determine(n)
    raise ArgumentError if (!n.is_a? Integer) || n > 1000
    digits=n.to_s.length
    
    if digits == 1
        N20[n]
    elsif digits == 2
        if n < 20
            N20[n]
        else
            T[n.to_s[0].to_i] + determine(n.to_s[-1].to_i)
        end
    elsif digits == 3
        return N20[n.to_s[0].to_i] + "hundred" if n.to_s[1].to_i == 0 && n.to_s[-1].to_i == 0
        N20[n.to_s[0].to_i] + "hundredand" + determine( n.to_s[1, n.to_s.length-1].to_i )
    else
        "onethousand"
    end
end

puts (0..1000).inject { |s, i| s + determine(i).length }