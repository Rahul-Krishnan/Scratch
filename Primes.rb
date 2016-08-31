(2..100).each do |x|
	prime = true
	(2...x).each do |y|
		if x%y == 0
			prime = false
		end
	end
	puts x if prime
end
