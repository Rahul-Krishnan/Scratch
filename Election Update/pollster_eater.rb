require 'rubygems'
require 'open-uri'
require 'httparty'

module StatePollster
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
      (1..20).each do |n|
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
            pres_polls = item["subpopulations"][0]["responses"]
            @results << pres_polls
          else
          end
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
      %w(clinton trump johnson stein undecided).each do |candidate|
        @averages[candidate] = @scores[candidate].reduce(:+)/@scores[candidate].count unless @scores[candidate].count == 0
      end
    end

  end
end

module NationalPollster
  class Polls

    attr_accessor :after_date, :scores, :results, :names, :averages, :poll_list

    def initialize after_date
      @after_date = after_date
      @scores = {
        "clinton" => [],
        "trump" => [],
        "johnson" => [],
        "stein" => [],
        "undecided" => []
      }
      @results = []
      @names = []
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
      (1..20).each do |n|
        eat_pollster_page(n)
      end
      calc_averages
    end

    def eat_pollster_page(page)
      @poll_list =JSON.parse(HTTParty.get("http://elections.huffingtonpost.com/pollster/api/polls.json?page=#{page}&after=#{@after_date}&topic=2016-president&state=US").body)
      if @poll_list == []
      else

        @poll_list.each_with_index do |item, index|
          if item["questions"][0]["code"].include?("Clinton")&&item["questions"][0]["code"].include?("Trump")

            pres_polls = item["questions"][0]["subpopulations"][0]["responses"]
            @results << pres_polls
            @names << item["pollster"]
          else
          end
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
      %w(clinton trump johnson stein).each do |candidate|
        @averages[candidate] = @scores[candidate].reduce(:+)/@scores[candidate].count unless @scores[candidate].count == 0
      end
      @averages["undecided"] = 100 - @averages["clinton"] - @averages["trump"] - @averages["johnson"] - @averages["stein"]
    end

  end
end
