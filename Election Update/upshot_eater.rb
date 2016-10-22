require 'pry'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'HTTParty'

module UpshotSummary
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
      case @type.to_i
      when 1
        then page = Nokogiri::HTML(HTTParty.get("http://www.nytimes.com/interactive/2016/upshot/presidential-polls-forecast.html#other-forecasts").body)
        clinton_score = page.css(".g-cand-top-line-est.clinton-est").text.chars.first(3).join.to_f
      when 2
        then page = Nokogiri::HTML(HTTParty.get("http://www.nytimes.com/interactive/2016/upshot/presidential-polls-forecast.html#other-forecasts").body)
        clinton_score = page.css(".comparisons.topline-comparison.president .rating:nth-child(4) .rating-swatch.leaning-dem").text.chars.first(4).join.to_f
      when 3
        then page = Nokogiri::HTML(HTTParty.get("http://elections.dailykos.com/app/elections/2016/office/president").body)
        clinton_score = page.css(".right-column h2 span").text.chars.first(3).join.to_f
        #binding.pry
      when 4
        then page = Nokogiri::HTML(HTTParty.get("http://elections.huffingtonpost.com/2016/forecast/president").body)
        clinton_score = page.css("#president-summary .clinton strong").text.chars.first(4).join.to_f
      when 5
        then page = Nokogiri::HTML(HTTParty.get("http://predictwise.com/politics/2016-president-winner").body)
        clinton_score = page.css(".table-wrapper .odd td:nth-child(1)").text.chars.first(2).join.to_f
        #binding.pry
      when 6
        then page = Nokogiri::HTML(HTTParty.get("http://election.princeton.edu/").body)
         clinton_score = page.css("#nav li:nth-child(4) a").text.chars.last(3).first(2).join.to_f
         #binding.pry
      else
      end


      trump_score = 100 - clinton_score
      #binding.pry

      @scores["clinton"] = clinton_score
      @scores["trump"] = trump_score
    end

  end
end
