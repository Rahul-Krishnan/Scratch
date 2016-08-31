#1, 1, 2, 3, 5, 8, 13

puts "Hi, what is your max number for the sequence?"
max = gets.chomp.to_i

fibo = [1,1]
puts fibo[0]
puts fibo[1]

n = 0

while n < max
	n = fibo[0] + fibo[1]
	fibo[0] = fibo[1]
	fibo[1] = n
	puts n unless n > max
end