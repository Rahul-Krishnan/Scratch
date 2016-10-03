require 'pry'
require 'rubygems'
require 'date'
require './pollster_eater.rb'
require './princeton_eater.rb'
require './rcp_eater.rb'

class National
#a national polls hash
  attr_accessor :polls

  def initialize
    @polls = []
  end

end

def run_national_polls
  # poll_source = 0
  # while !(["1","2","3"].include?(poll_source))
  #   puts "\nPlease select source for polling data:\n\n1 => Pollster.com\n2 => Princeton Election Consortium\n3 => RealClearPolitics\n\nPress 1, 2 or 3:"
  #   poll_source = gets.chomp
  # end
  # #Ask for max spread for a swing state and max age of polls
  # spread = 0
  # while !((1..100).include?(spread))
  #   puts "\nMax point spread for swing states:"
  #   spread = gets.chomp.to_i
  # end
  #
  # days = 0
  # while !((1..90).include?(days))
  #   puts "\nMax poll age (days):"
  #   days = gets.chomp.to_i
  # end
  #
  # puts "\nPlease wait..."
  # puts "\nThis could take a minute..."
  # state_polls = States.new
  # #binding.pry
  # state_polls.fill_polls(poll_source, days)
  # state_polls.check_swing_states(spread)
  # state_polls.count_electoral_college
  #
  # #Output Electoral College Breakdown
  # system "clear"
  # case poll_source
  # when "1" then puts "\nPolls source: Pollster.com; polls ending in the last #{days} days"
  # when "2" then puts "\nPolls source: Princeton Election Consortium; polls ending in the past #{days} days"
  # when "3" then puts "\nPolls source: RealClearPolitics; polls ending in the past #{days} days"
  # end
end
