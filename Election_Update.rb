require 'pry'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'httparty'
require 'date'
require './pollster_eater.rb'
require './princeton_eater.rb'


class Poop
#a sorted hash for all the polls
#a sorted hash for state electoral college votes
#a swing state hash
#a national polls hash
#a display method
#a method to count paths to 270
#a method to find must-win states
#a method to pull in polling data
end

puts "Enter State:"
state = gets.chomp.upcase

puts "Enter max poll age (days)"
days = gets.chomp.to_i
date = (Date.today-days).to_s


pollster_polls = Pollster::Polls.new(state, date)
pollster_polls.eat_polls

princeton_polls = Princeton::Polls.new(state, date)
princeton_polls.eat_polls
#binding.pry


puts "*****Pollster.com results*****"
puts "Clinton average in polls ending after #{date}:"
puts pollster_polls.averages["clinton"].round(1)
puts
puts "Trump average in polls ending after #{date}:"
puts pollster_polls.averages["trump"].round(1)
puts
puts "Johnson average in polls ending after #{date}:"
puts pollster_polls.averages["johnson"].round(1)
puts
puts "Stein average in polls ending after #{date}:"
puts pollster_polls.averages["stein"].round(1)
puts
puts "Undecided average in polls ending after #{date}:"
puts pollster_polls.averages["undecided"].round(1)
puts
puts "*****Princeton results*****"
puts "Clinton average in polls ending after #{date}:"
puts princeton_polls.averages["clinton"].round(1)
puts
puts "Trump average in polls ending after #{date}:"
puts princeton_polls.averages["trump"].round(1)
puts
puts "Other average in polls ending after #{date}:"
puts princeton_polls.averages["other"].round(1)
puts
puts "Undecided average in polls ending after #{date}:"
puts princeton_polls.averages["undecided"].round(1)
puts

#binding.pry

#Take in latest Pollster/Princeton/RCP polling averages
#Ask for max spread for a swing state
#Output all swing states with current average spread
#Display any must-win states for each candidate
#Display national spread

#show date of last poll for each entry
