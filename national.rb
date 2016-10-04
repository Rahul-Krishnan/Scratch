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
      polls_holder = NationalRCP::Polls.new(date)
      polls_holder.eat_polls

      if polls_holder.scores["clinton"] == []
      else
        @averages["clinton"] = polls_holder.averages["clinton"]
        @averages["trump"] = polls_holder.averages["trump"]
        @averages["johnson"] = polls_holder.averages["johnson"]
        @averages["stein"] = polls_holder.averages["stein"]
        @averages["undecided"] = polls_holder.averages["undecided"]

        polls_holder.scores["clinton"].each_with_index do |score, index|

          trump_score = polls_holder.scores["trump"][index]
          poll_name = polls_holder.names[index]
          @polls << [score.round(1), trump_score.round(1), poll_name]
        end
      end
    elsif poll_source == "2"
      polls_holder = NationalPollster::Polls.new(date)
      polls_holder.eat_polls

      if polls_holder.scores["clinton"] == []
      else
        @averages["clinton"] = polls_holder.averages["clinton"]
        @averages["trump"] = polls_holder.averages["trump"]
        @averages["johnson"] = polls_holder.averages["johnson"]
        @averages["stein"] = polls_holder.averages["stein"]
        @averages["undecided"] = polls_holder.averages["undecided"]

        polls_holder.scores["clinton"].each_with_index do |score, index|

          trump_score = polls_holder.scores["trump"][index]
          poll_name = polls_holder.names[index]
          @polls << [score.round(1), trump_score.round(1), poll_name]
        end
      end
    else
    end
  end
end

def run_national_polls
  poll_source = 0
  while !(["1","2"].include?(poll_source))
    puts "\nPlease select source for polling data:\n\n1 => RealClearPolitics\n2 => Pollster.com\n\nPress 1 or 2:"
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

  national_polls.fill_polls(poll_source, days)

  #Output National Poll Averages and 5 Latest Polls
  system "clear"
  case poll_source
  when "1" then puts "\nPolls source: RealClearPolitics; polls ending in the past #{days} days"
  when "2" then puts "\nPolls source: Pollster.com; polls ending in the last #{days} days"
  end

  puts "\n\nCurrent National Averages:"
  print "Leader"
  clintonavg = national_polls.averages["clinton"]
  trumpavg = national_polls.averages["trump"]
  if clintonavg > trumpavg
    puts "\t  *** C +#{(clintonavg - trumpavg).round(1)} ***"
  elsif clintonavg < trumpavg
    puts "\t  *** T +#{(trumpavg - clintonavg).round(1)} ***"
  else
    puts "\t  *** TIE ***"
  end
  puts "Clinton\t\t#{national_polls.averages["clinton"].round(1)}"
  puts "Trump\t\t#{national_polls.averages["trump"].round(1)}"
  puts "Johnson\t\t#{national_polls.averages["johnson"].round(1)}"
  puts "Stein\t\t#{national_polls.averages["stein"].round(1)}"
  puts "Undecided\t#{national_polls.averages["undecided"].round(1)}"

  puts "\n\n\nHere are the latest national major party poll numbers:\n\n"
  puts "\tClinton\t\tTrump\t\tLeader\t\tPolling Company"
  puts "\t-------\t\t------\t\t------\t\t---------------"

  max = [5, national_polls.polls.count].min - 1
  (0..max).each do |n|
    clinton = national_polls.polls[n][0]
    trump = national_polls.polls[n][1]
    name = national_polls.polls[n][2]
    if clinton > trump
      puts "\t #{clinton}\t\t #{trump}\t\tC +#{(clinton - trump).round(1)}\t\t#{name}"
    elsif clinton < trump
      puts "\t #{clinton}\t\t #{trump}\t\tT +#{(trump - clinton).round(1)}\t\t#{name}"
    else
      puts "\t #{clinton}\t\t #{trump}\t\t TIE\t\t#{name}"
    end
  end

end
