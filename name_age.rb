


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
puts "Hi " + name + ", looks like you have been a problem on this planet since about " + (yearcalc(age)-1).to_s + " or " + yearcalc(age).to_s