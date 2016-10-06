require './fivethirtyeight_eater.rb'

def run_odds_538
  polls_plus = Odds::Odds.new(1)
  polls_only = Odds::Odds.new(2)
  now_cast = Odds::Odds.new(3)

  polls_plus.eat_odds
  polls_only.eat_odds
  now_cast.eat_odds

  system "clear"
  puts "\nChances of winning:"
  puts "*******************"
  puts "\nPolls-plus:"
  puts "-----------"
  puts "Clinton: #{polls_plus.scores["clinton"]}\tTrump: #{polls_plus.scores["trump"]}"
  puts "\n\nPolls-only:"
  puts "-----------"
  puts "Clinton: #{polls_only.scores["clinton"]}\tTrump: #{polls_only.scores["trump"]}"
  puts "\n\nNow-cast:"
  puts "---------"
  puts "Clinton: #{now_cast.scores["clinton"]}\tTrump: #{now_cast.scores["trump"]}\n\n"

end
