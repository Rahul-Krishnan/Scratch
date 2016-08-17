def c_to_f celsius
	return celsius * 9/5 + 32
end

def f_to_c faren
	return (faren - 32) * 5/9
end

# Celsius section

puts "Please enter temp in C"
c = gets.chomp.to_f
puts c.to_s + " in Farenheit is: " + c_to_f(c).to_s

# Farenheit section

puts "Please enter temp in F"
f = gets.chomp.to_f
puts f.to_s + " in Celsius is: " + f_to_c(f).to_s