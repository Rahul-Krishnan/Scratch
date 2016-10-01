require 'pry'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'httparty'
require 'date'
require './pollster_eater.rb'
require './princeton_eater.rb'
require './rcp_eater.rb'

class States

  attr_accessor :polls, :swing_states

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
  end
#a sorted hash for all the polls
#a sorted hash for state electoral college votes
#a swing state hash
#a display method
#a method to count paths to 270
#a method to find must-win states
#a method to pull in polling data

  def check_swing_states(spread)
    @polls.each do |state, row|
      row[3] = (row[2] - row[1]).abs
      if row[3] < spread.to_f
        @swing_states << state
      else
      end
    end
  end

  def fill_polls(poll_source)
    date = (Date.today-7).to_s
      if poll_source == 1
        @polls.keys.each do |state|
          polls = Pollster::Polls.new(state, date)
          polls.eat_polls
          @polls[state][1] = polls.averages["clinton"]
          @polls[state][2] = polls.averages["trump"]
        end
      elsif poll_source == 2
        @polls.keys.each do |state|
          polls = Princeton::Polls.new(state, date)
          polls.eat_polls
          @polls[state][1] = polls.averages["clinton"]
          @polls[state][2] = polls.averages["trump"]
        end
      elsif poll_source == 3
        @polls.keys.each do |state|
          polls = RCP::Polls.new(state, date)
          polls.eat_polls
          @polls[state][1] = polls.averages["clinton"]
          @polls[state][2] = polls.averages["trump"]
        end
      else
      end
  end
end
