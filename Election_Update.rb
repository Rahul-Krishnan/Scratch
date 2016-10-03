require 'pry'
require './states.rb'
require './national.rb'

quit = false
while quit != "q"
  system "clear"
  #Take in latest Pollster/Princeton/RCP polling averages

  poll_source = 0
  while !(["1","2","3"].include?(poll_source))
    puts "\nPlease select source for polling data:\n\n1 => Pollster.com\n2 => Princeton Election Consortium\n3 => RealClearPolitics\n\nPress 1, 2 or 3:"
    poll_source = gets.chomp
  end
  #Ask for max spread for a swing state and max age of polls
  spread = 0
  while !((1..100).include?(spread))
    puts "\nMinimum point spread for \"safe\" Clinton or Trump states:"
    spread = gets.chomp.to_i
  end

  days = 0
  while !((1..90).include?(days))
    puts "\nMax poll age (days):"
    days = gets.chomp.to_i
  end

  puts "\nPlease wait..."
  puts "\nThis could take a minute..."
  state_polls = States.new
  #binding.pry
  state_polls.fill_polls(poll_source, days)
  state_polls.check_swing_states(spread)
  state_polls.count_electoral_college

  #Output Electoral College Breakdown
  system "clear"
  case poll_source
  when "1" then puts "\nPolls source: Pollster.com; polls ending in the last #{days} days"
  when "2" then puts "\nPolls source: Princeton Election Consortium; polls ending in the past #{days} days"
  when "3" then puts "\nPolls source: RealClearPolitics; polls ending in the past #{days} days"
  end
  puts "\nCurrent Electoral College Breakdown:"
  puts "\nClinton: #{state_polls.clinton_votes}\t(Need #{270-state_polls.clinton_votes} more to win)"
  state_polls.clinton_states.each do |row|
    print "#{row[0]}(#{state_polls.polls[row[0]][0]}) "
  end
  puts "\n\nTrump: #{state_polls.trump_votes}\t(Need #{270-state_polls.trump_votes} more to win)"
  state_polls.trump_states.each do |row|
    print "#{row[0]}(#{state_polls.polls[row[0]][0]}) "
  end
  puts "\n\nToss-up: #{state_polls.swing_votes}"
  state_polls.swing_states.each do |row|
    print "#{row[0]}(#{state_polls.polls[row[0]][0]}) "
  end

  #Output all swing states with current average spread
  puts "\n\nHere are the the current swing state spreads (0.0 indicates no polls available):"
  state_polls.swing_states.each do |entry|
    if entry[1] >= 0
      puts "#{entry[0]}\tC +#{entry[1].round(1)}"
    elsif entry[1] < 0
      puts "#{entry[0]}\tT +#{entry[1].round(1).abs}"
    else
    end
  end
  #binding.pry
  puts "\nPress Q to quit or any other key to continue..."
  quit = gets.chomp.downcase
end
  #binding.pry

  #Display any must-win states for each candidate
  #Display national spread
