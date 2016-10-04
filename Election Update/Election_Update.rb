#!/usr/bin/env ruby

require 'pry'
require './states.rb'
require './national.rb'

quit = false
while quit != "q"
  system "clear"
  choice = 0
  while !(["1","2"].include?(choice))
    puts "\nWhat kind of data are you looking for?\n\n1 => National Popular Vote\n2 => Electoral College\n\nPress 1 or 2:"
    choice = gets.chomp
  end
  if choice.to_i == 1
    run_national_polls
  else
    run_state_polls
  end
  #binding.pry
  puts "\nPress Q to quit or any other key to continue..."
  quit = gets.chomp.downcase
end
  #Display any must-win states for each candidate
