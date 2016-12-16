
# THROW AND CATCH
#----------------
# Can be thought of as multilevel break
# Throw can transfer out of multiple levels
# Causing black defined within catch to exit

# Iterate through all values until a nil is reached
def hello()
	values = [ [1,2,3], [4,5,6], [7,8,9], [nil, 11, nil] ]
	catch :missing_value do
		values.each do |row|
			row.each do |value|
				throw :missing_value if value == nil
				puts "#{value}"
			end
		end
	end
	puts "End of processing..."
end
hello

# Use rarely. Can often be refactored.
# Used in multiple methods
def func_one()
	sum, values = 0, [100, 123, 1023, 10]
	catch :invalid_value do
		values.each do |val|
			sum += func_two(val)
		end
	end
	sum
end

def func_two(x)
	# Check for nil x val
	return x*x unless x == nil
	# Throw if this point reached
	throw :invalid_value
end

puts func_one