require 'pry'
require './states.rb'
require './national.rb'

quit = false
while quit != "q"
  system "clear"
  #Take in latest Pollster/Princeton/RCP polling averages
  #Ask for max spread for a swing state and max age of polls
  puts "\nChoose source for polling data:\n1. Pollster.com\n2. Princeton Election Consortium\n3. RealClearPolitics"
  poll_source = gets.chomp

  puts "\nWhat point spread for a swing state?"
  spread = gets.chomp

  puts "\nMax poll age (days):"
  days = gets.chomp.to_i

  puts "\nPlease wait..."
  state_polls = States.new
  #binding.pry
  state_polls.fill_polls(poll_source, days)
  state_polls.check_swing_states(spread)
  state_polls.count_electoral_college

  #Output all swing states with current average spread
  system "clear"
  puts "\nCurrent Electoral College Breakdown:"
  puts "\nClinton: #{state_polls.clinton_votes}\t(Need #{270-state_polls.clinton_votes} more to win)"
  state_polls.clinton_states.each do |row|
    print "#{row[0]}(#{state_polls.polls[row[0]][0]}) "
  end
  puts "\n\nTrump: #{state_polls.trump_votes}\t(Need #{270-state_polls.trump_votes} more to win)"
  state_polls.trump_states.each do |row|
    print "#{row[0]}(#{state_polls.polls[row[0]][0]}) "
  end
  puts "\n\nSwing: #{state_polls.swing_votes}"
  state_polls.swing_states.each do |row|
    print "#{row[0]}(#{state_polls.polls[row[0]][0]}) "
  end

  puts "\n\n\nHere are the the current swing state spreads:\n\n"
  state_polls.swing_states.each do |entry|
    if entry[1] >= 0
      puts "#{entry[0]}\tC +#{entry[1].round(1)}"
    elsif entry[1] < 0
      puts "#{entry[0]}\tT +#{entry[1].round(1).abs}"
    else
    end
  end

  puts "\n\nPress Q to quit or any other key to continue..."
  quit = gets.chomp.downcase
end
  #binding.pry

  #Display any must-win states for each candidate
  #Display national spread

  #show date of last poll for each entry
