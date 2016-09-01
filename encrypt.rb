#Error Check Method
def check message
	error = 0
	message.chars.each do |x|
		if x.ord == 32
		elsif x.upcase.ord < 65 || x.upcase.ord > 90
			error +=1
		else
		end
	end
	return error
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

#Ask for user operation direction
puts "(E)ncode or (D)ecode?"
selection = gets.chomp.downcase
#Check the input makes sense
while selection !="e" && selection !="d"
	puts "That wasn't right! Please select E or D:"
	selection = gets.chomp.downcase
end

if selection == "e"
	puts "Please enter message to encrypt (ONLY letters, NO numbers/special characters):"
	secret = gets.chomp
	while check(secret) >0
		puts "Only valid letter characters in the message, please:"
		secret = gets.chomp
	end
else
	puts "Please enter message to decrypt:"
	secret = gets.chomp
end

puts "Please give me a number:"
number = gets.chomp.to_i%26

#Output
if selection == "e"
	encoded_message = encrypt(secret,number)
	puts "Encoded Message: #{encoded_message}"
else
	decoded_message = decrypt(secret,number)
	puts "Decoded Message: #{decoded_message}"
end
