deck = Deck.new
dealer = Player.new("Dealer")
puts "What is your name?"
name = gets.chomp
player = Player.new("Player")

dealer.give_card(deck.get_card)
dealer.give_card(deck.get_card)

player.give_card(deck.get_card)
player.give_card(deck.get_card)

dealer.show_card
player.show_cards

while true
  puts "Would you like to hit?"
  if gets.chomp.downcase == "yes""
    player.give_card(deck.get_card)
  else
    break
  end
end
