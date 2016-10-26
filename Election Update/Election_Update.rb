#!/usr/bin/env ruby <-- HOW DO I ALLOW THIS FILE TO OPEN IN TERMINAL ON
# =>                    CLICK IN EXPLORER?

require 'pry'
require './states.rb'
require './national.rb'
require './odds.rb'

quit = false
while quit != "q"
  system "clear"
  choice = 0
  while !((1..3).include?(choice))
    puts "\nWhat kind of data are you looking for?"
    puts "\n1 => National Popular Vote"
    puts "2 => Electoral College"
    puts "3 => Winning Odds"
    puts "\nPress 1, 2 or 3:"
    choice = gets.chomp.to_i
  end
  if choice == 1
    run_national_polls
  elsif choice == 2
    run_state_polls
  else
    run_odds
  end
  #binding.pry
  puts "\nPress Q to quit or any other key to continue..."
  quit = gets.chomp.downcase
end
