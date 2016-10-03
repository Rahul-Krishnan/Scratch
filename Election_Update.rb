require 'pry'
require './states.rb'
require './national.rb'

quit = false
while quit != "q"
  system "clear"
  choice = 0
  while !(["1","2"].include?(choice))
    puts "\nWhat kind of data are you looking for?\n\n1 => Electoral College\n2 => National Popular Vote\n\nPress 1 or 2:"
    choice = gets.chomp
  end
  if choice.to_i == 1
    run_state_polls
  else
    run_national_polls
  end
  #binding.pry
  puts "\nPress Q to quit or any other key to continue..."
  quit = gets.chomp.downcase
end
  #binding.pry
  
  #Display national spread
  #Display any must-win states for each candidate
