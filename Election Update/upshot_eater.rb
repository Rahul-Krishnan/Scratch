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
      page = Nokogiri::HTML(HTTParty.get("http://www.nytimes.com/interactive/2016/upshot/presidential-polls-forecast.html").body)
      #binding.pry
      case @type.to_i
      when 1 then clinton_score = page.css(".comparisons.topline-comparison.president .rating:nth-child(3) .rating-swatch.leaning-dem").text.chars.first(4).join.to_f
      when 2 then clinton_score = page.css(".comparisons.topline-comparison.president .rating:nth-child(4) .rating-swatch.leaning-dem").text.chars.first(4).join.to_f
      when 3 then clinton_score = page.css(".comparisons.topline-comparison.president .rating:nth-child(5) .rating-swatch.leaning-dem").text.chars.first(4).join.to_f
      when 4 then clinton_score = page.css(".comparisons.topline-comparison.president .rating:nth-child(6) .rating-swatch.leaning-dem").text.chars.first(4).join.to_f
      when 5 then clinton_score = page.css(".comparisons.topline-comparison.president .rating:nth-child(7) .rating-swatch.leaning-dem").text.chars.first(4).join.to_f
      when 6 then clinton_score = page.css(".comparisons.topline-comparison.president .rating:nth-child(8) .rating-swatch.leaning-dem").text.chars.first(4).join.to_f
      else
      end


      trump_score = 100 - clinton_score
      #binding.pry

      @scores["clinton"] = clinton_score
      @scores["trump"] = trump_score
    end

  end
end
