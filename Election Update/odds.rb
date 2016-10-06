require './fivethirtyeight_eater.rb'
require './upshot_eater.rb'

def run_odds

  puts "\nPlease wait..."

  polls_plus = Fivethirtyeight::Odds.new(1)
  polls_only = Fivethirtyeight::Odds.new(2)
  now_cast = Fivethirtyeight::Odds.new(3)

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
  puts "Source: Predictwise"
  puts "*"
  puts "Betting Odds:\t\tClinton: #{predictwise.scores["clinton"]}%\t\tTrump: #{predictwise.scores["trump"]}%"
  puts "*"*65
  puts "Source: Fivethiryeight.com"
  puts "*"
  puts "Polls-plus:\t\tClinton: #{polls_plus.scores["clinton"]}%\t\tTrump: #{polls_plus.scores["trump"]}%"
  puts "*"
  puts "Polls-only:\t\tClinton: #{polls_only.scores["clinton"]}%\t\tTrump: #{polls_only.scores["trump"]}%"
  puts "*"
  puts "Now-cast:\t\tClinton: #{now_cast.scores["clinton"]}%\t\tTrump: #{now_cast.scores["trump"]}%"
  puts "*"*65
  puts "Source: Princeton Election Consortium"
  puts "*"
  puts "Prediction:\t\tClinton: #{princeton.scores["clinton"]}%\t\tTrump: #{princeton.scores["trump"]}%"
  puts "*"*65
  puts "Source: Pollster.com"
  puts "*"
  puts "Prediction:\t\tClinton: #{huffpost.scores["clinton"]}%\t\tTrump: #{huffpost.scores["trump"]}%"
  puts "*"*65
  puts "Source: NYTimes Upshot"
  puts "*"
  puts "Prediction:\t\tClinton: #{upshot.scores["clinton"]}%\t\tTrump: #{upshot.scores["trump"]}%"
  puts "*"*65
  puts "Source: Daily Kos"
  puts "*"
  puts "Prediction:\t\tClinton: #{dailykos.scores["clinton"]}%\t\tTrump: #{dailykos.scores["trump"]}%"
  puts "*"*65

end
