#Player Class
class Player
  attr_accessor :name, :bankroll, :wager, :card_1, :card_2
  attr_reader :score, :busted

  def initialize name, bankroll, wager, card_1, card_2
    @name = name
    @bankroll = bankroll
    @wager = wager
    @card_1 = card_1
    @card_2 = card_2
    @score = score
    @busted = false
  end

  def deal
    @card_1 = rand(1..10)
    @card_2 = rand(1..10)
    @score = @card_1 + @card_2
    @busted = false
  end

  def hit
    new_card = rand(1..10)
    puts "HIT with: #{new_card}"
    @score = @score + new_card
  end

  def check_bust
    if @score > 21
      @busted = true
    else
      @busted = false
    end
  end
end

#Initialize Players
human = Player.new "human", 0, 0, 1, 1
dealer = Player.new "dealer", 0, 0, 1, 1

#Introduction to the game
puts "Welcome to our Blackjack table! What is your name?"
human.name = gets.chomp.capitalize
puts "How much are you bringing to the table?"
human.bankroll = gets.chomp.to_i

quit = ""
while quit.downcase != "q" && human.bankroll > 0
  #Round begins
  human.deal
  dealer.deal
  puts "*" * 20
  puts "NEW ROUND BEGINNING"
  puts "*" * 20
  puts "Place your bet:"
  human.wager = gets.chomp.to_i
  #check the bet isn't more than your bankroll
  while human.wager > human.bankroll
    puts "Uh oh. You can't wager more than you have! Place your bet:"
    human.wager = gets.chomp.to_i
  end
  puts "\nHere are your cards:"
  puts "#{human.card_1}\n#{human.card_2}\nTotal Score of #{human.score}"
  puts "\nHere is the Dealer's open card:"
  puts "#{dealer.card_1}"

  #Human plays the game
  puts "\nWould you like to (H)it or (S)tay?"
  choice = gets.chomp
  while choice.downcase != "h" && choice.downcase != "s"
    puts "That didn't make sense. (H)it or (S)tay?"
    choice = gets.chomp
  end
  while choice.downcase == "h" && human.busted == false
    human.hit
    human.check_bust
    if human.busted == true
      puts "#{human.name} BUSTED! Dealer wins!"
      human.bankroll = human.bankroll - human.wager
      break
    else
      puts "Your total score is #{human.score}\n\n"
      puts "Would you like to (H)it or (S)tay?"
      choice = gets.chomp
    end
  end

  #Dealer plays the game
  puts "*"*20
  puts ""
  puts "Dealer holds #{dealer.card_1} and #{dealer.card_2} (Total Score of #{dealer.score})"
  while human.busted == false && dealer.busted == false && dealer.score <17
    dealer.hit
    dealer.check_bust
    if dealer.busted == true
      puts "Dealer BUSTED! #{human.name} wins!"
      human.bankroll = human.bankroll + human.wager
      break
    else
      puts "Dealer's total score is #{dealer.score}"
    end
  end

  #Round Result
  if human.busted == false && dealer.busted == false
    puts "\nYour final score is #{human.score} and the dealer scored #{dealer.score}"
    if human.score > dealer.score
      puts "\n#{human.name} wins!"
      human.bankroll = human.bankroll + human.wager
    elsif human.score < dealer.score
      puts "\nDealer wins!"
      human.bankroll = human.bankroll - human.wager
    else
      puts "\nTIE! Dealer wins the push!"
      human.bankroll = human.bankroll - human.wager
    end
  else
  end

  #Next Round Input
  puts "*"*20
  puts ""
  if human.bankroll > 0
    puts "New Bankroll: #{human.bankroll}"
    puts "*"*20
    puts "Press Q to Quit, or any other key to continue..."
    quit = gets.chomp
  else
    puts "Sorry, you're flat broke! Get out of here!"
  end
end