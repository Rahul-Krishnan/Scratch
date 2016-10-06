require 'pry'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'HTTParty'

module Fivethirtyeight
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
