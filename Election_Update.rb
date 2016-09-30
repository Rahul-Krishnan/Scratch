require 'pry'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'httparty'
require './poll_eater.rb'


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
state = gets.chomp

puts "Enter start date (YYYY-MM-DD):"
date = gets.chomp

polls = Polls.new(state,date)
polls.eat_polls
polls.calc_averages
#binding.pry

puts "Clinton average since #{date}:"
puts polls.averages["clinton"]
puts
puts "Trump average since #{date}:"
puts polls.averages["trump"]
puts
puts "Johnson average since #{date}:"
puts polls.averages["johnson"]
puts
puts "Stein average since #{date}:"
puts polls.averages["stein"]
puts
puts "Undecided average since #{date}:"
puts polls.averages["undecided"]

#Take in latest Pollster polling averages
#Ask for max spread for a swing state
#Output all swing states with current average spread
#Display any must-win states for each candidate
#Display national spread

#show date of last poll for each entry
