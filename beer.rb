count = 99

while count > 0
	puts "#{count} bottle#{"s" unless count == 1} of beer on the wall, #{count} bottle#{"s" unless count == 1} of beer... take one down, pass it around, #{count -=1} bottle#{"s" unless count == 1} of beer on the wall!"
end

if count == 0
	puts "Oh dear. No more bottles of beer on the wall :("
end