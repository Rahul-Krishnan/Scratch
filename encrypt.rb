#Ask for user inputs
puts "(E)ncode or (D)ecode?"
selection = gets.chomp.downcase

puts "Please enter your message:"
secret = gets.chomp

puts "Please give me a number:"
number = gets.chomp.to_i%26

#Message error check
error = 0
if selection == "e"
	secret.chars.each do |x|
		if x.upcase.ord < 65 || x.upcase.ord > 90
			error +=1
		else
		end
	end
else
end

#Encryption Method
def encrypt message, number
	encoded_array = []
	encoded = ""
	characters = message.chars
	characters.each do |x|
		y = (x.ord + number).chr
		encoded_array.push(y)
	end
	return encoded = encoded_array.join
end

#Decryption Method
def decrypt message, number
	decoded_array = []
	characters = message.chars
	characters.each do |y|
		x = (y.ord - number).chr
		decoded_array.push(x)
	end
	decoded = decoded_array.join
end

#Control Flow
if error >0
	puts "Only valid letter characters in the message, please!"
elsif selection == "e"
	encoded_message = encrypt(secret,number)
	puts "Encoded Message: #{encoded_message}"
elsif selection == "d"
	decoded_message = decrypt(secret,number)
	puts "Decoded Message: #{decoded_message}"
else
	puts "That wasn't right! Please select E or D."
end
