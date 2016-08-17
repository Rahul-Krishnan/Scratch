


#ask for name
puts "What is your name?"

name = gets.chomp

#ask for age
puts "How old are you?"

age = gets.chomp.to_i

#birth year calc
def yearcalc age
	return year = Time.now.year - age
end

#Greeting output
puts "Hi " + name + ", you have had a long life since " + yearcalc(age).to_s