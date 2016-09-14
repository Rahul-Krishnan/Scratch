require 'pry'
class Card
  attr_reader :face, :suit, :value

  def initialize(face, suit, value)
    @face = face
    @suit = suit
    @value = value
  end

  def to_s
    "#{@face} of #{@suit}"
  end

end

class Deck
  def initialize
    @card_list = []
    ["Spades", "Clubs", "Hearts", "Diamonds"].each do |suit|
      @card_list << Card.new("King", suit, 10)
      @card_list << Card.new("Queen", suit, 10)
      @card_list << Card.new("Jack", suit, 10)
      @card_list << Card.new("Ace", suit, 11)
      (2..10).each do |face|
        @card_list << Card.new(face.to_s, suit, face)
      end
    end
    @card_list.shuffle!
  end

  def get_card
    @card_list.pop
  end
end

class Player
  attr_reader :name

  def initialize(name)
    @name = name
    @hand = []
    @hand_total = 0
  end

  def give_card(card)
    @hand << card
    @hand_total += card.value
  end

  def show_card
    puts "#{@name} has a card: #{@hand[0]}"
  end

  def show_cards
    puts "#{@name} has the following cards: #{@hand.join(", ")} for a total value of #{@hand_total}"
  end

  def hand_value
    @hand_total
  end

end

deck = Deck.new #Write a Deck class
dealer = Player.new("Dealer") #Write a Player class, with a name
puts "What is your name?"
name = gets.chomp
player = Player.new("Player")
#binding.pry
dealer.give_card(deck.get_card) #Player class needs method give_card
dealer.give_card(deck.get_card) #Deck class needs method get_card

player.give_card(deck.get_card)
player.give_card(deck.get_card)

dealer.show_card #Player class need method show_card
player.show_cards #Player class need method show_cards

while player.hand_value < 21
  puts "Would you like to hit?"
  if gets.chomp.downcase == "yes"
    player.give_card(deck.get_card)
    player.show_cards
  else
    break
  end
end

while dealer.hand_value < 17 #Player class need method hand_value
  dealer.show_cards
  puts "Dealer draws..."
  dealer.give_card(deck.get_card)
  dealer.show_cards
end

if player.hand_value > 21
  puts "YOU LOSE!"
  exit
end

if dealer.hand_value > 21
  puts "You win, the dealer has gone over!"
  exit
end

if player.hand_value > dealer.hand_value
  puts "#{player.name} wins!"
elsif dealer.hand_value > player.hand_value
  puts "Dealer wins!"
else
  puts "It's a tie!"
end
