require 'pry'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'date'
require 'csv'
require 'HTTParty'

module Fivethirtyeight

  class Polls

    attr_accessor :state, :after_date, :scores, :results, :averages

    def initialize state, after_date
      @state = state
      @after_date = Date.strptime(after_date, "%Y-%m-%d")
      @scores = {
        "clinton" => [],
        "trump" => [],
        "johnson" => [],
        "stein" => [],
        "undecided" => []
      }
      @averages = {
        "clinton" => 0,
        "trump" => 0,
        "johnson" => 0,
        "stein" => 0,
        "undecided" => 0
      }
    end

    def eat_polls
      #page = Nokogiri::HTML(HTTParty.get("http://projects.fivethirtyeight.com/2016-election-forecast/#{...}/#now").body)
      date_summary = []
      dates_holder = page.css(".table-races .date b")
      dates_holder.each do |element|
        date_summary << Date.strptime(element.text, "%a, %b %d")
      end
      counts = []
      page.css(".sortable").each do |table|
        counts << table.search("tr").size-1
      end
      dates = []
      date_summary.each do |date|
        counts[date_summary.index(date)].times do
          dates << date
        end
      end
      races_title =[]
      races_holder = page.css(".lp-race a")
      races_holder.each do |element|
        races_title << element.text
      end
      results =[]
      results_holder = page.css(".lp-results a")
      results_holder.each do |element|
        results << element.text.split(/, /)
      end
      n = dates.length-1

      (0..n).each do |x|
        if (dates[x] > @after_date && races_title[x].include?(@state))
          results[x].each do |entry|
            if entry.include?("linton")
              @scores["clinton"] << entry.split(/\s/)[1].to_f
            elsif entry.include?("rump")
              @scores["trump"] << entry.split(/\s/)[1].to_f
            elsif entry.include?("ohnson")
              @scores["johnson"] << entry.split(/\s/)[1].to_f
            elsif entry.include?("tein")
              @scores["stein"] << entry.split(/\s/)[1].to_f
            elsif entry.include?("ndecided")
              @scores["undecided"] << entry.split(/\s/)[1].to_f
            else
            end
          end
        else
        end
      end
      calc_averages
    end

    def calc_averages
      @averages["clinton"] = @scores["clinton"].reduce(:+)/@scores["clinton"].count unless @scores["clinton"].count == 0
      @averages["trump"] = @scores["trump"].reduce(:+)/@scores["trump"].count unless @scores["trump"].count == 0
      @averages["johnson"] = @scores["johnson"].reduce(:+)/@scores["johnson"].count unless @scores["johnson"].count == 0
      @averages["stein"] = @scores["stein"].reduce(:+)/@scores["stein"].count unless @scores["stein"].count == 0
      @averages["undecided"] = @scores["undecided"].reduce(:+)/@scores["undecided"].count unless @scores["undecided"].count == 0
    end

  end


  class Odds

    attr_accessor :scores, :type

    def initialize type
      @type = type
      @scores = {
        "clinton" => 50,
        "trump" => 50,
      }
    end

    def eat_odds
      #binding.pry
      case @type.to_i
      when 1 then page = Nokogiri::HTML(HTTParty.get("http://projects.fivethirtyeight.com/2016-election-forecast/#plus").body)
      when 2 then page = Nokogiri::HTML(HTTParty.get("http://projects.fivethirtyeight.com/2016-election-forecast/").body)
      when 3 then page = Nokogiri::HTML(HTTParty.get("http://projects.fivethirtyeight.com/2016-election-forecast/#now").body)
      end
.css(".screen .cardset.current .cards .candidate-val.winprob").text
      clinton_score = page.css(".cardset.current .cards .candidate.dem p.candidate-val.winprob").text
      trump_score = page.css(".cardset.current .cards .candidate.rep p.candidate-val.winprob").text
      #binding.pry

      @scores["clinton"] = clinton_score.chars.first(4).join.to_f
      @scores["trump"] = trump_score.chars.first(4).join.to_f
    end

  end
end
