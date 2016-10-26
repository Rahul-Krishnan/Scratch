require './fivethirtyeight_eater.rb'
require './upshot_eater.rb'

def run_odds

  puts "\nPlease wait..."

  polls_plus = NationalFivethirtyeight::Odds.new(1)
  polls_only = NationalFivethirtyeight::Odds.new(2)
  now_cast = NationalFivethirtyeight::Odds.new(3)

  upshot = UpshotSummary::Odds.new(1)
  fivethirtyeight = UpshotSummary::Odds.new(2)
  dailykos = UpshotSummary::Odds.new(3)
  huffpost = UpshotSummary::Odds.new(4)
  predictwise = UpshotSummary::Odds.new(5)
  princeton = UpshotSummary::Odds.new(6)

  polls_plus.eat_odds
  polls_only.eat_odds
  now_cast.eat_odds

  upshot.eat_odds
  fivethirtyeight.eat_odds
  dailykos.eat_odds
  huffpost.eat_odds
  predictwise.eat_odds
  princeton.eat_odds

  system "clear"
  puts "\nCurrent Market and Model Predictions:"
  puts "*"*65
  # puts "Predictwise"
  # puts "*"
  # puts "Betting Odds:\t\tClinton: #{predictwise.scores["clinton"].round(1)}%\t\tTrump: #{predictwise.scores["trump"].round(1)}%"
  # puts "*"*65
  puts "Fivethiryeight.com"
  puts "*"
  # puts "Polls-plus:\t\tClinton: #{polls_plus.scores["clinton"].round(1)}%\t\tTrump: #{polls_plus.scores["trump"].round(1)}%"
  # puts "*"
  puts "Polls-only:\t\tClinton: #{polls_only.scores["clinton"].round(1)}%\t\tTrump: #{polls_only.scores["trump"].round(1)}%"
  # puts "*"
  # puts "Now-cast:\t\tClinton: #{now_cast.scores["clinton"].round(1)}%\t\tTrump: #{now_cast.scores["trump"].round(1)}%"
  puts "*"*65
  puts "Princeton Election Consortium"
  puts "*"
  puts "Prediction:\t\tClinton: #{princeton.scores["clinton"].round(1)}%\t\tTrump: #{princeton.scores["trump"].round(1)}%"
  puts "*"*65
  puts "Pollster.com"
  puts "*"
  puts "Prediction:\t\tClinton: #{huffpost.scores["clinton"].round(1)}%\t\tTrump: #{huffpost.scores["trump"].round(1)}%"
  puts "*"*65
  puts "NYTimes Upshot"
  puts "*"
  puts "Prediction:\t\tClinton: #{upshot.scores["clinton"].round(1)}%\t\tTrump: #{upshot.scores["trump"].round(1)}%"
  puts "*"*65
  # puts "Daily Kos"
  # puts "*"
  # puts "Prediction:\t\tClinton: #{dailykos.scores["clinton"].round(1)}%\t\tTrump: #{dailykos.scores["trump"].round(1)}%"
  # puts "*"*65

end
