
#Intro
story = "You’re a traveler on a long journey. After many miles, you come to a fork in the road. To the North is a small village. To the East is a dark cave. Which way do you go? North or East?"

#Responses
choice_n = "From the village to the North, a wild Grue appears! You commence battle!"

choice_e = "The East is pretty hot. You are dead."

indecisive = "Please be reasonable, now! North or East!"

#Ask for input
puts story

direction = gets.chomp.capitalize

#Results
while direction !="North" && direction !="East"
	puts indecisive
	direction = gets.chomp.capitalize
end

if direction == "North"
	puts choice_n
elsif direction == "East"
	puts choice_e
end