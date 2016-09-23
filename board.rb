class Board
  attr_accessor :layout, :win_state, :rownum

  def initialize
    @layout = []
    @win_state = false
    @rownum = rownum
  end

  def create_board
    6.times do
      row = []
      7.times do
        row << "_"
      end
      @layout << row
    end
  end

  def print_board
    (1..7).each do |n|
      print " #{n}"
    end
    puts
    7.times do
      print " V"
    end
    puts
    @layout.each do |row|
      row.each do |element|
        print "|#{element}"
      end
      puts "|"
    end
  end

  def check_valid_selection column
    (1..7).include?(column) && @layout[0][column-1] == "_"
  end

  def drop_piece column, symbol
    (0..5).to_a.reverse.each do |row|
      if @layout[row][column-1] == "_"
        @layout[row][column-1] = symbol
        @rownum = row
        break
      else
      end
    end
  end

  def check_full
    count = 0
    (0..6).each do |n|
      if @layout[0][n] == "_"
        count +=1
      else
      end
    end
    if count == 0
      true
      @win_state = true
    else
      false
    end
  end

  def check_win_all column, symbol
    check_win_horizontal(column, symbol) ||
    check_win_vertical(column, symbol) ||
    check_win_diag_up_right(column, symbol) ||
    check_win_diag_up_left(column, symbol)
  end

  def check_win_horizontal column, symbol
    length = 1
    (column..6).each do |n|
      if @layout[@rownum][n] == symbol
        length +=1
      else
        break
      end
    end
    (0..(column-2)).to_a.reverse.each do |n|
      if @layout[@rownum][n] == symbol
        length +=1
      else
        break
      end
    end
    if length >= 4
      true
      @win_state = true
    else
      false
    end
  end

  def check_win_vertical column, symbol
    length = 0
    (@rownum..5).each do |n|
      if @layout[n][column-1] == symbol
        length +=1
      else
        break
      end
    end
    if length >= 4
      true
      @win_state = true
    else
      false
    end
  end

  def check_win_diag_up_right column, symbol
    length = 1
    max_dist_up = [7-column, @rownum].min
    if max_dist_up == 0
    else
      (1..max_dist_up).each do |n|
        if @layout[@rownum-n][column-1+n] == symbol
          length +=1
        else
          break
        end
      end
    end
    max_dist_down = [column-1, 5-@rownum].min
    if max_dist_down == 0
    else
      (1..max_dist_down).each do |n|
        if @layout[@rownum+n][column-1-n] == symbol
          length +=1
        else
          break
        end
      end
    end
    if length >= 4
      true
      @win_state = true
    else
      false
    end
  end

  def check_win_diag_up_left column, symbol
    length = 1
    max_dist_up = [column-1, @rownum].min
    if max_dist_up == 0
    else
      (1..max_dist_up).to_a.each do |n|
        if @layout[@rownum-n][column-1-n] == symbol
          length +=1
        else
          break
        end
      end
    end
    max_dist_down = [7-column, 5-@rownum].min
    if max_dist_down == 0
    else
      (1..max_dist_down).each do |n|
        if @layout[@rownum+n][column-1+n] == symbol
          length +=1
        else
          break
        end
      end
    end
    if length >= 4
      true
      @win_state = true
    else
      false
    end
  end

end
