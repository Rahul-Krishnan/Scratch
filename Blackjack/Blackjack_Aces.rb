#Player Class
class Player
  attr_accessor :name, :bankroll, :wager #Should :cards go in accessor or reader? Seems to work either way, so why should it matter? Wouldn't keeping all the methods as attr_accessor give more flexibility in the code?
  attr_reader :score, :busted, :deck, :cards # Is it ok to initialize a data-filled hash? Why start out calling any of the variables strings (eg bankroll- i could have set it at 0 instead of "bankroll" to start)? Does it matter or is it irrelevant as a placeholder?

  def initialize name, bankroll, wager
    @name = name
    @bankroll = bankroll
    @wager = wager
    @cards = []
    @score = score
    @busted = false
    @deck = {
      "2" => 2,
      "3" => 3,
      "4" => 4,
      "5" => 5,
      "6" => 6,
      "7" => 7,
      "8" => 8,
      "9" => 9,
      "10" => 10,
      "Jack" => 10.001,
      "Queen" => 10.002,
      "King" => 10.003,
      "Ace" => 11
    }
  end

  def deal
    @cards = []
    @busted = false
    @cards << @deck.values.sample
    @cards << @deck.values.sample
    @score = @cards[0].to_i + @cards[1].to_i
    #Aces 1 vs 11 adjusmtent
    if @cards.include?(11) && @score > 21
      @cards[@cards.index(11)] = 1
      @score = @score - 10
    else
    end
  end

  def hit
    new_card = @deck.values.sample
    puts "HIT with: #{@deck.key(new_card)}"
    @cards << new_card
    @score = @score + new_card.to_i
    #Aces 1 vs 11 adjusmtent
    if @cards.include?(11) && @score > 21
      @cards[@cards.index(11)] = 1
      @score = @score - 10
    else
    end
  end

  def check_bust
    if @score > 21
      @busted = true
    else
      @busted = false
    end
  end
end

#############################################################

#Initialize Players
human = Player.new "human", 0, 0
dealer = Player.new "dealer", 0, 0

#Introduction to the game
puts "Welcome to our Blackjack table! What is your name?"
human.name = gets.chomp.capitalize
puts "How much are you bringing to the table?"
human.bankroll = gets.chomp.to_i
#Error check
while human.bankroll == 0
  puts "That isn't a number! How much do you want to play with?"
  human.bankroll = gets.chomp.to_i
end

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

  #Error check
  while human.wager == 0 || human.wager > human.bankroll
    #check the wager is a number
    if human.wager == 0
      puts "That isn't a number! Place your bet:"
      human.wager = gets.chomp.to_i
    #check the bet isn't more than your bankroll
    else human.wager > human.bankroll
      puts "Uh oh. You can't wager more than you have! Place your bet:"
      human.wager = gets.chomp.to_i
    end
  end

  #Initial card display
  puts "\nHere are your cards:"
  #Double-Ace exception
  first_human_card = human.deck.key(human.cards[0])
  first_human_card ||= "Ace"
  print "#{first_human_card}\n#{human.deck.key(human.cards[1])}\nTotal Score of #{human.score}"
  #Notify if player has Blackjack
  if human.score == 21
    puts " ***BLACKJACK***"
  else
    puts ""
  end
  puts "\nHere is the Dealer's open card:"
  #Double-Ace exception
  first_dealer_card = dealer.deck.key(dealer.cards[0])
  first_dealer_card ||= "Ace"
  puts "#{first_dealer_card}"

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
      while choice.downcase != "h" && choice.downcase != "s"
        puts "That didn't make sense. (H)it or (S)tay?"
        choice = gets.chomp
      end
    end
  end

  puts "*"*20
  puts ""

  #Dealer initial adjustments and statements
  print "Dealer holds #{first_dealer_card} and #{dealer.deck.key(dealer.cards[1])} (Total Score of #{dealer.score})"
  #Notify if dealer has Blackjack
  if dealer.score == 21
    puts " ***BLACKJACK***"
  else
    puts ""
  end

  #Dealer plays the game
  while human.busted == false && dealer.busted == false && dealer.score <17
    dealer.hit
    dealer.check_bust
    if dealer.busted == true
      puts "Dealer BUSTED! #{human.name} wins!"
      human.bankroll = human.bankroll + human.wager
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
      puts "\nPUSH! Nobody wins the tie!"
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
