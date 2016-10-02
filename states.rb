require 'pry'
require 'rubygems'
require 'date'
require './pollster_eater.rb'
require './princeton_eater.rb'
require './rcp_eater.rb'

class States

#a hash for all the polls and EC votes
#a sorted array for swing state electoral college votes
#swing, clinton and trump state arrays

  attr_accessor :polls, :swing_states, :clinton_states, :trump_states, :swing_votes, :clinton_votes, :trump_votes

  def initialize
    @polls = {
      "AL" => [9, 40, 60] ,
      "AK" => [3, 40, 60] ,
      "AZ" => [11, 50, 50] ,
      "AR" => [6, 40, 60] ,
      "CA" => [55, 60, 40] ,
      "CO" => [9, 50, 50] ,
      "CT" => [7, 60, 40] ,
      "DE" => [3, 60, 40] ,
      "FL" => [29, 50, 50] ,
      "GA" => [16, 50, 50] ,
      "HI" => [4, 60, 40] ,
      "ID" => [4, 40, 60] ,
      "IL" => [20, 60, 40] ,
      "IN" => [11, 40, 60] ,
      "IA" => [6, 50, 50] ,
      "KS" => [6, 40, 60] ,
      "KY" => [8, 40, 60] ,
      "LA" => [8, 40, 60] ,
      "ME" => [4, 50, 50] ,
      "MD" => [10, 60, 40] ,
      "MA" => [11, 60, 40] ,
      "MI" => [16, 50, 50] ,
      "MN" => [10, 50, 50] ,
      "MS" => [6, 40, 60] ,
      "MO" => [10, 50, 50] ,
      "MT" => [3, 40, 60] ,
      "NE" => [5, 40, 60] ,
      "NV" => [6, 50, 50] ,
      "NH" => [4, 50, 50] ,
      "NJ" => [14, 60, 40] ,
      "NM" => [5, 50, 50] ,
      "NY" => [29, 60, 40] ,
      "NC" => [15, 50, 50] ,
      "ND" => [3, 40, 60] ,
      "OH" => [18, 50, 50] ,
      "OK" => [7, 40, 60] ,
      "OR" => [7, 60, 40] ,
      "PA" => [20, 50, 50] ,
      "RI" => [4, 60, 40] ,
      "SC" => [9, 40, 60] ,
      "SD" => [3, 40, 60] ,
      "TN" => [11, 40, 60] ,
      "TX" => [38, 40, 60] ,
      "UT" => [6, 40, 60] ,
      "VA" => [3, 50, 50] ,
      "VT" => [13, 60, 40] ,
      "WA" => [12, 60, 40] ,
      "WV" => [5, 40, 60] ,
      "WI" => [10, 50, 50] ,
      "WY" => [3, 40, 60]
      }
    @swing_states = []
    @clinton_states = []
    @trump_states = []
    @clinton_votes = 0
    @trump_votes = 0
    @swing_votes = 0
  end

#a method to count paths to 270
#a method to find must-win states

#method to find swing states and margins
  def check_swing_states(spread)
    @polls.each do |state, row|
      row[3] = row[1] - row[2]
      if row[3].abs < spread.to_f
        @swing_states << [state, row[3]]
      elsif row[3] > 0
        @clinton_states << [state, row[1]]
      else
        @trump_states << [state, row[2]]
      end
    end
    @swing_states.sort! {|a,b| a[1].abs <=> b[1].abs}
    @clinton_states.sort! {|a,b| a[1].abs <=> b[1].abs}
    @trump_states.sort! {|a,b| a[1].abs <=> b[1].abs}
  end

#method to add up electoral college votes
  def count_electoral_college
    @swing_states.each do |row|
      @swing_votes += @polls[row[0]][0]
    end
    @clinton_states.each do |row|
      @clinton_votes += @polls[row[0]][0]
    end
    @trump_states.each do |row|
      @trump_votes += @polls[row[0]][0]
    end
  end

#method to pull in polling data
  def fill_polls(poll_source, days)
    date = (Date.today-days).to_s
    if poll_source == "1"
      @polls.keys.each do |state|
        polls_holder = Pollster::Polls.new(state, date)
        polls_holder.eat_polls
        #binding.pry
        @polls[state][1] = polls_holder.averages["clinton"]
        @polls[state][2] = polls_holder.averages["trump"]
      end
    elsif poll_source == "2"
      @polls.keys.each do |state|
        polls_holder = Princeton::Polls.new(state, date)
        polls_holder.eat_polls
        #binding.pry
        @polls[state][1] = polls_holder.averages["clinton"]
        @polls[state][2] = polls_holder.averages["trump"]
      end
    elsif poll_source == "3"
      @polls.keys.each do |state|
        polls_holder = RCP::Polls.new(state, date)
        polls_holder.eat_polls
        #binding.pry
        @polls[state][1] = polls_holder.averages["clinton"]
        @polls[state][2] = polls_holder.averages["trump"]
      end
    else
    end
  end
end
