def c_to_f celsius
	return celsius * 9/5 + 32
end

def f_to_c faren
	return (faren - 32) * 5/9
end

#Ask for conversion direction
puts "Convert from C or from F?"
selection = gets.chomp.downcase

# Celsius section
if selection.include?('c')
	puts "Please enter temp in C"
	c = gets.chomp.to_f
	puts c.to_s + " in Farenheit is: " + c_to_f(c).to_s

# Farenheit section
elsif selection.include?('f')
	puts "Please enter temp in F"
	f = gets.chomp.to_f
	puts f.to_s + " in Celsius is: " + f_to_c(f).to_s

# Error message
else puts "Please make sense"
end
