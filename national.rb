require 'pry'
require 'rubygems'
require 'date'
require './pollster_eater.rb'
require './princeton_eater.rb'
require './rcp_eater.rb'

class National
#a national polls hash
  attr_accessor :polls, :averages

  def initialize
    @polls = []
    @averages = {}
  end

#method to pull in polling data
  def fill_polls(poll_source, days)
    date = (Date.today-days).to_s
    if poll_source == "1"
        polls_holder = NationalPollster::Polls.new(date)
        polls_holder.eat_polls
        #binding.pry
        if polls_holder.scores["clinton"] == []
        else
          @averages["clinton"] = polls_holder.averages["clinton"]
          @averages["trump"] = polls_holder.averages["trump"]
          @averages["johnson"] = polls_holder.averages["johnson"]
          @averages["stein"] = polls_holder.averages["stein"]
          @averages["undecided"] = polls_holder.averages["undecided"]

          polls_holder.scores["clinton"].each_with_index do |score, index|
            #binding.pry
            trump_score = polls_holder.scores["trump"][index]
            @polls << [score.round(1), trump_score.round(1)]
          end
        end
    elsif poll_source == "2"
      @polls.keys.each do |state|
        polls_holder = NationalRCP::Polls.new(date)
        polls_holder.eat_polls
        #binding.pry
        if polls_holder.scores["clinton"] == []
        else
        @polls[1] = polls_holder.averages["clinton"]
        @polls[2] = polls_holder.averages["trump"]
        end
      end
    else
    end
  end
end

def run_national_polls
  poll_source = 0
  while !(["1","2"].include?(poll_source))
    puts "\nPlease select source for polling data:\n\n1 => Pollster.com\n2 => RealClearPolitics\n\nPress 1 or 2:"
    poll_source = gets.chomp
  end
  #Ask for max age of polls

  days = 0
  while !((1..90).include?(days))
    puts "\nMax poll age (days):"
    days = gets.chomp.to_i
  end

  puts "\nPlease wait..."
  puts "\nThis could take a minute..."
  national_polls = National.new
  #binding.pry
  national_polls.fill_polls(poll_source, days)

  #Output National Poll Averages and 5 Latest Polls
  system "clear"
  case poll_source
  when "1" then puts "\nPolls source: Pollster.com; polls ending in the last #{days} days"
  when "2" then puts "\nPolls source: RealClearPolitics; polls ending in the past #{days} days"
  end

  puts "\n\nCurrent National Averages:\n\n"
  puts "Clinton\t\t#{national_polls.averages["clinton"].round(1)}"
  puts "Trump\t\t#{national_polls.averages["trump"].round(1)}"
  puts "Johnson\t\t#{national_polls.averages["johnson"].round(1)}"
  puts "Stein\t\t#{national_polls.averages["stein"].round(1)}"
  puts "Undecided\t#{national_polls.averages["undecided"].round(1)}"

  puts "\n\n\nHere are the latest national major party poll numbers:\n\n"
  puts "\tClinton\t\tTrump\t\tLeader"
  (0..4).each do |n|
    clinton = national_polls.polls[n][0]
    trump = national_polls.polls[n][1]
    if clinton > trump
      puts "\t #{clinton}\t\t #{trump}\t\tC +#{clinton - trump}"
    elsif clinton < trump
      puts "\t #{clinton}\t\t #{trump}\t\tT +#{trump - clinton}"
    else
      puts "\t #{clinton}\t\t #{trump}\t\t TIE"
    end
  end

end
