puts "Please enter your secrets:"
secret = gets.chomp

puts "Please give me a number:"
number = gets.chomp.to_i%26

encoded_array = []

def encrypt message
	characters = message.chars
	characters.each do |x|
		y = (x.ord + number).chr
		encoded_array.push(y)
	end
	encoded_message = encoded_array.join
end

puts encoded_message


def decrypt message
	characters = message.chars
	characters.each do |x|
		y = (x.ord - number).chr
		encoded_array.push(y)
	end
	encoded_message = encoded_array.join
end