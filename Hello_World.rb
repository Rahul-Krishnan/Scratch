puts "Please enter your beautiful, wonderful big name:"

my_name = gets.chomp

def hello_name some_name, another_name, last_name
	puts "Hello " + some_name + ", " + another_name + " and " + last_name
end

hello_name(my_name, "Harambe", "Mugabe")