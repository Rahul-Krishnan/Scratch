#Ask for user inputs
puts "Hi there, welcome to the Leapatron. What is your starting year?"
starting = gets.chomp.to_i

puts "Hi there, welcome to the Leapatron. What is your ending year?"
ending = gets.chomp.to_i

#Make array of years

years = starting..ending

years.each do |year|
	if year%400 == 0
		puts year
	elsif year%100 == 0
	elsif year%4 == 0
		puts year
	else
	end
end