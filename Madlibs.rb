#User input requests

puts "Gimme the name of a weapon!"

weapon = gets.chomp.downcase

puts "Gimme a verb!"

verb = gets.chomp.downcase

puts "Gimme an adjective!"

adj = gets.chomp.downcase

puts "Gimme a female name!"

subject_name = gets.chomp.capitalize

puts "Gimme a noun!"

noun = gets.chomp.capitalize

puts "I need a last name!"

firm_name = gets.chomp.capitalize

puts "A final adjective!"

adj2 = gets.chomp.downcase

#Story
puts "\n" + subject_name + " " + firm_name + "'s Revenge: a Noir Tale. Chapter 1... \n\nI always suspected the mole at " + firm_name + ", " + noun + " and Weinstein was someone related to one of the partners... but the " + adj + " truth now seemed far worse than any of us had feared. \n\nAs she turned to face me, revealing the partially shredded documents on the table, a smirk crossed " + subject_name + "'s face. 'It's a shame you'll never be able to tell my brother about this', she said with unusual confidence as she prepared to make use of the " + adj2 + " " + weapon + " in her hands. In those last frantic moments, all I could do was " + verb + " in desperation.\n\nAnd then, only blackness. " + adj.capitalize + ", " + adj + " blackness."