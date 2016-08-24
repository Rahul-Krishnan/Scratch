#Greeting

puts "HELLO THERE SONNY! HOW ARE YOU TODAY?"

#Input

input = gets.chomp

#Talk in caps, say bye to leave
while input != "BYE"
	if input == input.upcase
		puts "NO, NOT SINCE #{1930 + rand(50)}!"
		input = gets.chomp
	else
		puts "HUH?! SPEAK UP SONNY!"
		input = gets.chomp
	end
end

puts "GOODBYE CHILD!"