
#Instantiate "Bye" count
count = 1

#Greeting
puts "HELLO THERE SONNY! HOW ARE YOU TODAY?"

#Input
input = gets.chomp

#Talk in caps, say bye 3 times to leave
while count < 3
	if input == "BYE"
		count +=1
		puts "DON'T LEAVE ME YOU UNGRATEFUL WRETCH"
		input = gets.chomp
	elsif input == input.upcase
		puts "NO, NOT SINCE #{1930 + rand(50)}!"
		count = 1
		input = gets.chomp
	else
		puts "HUH?! SPEAK UP SONNY!"
		input = gets.chomp
		count = 1
	end
end

puts "GOODBYE CHILD!"