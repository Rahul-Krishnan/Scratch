#Tic Tac toe game
# Diplay the borad
# Ask user to input a square
#Ask another user to input a square
# check winning if three sq ( 8 possiblity are done)
#diplay winner
#check for tie
# if not continue to input square
# play again
require "pry"
class Board
  attr_reader :board, :check

  def initialize
    @board = []
    @board << [1, 2, 3]
    @board << [4, 5, 6]
    @board << [7, 8, 9]
    @check = []
  end

  def display_board
    system "clear"
    @board.each do |x|
      puts x.join('|')
      puts "_______"
    end
  end

  def check_move(position)
    if @check.include?(position)
      puts "That position is already taken"
      puts @check
      return false

    else
      @check << position
      return true
    end
  end

  def move(position, player)
    if check_move(position) == true
      @board.each do |row|
        row.each do |column|
          if position == column && player == "Player1"
            row[column] = "X"
          elsif position == column && player == "Player2"
            row[column] = "O"
          end
        end
      end
    end
  end

  def winning?
    if @board[0][0] == @board[1][1] and @board[1][1] == @board[2][2]
      puts "Player 1 wins" if @board[0][0] == "X"
      puts "Player 2 wins" if @board[0][0] == "O"
      true
    elsif @board[0][2] == @board[1][1] and @board[1][1] == @board[2][0]
      puts "Player 1 wins" if @board[0][2] == "X"
      puts "Player 2 wins" if @board[0][2] == "O"
      true
    elsif @board[0][0] == @board[0][1] and @board[0][1] == @board[0][2]
      puts "Player 1 wins" if @board[0][0] == "X"
      puts "Player 2 wins" if @board[0][0] == "O"
      true
    elsif @board[0][1] == @board[1][1] and @board[1][1] == @board[2][1]
      puts "Player 1 wins" if @board[0][1] == "X"
      puts "Player 2 wins" if @board[0][1] == "O"
      true
    elsif @board[0][2] == @board[1][2] and @board[1][2] == @board[2][2]
      puts "Player 1 wins" if @board[0][2] == "X"
      puts "Player 2 wins" if @board[0][2] == "O"
      true
    elsif @board[1][0] == @board[1][1] and @board[1][1] == @board[1][2]
      puts "Player 1 wins" if @board[1][0] == "X"
      puts "Player 2 wins" if @board[1][0] == "O"
      true
    elsif @board[2][0] == @board[2][1] and @board[2][1] == @board[2][2]
      puts "Player 1 wins" if @board[2][0] == "X"
      puts "Player 2 wins" if @board[2][0] == "O"
      true
    elsif @board[0][0] == @board[0][1] and @board[0][1] == @board[0][2]
      puts "Player 1 wins" if @board[0][0] = "X"
      puts "Player 2 wins" if @board[0][0] = "O"
      true
    else
      false
    end
  end

  def tie?
    return false
  end
end

board = Board.new
board.display_board

turn = 0

while true
  puts "Which position would you like to mark Player 1?"
  position = gets.chomp.to_i

  board.check_move(position)
  board.move(position, "Player1")
  break if board.winning?

  board.display_board

  puts "Which position would you like to mark Player 2?"
  position = gets.chomp.to_i
  board.check_move(position)
  board.move(position, "Player2")

  binding.pry
  break if board.winning?
  board.display_board

end
