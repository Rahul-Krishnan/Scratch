require 'pry'
class Board
  attr_accessor :board

  def initialize (row, column)
    @board = []
    @rows = row
    @columns = column
  end

  def display_board
    # system 'clear'
    @rows.times do |row|
      row = []
      @columns.times do |column|
        row << '_'
      end
      puts row.join('|')
      @board << row
    end
    # @board.each do |row|
    #   puts row.join('|')
    #   puts "___________________"
    # end
  end

  def updated_board(column, player)
    puts @board.length
    puts @board[0]

    if column == 1
      @board.each do |row|
        row.each_index do |column|
          stack = @board.length - 1 - column
          if @board[stack][(column-1)] != '_'
            puts "The column is full"
          elsif @board[stack][(column-1)] == '_'
            @board[stack][(column-1)] = player
          end
        end
      end


    elsif column == 2
      if @board[6][(column-1)] == '_'
        @board[6][(column-1)] = player
      elsif @board[5][(column-1)].is_a?(Numeric)
        @board[5][(column-1)] = player
      elsif @board[4][(column-1)].is_a?(Numeric)
        @board[4][(column-1)] = player
      elsif @board[3][(column-1)].is_a?(Numeric)
        @board[3][(column-1)] = player
      elsif @board[2][(column-1)].is_a?(Numeric)
        @board[2][(column-1)] = player
      elsif @board[1][(column-1)].is_a?(Numeric)
        @board[1][(column-1)] = player
      elsif @board[0][(column-1)].is_a?(Numeric)
        @board[0][(column-1)] = player
      elsif
        puts "The column is full. Please select another column"
      end

    end
  end


end

board = Board.new(6,7)

board.display_board

while true
  puts "Player 1 please select a column [ 1-6 ]"
  column = gets.chomp.to_i
  board.updated_board(column, 'X')
  board.display_board


  puts "Player 2 please select a column"
  column = gets.chomp.to_i
  board.updated_board(column, 'O')
  board.display_board

end
