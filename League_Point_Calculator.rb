require 'pry'
require 'terminal-table'

class LeagueTable
  attr_reader :table

  def initialize
    @table = {}
  end


  def display_table
    sorted = @table.sort_by { |team, score| [-score, team]}
    table = Terminal::Table.new :headings => ["Team","Score"], :rows => sorted
    puts table
  end

  def add_entry (team, score)
    if @table.keys.include?(team)
      @table[team] += score
    else
      @table[team] = score
  end

end

league = LeagueTable.new

puts "***PLAY BALL!***\n\n"
puts "This is a League Point Calculator for this year's Baseball Season.\nTo exit at any time, enter 'Q'.\nTo see League Rankings at any point, simply enter 'score'. This is what a sample entry looks like:\n\nYankees 5 Mets 4\n\n"

input = 0

while input != "Q" && input != "q"

    puts"Awaiting input..."
    print ">"
    input = gets.chomp.split
    input.each do |name|
      name.capitalize!
    end

    if (input[0] == "q" || input[0] == "Q")
      exit
    #show score
    elsif input[0] == "score" || input[0] == "Score"
      league.display_table
    end
    #decide points
    if input[1].to_i > input[3].to_i
      input[1] = 3
      input[3] = 0
    elsif input[1].to_i < input[3].to_i
      input[1] = 0
      input[3] = 3
    elsif input[1].to_i == input[3].to_i
      input[1] = 1
      input[3] = 1
    end
    #binding.pry

    if input[0] != "score" && input[0] != "Score"
      #add entry to league table
      league.add_entry(input[0],input[1].to_i)
      league.add_entry(input[2],input[3].to_i)
    end
    #binding.pry
  end
end
