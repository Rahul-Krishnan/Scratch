require 'pry'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'date'
require 'csv'
require 'HTTParty'

module Odds
  class Odds

    attr_accessor :scores, :type

    def initialize type
      @type = type
      @scores = {
        "clinton" => "50.0%",
        "trump" => "50.0%",
      }
    end

    def eat_odds
      #binding.pry
      case @type.to_i
      when 1 then page = Nokogiri::HTML(HTTParty.get("http://projects.fivethirtyeight.com/2016-election-forecast/?ex_cid=rrpromo#plus").body)
      when 2 then page = Nokogiri::HTML(HTTParty.get("http://projects.fivethirtyeight.com/2016-election-forecast/?ex_cid=rrpromo").body)
      when 3 then page = Nokogiri::HTML(HTTParty.get("http://projects.fivethirtyeight.com/2016-election-forecast/?ex_cid=rrpromo#now").body)
      end

      clinton_score = page.css(".cardset.current .card.card-winprob.card-winprob-us.winprob-bar .candidate.one.dem p.candidate-val.winprob").text
      trump_score = page.css(".cardset.current .card.card-winprob.card-winprob-us.winprob-bar .candidate.three.rep p.candidate-val.winprob").text
      #binding.pry

      @scores["clinton"] = clinton_score
      @scores["trump"] = trump_score
    end

  end
end
