require 'pry'
require 'rubygems'
require 'open-uri'
require 'csv'
require 'date'

module StatePrinceton
  class Polls

    attr_accessor :state, :after_date, :scores, :averages, :poll_list

    def initialize state, after_date
      @state = state
      @after_date = Date.strptime(after_date, "%Y-%m-%d")
      @scores = {
        "clinton" => [],
        "trump" => [],
        "other" => [],
        "undecided" => []
      }
      @averages = {
        "clinton" => 0,
        "trump" => 0,
        "other" => 0,
        "undecided" => 0
      }
      @poll_list = []
    end


    def eat_polls
      data = open("http://election.princeton.edu/code/data/2016_StatePolls.csv")
      @poll_list = CSV.parse(data.read)

      @poll_list.shift
      @poll_list.each do |row|
        if ((row[0] == @state) && (Date.strptime(row[16], "%m/%d/%Y") > @after_date))
          @scores["trump"] << row[11].to_f
          @scores["clinton"] << row[12].to_f
          unless row[13].nil?
            @scores["other"] << row[13].to_f
          end
          unless row[14].nil?
          @scores["undecided"] << row[14].to_f
          end
        else
        end
      end
      calc_averages
    end

    def calc_averages
      %w(clinton trump other undecided).each do |candidate|
        @averages[candidate] = @scores[candidate].reduce(:+)/@scores[candidate].count unless @scores[candidate].count == 0
      end
    end
  end
end
