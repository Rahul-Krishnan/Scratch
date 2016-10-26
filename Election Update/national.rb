require 'rubygems'
require 'date'
require './pollster_eater.rb'
require './princeton_eater.rb'
require './rcp_eater.rb'

class National
#a national polls array and averages hash
  attr_accessor :polls, :averages

  def initialize
    @polls = []
    @averages = {}
  end

#method to pull in polling data
  def fill_polls(poll_source, days)
    date = (Date.today-days).to_s
    if poll_source == 1
      polls_holder = NationalRCP::Polls.new(date)
      polls_holder.eat_polls

      if polls_holder.scores["clinton"] == []
      else
        %w(clinton trump johnson stein undecided).each do |candidate|
          @averages[candidate] = polls_holder.averages[candidate]
        end

        polls_holder.scores["clinton"].each_with_index do |score, index|
          trump_score = polls_holder.scores["trump"][index]
          poll_name = polls_holder.names[index]
          @polls << [score.round(1), trump_score.round(1), poll_name]
        end
      end
    elsif poll_source == 2
      polls_holder = NationalPollster::Polls.new(date)
      polls_holder.eat_polls

      if polls_holder.scores["clinton"] == []
      else
        %w(clinton trump johnson stein undecided).each do |candidate|
          @averages[candidate] = polls_holder.averages[candidate]
        end

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
  while !((1..2).include?(poll_source))
    puts "\nPlease select source for polling data:"
    puts "\n1 => RealClearPolitics"
    puts "2 => Pollster.com"
    puts "\nPress 1 or 2:"
    poll_source = gets.chomp.to_i
  end
  #Ask for max age of polls

  days = 0
  while !((1..90).include?(days))
    puts "\nMax poll age (days):"
    days = gets.chomp.to_i
  end

  puts "\nPlease wait..."
  national_polls = National.new

  national_polls.fill_polls(poll_source, days)

  #Output National Poll Averages and 5 Latest Polls with pollster name
  system "clear"
  case poll_source
  when 1 then puts "\nPolls source: RealClearPolitics; polls ending in the past #{days} days"
  when 2 then puts "\nPolls source: Pollster.com; polls ending in the last #{days} days"
  end

  puts "\n\nCurrent National Averages:"
  print "\nLeader"
  clintonavg = national_polls.averages["clinton"]
  trumpavg = national_polls.averages["trump"]
  if clintonavg > trumpavg
    puts "\t\t  *** C +#{(clintonavg - trumpavg).round(1)} ***"
  elsif clintonavg < trumpavg
    puts "\t\t  *** T +#{(trumpavg - clintonavg).round(1)} ***"
  else
    puts "\t\t  *** TIE ***"
  end
  puts "\nClinton\t\t\t#{national_polls.averages["clinton"].round(1)}"
  puts "Trump\t\t\t#{national_polls.averages["trump"].round(1)}"
  puts "Johnson\t\t\t#{national_polls.averages["johnson"].round(1)}"
  puts "Stein\t\t\t#{national_polls.averages["stein"].round(1)}"
  puts "Other/Undecided\t\t#{national_polls.averages["undecided"].round(1)}"

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
