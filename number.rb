number = rand(100)
count = 1

question = "Please pick a number between 1 and 100"

puts question

choice = gets.chomp.to_i

while count <5
	if choice == number
		puts "Congratulations!"
		count +=10
	elsif choice < number
		puts "You're too low! Guess again!"
		count +=1
		choice = gets.chomp.to_i
	elsif choice > number
		puts "You're too high! Guess again!"
		count +=1
		choice = gets.chomp.to_i
	else
		puts "Come on now, give me a number between 1 and 100"
		choice = gets.chomp.to_i
	end
end

if count >=5 && choice != number
	puts "You lose"
end
