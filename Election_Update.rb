require 'pry'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'httparty'
require 'date'
require './pollster_eater.rb'
require './princeton_eater.rb'
require './rcp_eater.rb'
require './states.rb'

class National
#a national polls hash
end

puts "Choose source for polling data:\n1. Pollster.com\n2. Princeton Election Consortium\n3. RealClearPolitics"
poll_source = gets.chomp

puts "Enter max spread for a swing state:"
spread = gets.chomp

puts "Max poll age (days):"
days = gets.chomp.to_i

puts "Please wait..."
state_polls = States.new
#binding.pry
state_polls.fill_polls(poll_source, days)
state_polls.check_swing_states(spread)
state_polls.count_electoral_college



puts "Here are the the current swing states:"
state_polls.swing_states.each do |entry|
  if entry[1] >= 0
    puts "#{entry[0]}\tC +#{entry[1].round(1)}"
  elsif entry[1] < 0
    puts "#{entry[0]}\tT +#{entry[1].round(1).abs}"
  else
  end
end

puts "Current Electoral College Breakdown:"
puts "Clinton: #{state_polls.clinton_votes}"
puts "Trump: #{state_polls.trump_votes}"
puts "Swing: #{state_polls.swing_votes}"

binding.pry

#Take in latest Pollster/Princeton/RCP polling averages
#Ask for max spread for a swing state
#Output all swing states with current average spread
#Display any must-win states for each candidate
#Display national spread

#show date of last poll for each entry
