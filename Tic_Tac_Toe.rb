require 'pry'

class Player
  attr_accessor :choices

  def initialize
    @choices = []
  end

  def check_win(input)
    if input == []
      false
    elsif
    input.include?(3) && input.include?(5) && input.include?(7) ||
    input.include?(1) && input.include?(2) && input.include?(3) ||
    input.include?(4) && input.include?(5) && input.include?(6) ||
    input.include?(7) && input.include?(8) && input.include?(9) ||
    input.include?(1) && input.include?(4) && input.include?(7) ||
    input.include?(2) && input.include?(5) && input.include?(8) ||
    input.include?(3) && input.include?(6) && input.include?(9) ||
    input.include?(1) && input.include?(5) && input.include?(9)
      true
    else
      false
    end
  end
end

class Gameboard
  attr_accessor :board, :turns

  def initialize
    @board = [1,2,3,4,5,6,7,8,9]
    @turns = 0
  end

  def display
    print "#{@board[0]} | "
    print "#{@board[1]} | "
    puts @board[2]
    print "#{@board[3]} | "
    print "#{@board[4]} | "
    puts @board[5]
    print "#{@board[6]} | "
    print "#{@board[7]} | "
    puts @board[8]
  end

  def check_repeat(input)
    if @board.include?(input)
      false
    else
      true
    end
  end

  def check_turns
    @turns = 0
    @board.each do |square|
      if square.class == String
        @turns +=1
      else
      end
    end
    if @turns == 9
      puts "STALEMATE!"
      exit
    else
    end
  end
end

game = Gameboard.new
player1 = Player.new
player2 = Player.new

while player1.check_win(player1.choices) == false && player2.check_win(player2.choices) == false
  puts "Here are the available squares:"
  game.display
  input1 = 0
  puts "Player 1, please select a square:"
  input1 = gets.chomp.to_i
  while game.check_repeat(input1) == true
    puts "Invalid entry. Please select a square:"
    input1 = gets.chomp.to_i
  end

  player1.choices << input1
  game.board[input1-1] = "X"
  game.check_turns
#binding.pry
  if player1.check_win(player1.choices) == true
    game.display
    puts "Player 1 WINS!"
  else
    puts "Here are the available squares:"
    game.display
    input2 = 0
    puts "Player 2, please select a square:"
    input2 = gets.chomp.to_i
    while game.check_repeat(input2) == true
      puts "Invalid entry. Please select a square:"
      input2 = gets.chomp.to_i
    end
    player2.choices << input2
    game.board[input2-1] = "O"
    game.check_turns
    if player2.check_win(player2.choices) == true
      game.display
      puts "Player 2 WINS!"
    else
    end
  end
end
