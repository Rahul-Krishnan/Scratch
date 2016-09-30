require 'pry'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'httparty'


class Polls
#a sorted hash for all the polls
#a sorted hash for state electoral college votes
#a swing state hash
#a national polls hash
#a display method
#a method to count paths to 270
#a method to find must-win states
#a method to pull in polling data
end

poll_list =JSON.parse(HTTParty.get("http://elections.huffingtonpost.com/pollster/api/polls.json?after=2016-09-22&topic=2016-president&state=US").body)[0]["questions"]

clinton_scores = []
trump_scores = []
johnson_scores = []
stein_scores = []
undecided_scores = []
results = []

poll_list.each do |item|
  if item["name"].include?("Clinton")
    puts item["name"]
    pres_polls = item["subpopulations"][0]["responses"]
    results << pres_polls
  else
  end
end

results.each do |poll|
  poll.each do |entry|
    if entry["choice"].include?("Clinton")
      clinton_scores << entry["value"]
    elsif entry["choice"].include?("Trump")
      trump_scores << entry["value"]
    elsif entry["choice"].include?("Johnson")
      johnson_scores << entry["value"]
    elsif entry["choice"].include?("Stein")
      stein_scores << entry["value"]
    elsif entry["choice"].include?("Undecided")
      undecided_scores << entry["value"]
    else
    end
  end
end
#binding.pry

puts "Clinton 7-day average:"
puts clinton_scores.reduce(:+)/clinton_scores.count
puts
puts "Trump 7-day average:"
puts trump_scores.reduce(:+)/trump_scores.count
puts
puts "Johnson 7-day average:"
puts johnson_scores.reduce(:+)/johnson_scores.count
puts
puts "Stein 7-day average:"
puts stein_scores.reduce(:+)/stein_scores.count
puts
puts "Undecided 7-day average:"
puts undecided_scores.reduce(:+)/undecided_scores.count unless undecided_scores.count==0




#Take in latest Pollster polling averages
#Ask for max spread for a swing state
#Output all swing states with current average spread
#Display any must-win states for each candidate
#Display national spread

#show date of last poll for each entry
