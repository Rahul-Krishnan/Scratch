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
      "AL" => [9, 40, 60, "Alabama"] ,
      "AK" => [3, 40, 60, "Alaska"] ,
      "AZ" => [11, 50, 50, "Arizona"] ,
      "AR" => [6, 40, 60, "Arkanasas"] ,
      "CA" => [55, 60, 40, "California"] ,
      "CO" => [9, 50, 50, "Colorado"] ,
      "CT" => [7, 60, 40, "Connecticut"] ,
      "DE" => [3, 60, 40, "Delaware"] ,
      "FL" => [29, 50, 50, "Florida"] ,
      "GA" => [16, 50, 50, "Georgia"] ,
      "HI" => [4, 60, 40, "Hawaii"] ,
      "ID" => [4, 40, 60, "Idaho"] ,
      "IL" => [20, 60, 40, "Illinois"] ,
      "IN" => [11, 40, 60, "Indiana"] ,
      "IA" => [6, 50, 50, "Iowa"] ,
      "KS" => [6, 40, 60, "Kansas"] ,
      "KY" => [8, 40, 60, "Kentucky"] ,
      "LA" => [8, 40, 60, "Louisiana"] ,
      "ME" => [4, 50, 50, "Maine"] ,
      "MD" => [10, 60, 40, "Maryland"] ,
      "MA" => [11, 60, 40, "Massachussets"] ,
      "MI" => [16, 50, 50, "Michigan"] ,
      "MN" => [10, 50, 50, "Minnesota"] ,
      "MS" => [6, 40, 60, "Mississippi"] ,
      "MO" => [10, 50, 50, "Missouri"] ,
      "MT" => [3, 40, 60, "Montana"] ,
      "NE" => [5, 40, 60, "Nebraska"] ,
      "NV" => [6, 50, 50, "Nevada"] ,
      "NH" => [4, 50, 50, "New Hampshire"] ,
      "NJ" => [14, 60, 40, "New Jersey"] ,
      "NM" => [5, 50, 50, "New Mexico"] ,
      "NY" => [29, 60, 40, "New York"] ,
      "NC" => [15, 50, 50, "North Carolina"] ,
      "ND" => [3, 40, 60, "North Dakota"] ,
      "OH" => [18, 50, 50, "Ohio"] ,
      "OK" => [7, 40, 60, "Oklahoma"] ,
      "OR" => [7, 60, 40, "Oregon"] ,
      "PA" => [20, 50, 50, "Pennsylvania"] ,
      "RI" => [4, 60, 40, "Rhode Island"] ,
      "SC" => [9, 40, 60, "South Carolina"] ,
      "SD" => [3, 40, 60, "South Dakota"] ,
      "TN" => [11, 40, 60, "Tennessee"] ,
      "TX" => [38, 40, 60, "Texas"] ,
      "UT" => [6, 40, 60, "Utah"] ,
      "VA" => [3, 50, 50, "Virginia"] ,
      "VT" => [13, 60, 40, "Vermont"] ,
      "WA" => [12, 60, 40, "Washington"] ,
      "WV" => [5, 40, 60, "West Virginia"] ,
      "WI" => [10, 50, 50, "Wisconsin"] ,
      "WY" => [3, 40, 60, "Wyoming"]
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
      row[4] = row[1] - row[2]
      if row[4].abs < spread.to_f
        @swing_states << [state, row[4]]
      elsif row[4] > 0
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
        if polls_holder.scores["clinton"] == []
        else
        @polls[state][1] = polls_holder.averages["clinton"]
        @polls[state][2] = polls_holder.averages["trump"]
        end
      end
    elsif poll_source == "2"
      @polls.keys.each do |state|
        polls_holder = Princeton::Polls.new(state, date)
        polls_holder.eat_polls
        #binding.pry
        if polls_holder.scores["clinton"] == []
        else
        @polls[state][1] = polls_holder.averages["clinton"]
        @polls[state][2] = polls_holder.averages["trump"]
        end
      end
    elsif poll_source == "3"
      @polls.keys.each do |state|
        polls_holder = RCP::Polls.new(@polls[state][3], date)
        polls_holder.eat_polls
        #binding.pry
        if polls_holder.scores["clinton"] == []
        else
        @polls[state][1] = polls_holder.averages["clinton"]
        @polls[state][2] = polls_holder.averages["trump"]
        end
      end
    else
    end
  end
end
