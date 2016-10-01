require 'pry'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'httparty'

module Pollster
  class Polls

    attr_accessor :state, :after_date, :scores, :results, :averages, :poll_list

    def initialize state, after_date
      @state = state
      @after_date = after_date
      @scores = {
        "clinton" => [],
        "trump" => [],
        "johnson" => [],
        "stein" => [],
        "undecided" => []
      }
      @results = []
      @averages = {
        "clinton" => 0,
        "trump" => 0,
        "johnson" => 0,
        "stein" => 0,
        "undecided" => 0
      }
      @poll_list = []
    end

    def eat_polls
      (1..30).each do |n|
        eat_pollster_page(n)
      end
      calc_averages
    end

    def eat_pollster_page(page)
      json =JSON.parse(HTTParty.get("http://elections.huffingtonpost.com/pollster/api/polls.json?page=#{page}&after=#{@after_date}&topic=2016-president&state=#{@state}").body)
      if json == []
      else
        @poll_list = json[0]["questions"]
        @poll_list.each do |item|
          if item["code"].include?("Clinton")&&item["code"].include?("Trump")
            #puts item["name"]
            #binding.pry
            pres_polls = item["subpopulations"][0]["responses"]
            @results << pres_polls
          else
          end
          #puts
        end
        @results.each do |poll|
          poll.each do |entry|
            if entry["choice"].include?("Clinton")
              @scores["clinton"] << entry["value"]
            elsif entry["choice"].include?("Trump")
              @scores["trump"] << entry["value"]
            elsif entry["choice"].include?("Johnson")
              @scores["johnson"] << entry["value"]
            elsif entry["choice"].include?("Stein")
              @scores["stein"] << entry["value"]
            elsif entry["choice"].include?("Undecided")
              @scores["undecided"] << entry["value"]
            else
            end
          end
        end
      end
    end

    def calc_averages
      @averages["clinton"] = @scores["clinton"].reduce(:+)/@scores["clinton"].count unless @scores["clinton"].count == 0
      @averages["trump"] = @scores["trump"].reduce(:+)/@scores["trump"].count unless @scores["trump"].count == 0
      @averages["johnson"] = @scores["johnson"].reduce(:+)/@scores["johnson"].count unless @scores["johnson"].count == 0
      @averages["stein"] = @scores["stein"].reduce(:+)/@scores["stein"].count unless @scores["stein"].count == 0
      @averages["undecided"] = @scores["undecided"].reduce(:+)/@scores["undecided"].count unless @scores["undecided"].count == 0
    end

  end
end
