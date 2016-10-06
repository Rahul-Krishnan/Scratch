#!/usr/bin/env ruby

require 'pry'
require './states.rb'
require './national.rb'
require './odds.rb'

quit = false
while quit != "q"
  system "clear"
  choice = 0
  while !(["1","2","3"].include?(choice))
    puts "\nWhat kind of data are you looking for?\n\n1 => National Popular Vote\n2 => Electoral College\n3 => Fivethiryeight.com Odds\n\nPress 1, 2 or 3:"
    choice = gets.chomp
  end
  if choice.to_i == 1
    run_national_polls
  elsif choice.to_i == 2
    run_state_polls
  else
    run_odds_538
  end
  #binding.pry
  puts "\nPress Q to quit or any other key to continue..."
  quit = gets.chomp.downcase
end
  #Display any must-win states for each candidate
