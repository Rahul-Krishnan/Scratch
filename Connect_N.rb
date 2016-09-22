require './n_board.rb'

puts "*"*25
puts "Welcome to Connect-N"
puts "*"*25
puts "\nPress Q to Quit or any other key to continue:"
input = gets.chomp.downcase
while input != "q"
  puts "How many rows on the board?"
  r = gets.chomp.to_i
  puts "How many columns on the board?"
  c = gets.chomp.to_i
  puts "How many pieces in a row to win?"
  w = gets.chomp.to_i
  board = Board.new(r, c, w)
  board.create_board
  board.print_board

  while board.win_state == false

    puts "\nPlayer 1, please select a column (1-#{c}):"
    column = gets.chomp.to_i
    while board.check_valid_selection(column) == false
      puts "Can't do that. Please select a valid column:"
      column = gets.chomp.to_i
    end
    puts
    board.drop_piece(column, "X")
    board.print_board
    if board.check_win_all(column, "X")
      puts "\nPlayer 1 WINS!"
    elsif board.check_full
      puts "\nSTALEMATE!"
    else
      puts "\nPlayer 2, please select a column (1-#{c}):"
      column = gets.chomp.to_i
      while board.check_valid_selection(column) == false
        puts "Can't do that. Please select a valid column:"
        column = gets.chomp.to_i
      end
      puts
      board.check_valid_selection(column)
      board.drop_piece(column, "O")
      board.print_board
      if board.check_win_all(column, "O")
        puts "\nPlayer 2 WINS!"
      elsif board.check_full
        puts "\nSTALEMATE!"
      else
      end
    end
  end
  puts "\n\nThank you for playing! Press Q to Quit or any other key to continue..."
  input = gets.chomp.downcase
end
