require 'pry'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'date'
require 'csv'
require 'HTTParty'

module StateRCP
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
      page = Nokogiri::HTML(HTTParty.get("http://www.realclearpolitics.com/epolls/latest_polls/state/").body)
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
end

module NationalRCP
  class Polls

    attr_accessor :after_date, :scores, :results, :averages, :names

    def initialize after_date
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
      @names = []
    end

    def eat_polls
      page = Nokogiri::HTML(HTTParty.get("http://www.realclearpolitics.com/epolls/2016/president/us/general_election_trump_vs_clinton_vs_johnson_vs_stein-5952.html#polls").body)
      table = page.css("#polling-data-full table tr")
      date_ranges = table.css("td:nth-child(2)")
      dates = []
      dates_holder = []
      date_ranges.each do |entry|
        dates_holder << entry.text.chars.last(5).join
      end
      dates_holder.each do |entry|
        characters = entry.chars
        if characters.first == "-"
          entry.slice! "- "
        elsif characters.first == " "
          entry.slice! " "
        else
        end
        dates << Date.strptime(entry, "%m/%d")
      end

      names_master_list = []
      race_titles = table.css("td:nth-child(1) .normal_pollster_name")
      race_titles.each do |title|
        names_master_list << title.text
      end

      clinton_scores_list = []
      clinton_scores_holder = table.css("td:nth-child(5)")
      clinton_scores_holder.each do |score|
        clinton_scores_list << score.text.to_f
      end
      clinton_scores_list.shift

      trump_scores_list = []
      trump_scores_holder = table.css("td:nth-child(6)")
      trump_scores_holder.each do |score|
        trump_scores_list << score.text.to_f
      end
      trump_scores_list.shift

      johnson_scores_list = []
      johnson_scores_holder = table.css("td:nth-child(7)")
      johnson_scores_holder.each do |score|
        johnson_scores_list << score.text.to_f
      end
      johnson_scores_list.shift

      stein_scores_list = []
      stein_scores_holder = table.css("td:nth-child(8)")
      stein_scores_holder.each do |score|
        stein_scores_list << score.text.to_f
      end
      stein_scores_list.shift

      dates.each_with_index do |date, index|
        if date > @after_date
          @scores["clinton"] << clinton_scores_list[index]
          @scores["trump"] << trump_scores_list[index]
          @scores["johnson"] << johnson_scores_list[index]
          @scores["stein"] << stein_scores_list[index]
          @names << names_master_list[index]
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
      @averages["undecided"] = 100 - @averages["clinton"] - @averages["trump"] - @averages["johnson"] - @averages["stein"]
    end
  end
end
