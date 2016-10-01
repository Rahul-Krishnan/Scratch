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

state_polls = States.new
#binding.pry
state_polls.fill_polls(poll_source)
state_polls.check_swing_states(spread)

date = (Date.today-7)



system "clear"
puts "Here are ther swing states:"
puts state_polls.swing_states
#
# puts "*****Pollster.com results*****"
# puts "Clinton average in polls ending after #{date}:"
# puts pollster_polls.averages["clinton"].round(1)
# puts
# puts "Trump average in polls ending after #{date}:"
# puts pollster_polls.averages["trump"].round(1)
# puts
# puts "Johnson average in polls ending after #{date}:"
# puts pollster_polls.averages["johnson"].round(1)
# puts
# puts "Stein average in polls ending after #{date}:"
# puts pollster_polls.averages["stein"].round(1)
# puts
# puts "Undecided average in polls ending after #{date}:"
# puts pollster_polls.averages["undecided"].round(1)
# puts
# puts "*****Princeton results*****"
# puts "Clinton average in polls ending after #{date}:"
# puts princeton_polls.averages["clinton"].round(1)
# puts
# puts "Trump average in polls ending after #{date}:"
# puts princeton_polls.averages["trump"].round(1)
# puts
# puts "Other average in polls ending after #{date}:"
# puts princeton_polls.averages["other"].round(1)
# puts
# puts "Undecided average in polls ending after #{date}:"
# puts princeton_polls.averages["undecided"].round(1)
# puts
#
binding.pry

#Take in latest Pollster/Princeton/RCP polling averages
#Ask for max spread for a swing state
#Output all swing states with current average spread
#Display any must-win states for each candidate
#Display national spread

#show date of last poll for each entry
