#Gold price calc based on ounces
def price_of_gold ounces, price
	return ounces * price
end

#Gold price calc based on pounds
def price_of_gold_from_pounds pounds, price
	return price_of_gold(pounds*32, price)
end

#Gold price calc based on kilos
def price_of_gold_from_kilos kilos, price
	return price_of_gold_from_pounds(kilos*2.2, price)
end

#Input requests
puts "Please enter price (in $) of gold per ounce:"
unit_price = gets.chomp.to_i

puts "Please select weight unit for gold (Pounds, Kilos, Ounces):"
choice = gets.chomp.capitalize

#Input error check
while choice != "Pounds" && choice != "Kilos" && choice != "Ounces"
	puts "Please select valid weight units (Pounds, Kilos, Ounces):"
	choice = gets.chomp.capitalize
end

#Final input
puts "Please enter weight of gold in #{choice}:"
weight = gets.chomp.to_i

#Price Output
if choice == "Ounces"
	total_price = price_of_gold(weight, unit_price)
	puts "Total Price is $#{total_price}"
elsif choice == "Pounds"
	total_price = price_of_gold_from_pounds(weight, unit_price)
	puts "Total Price is $#{total_price}"
elsif choice == "Kilos"
	total_price = price_of_gold_from_kilos(weight, unit_price)
	puts "Total Price is $#{total_price}"
end




