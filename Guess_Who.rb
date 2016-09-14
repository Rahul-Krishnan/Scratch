require 'csv'
require 'pry'

class Suspects
  attr_reader :suspect_list, :suspect_count

  def initialize
    @suspect_list = CSV.read('Suspects.csv')
    @suspect_count = 0
  end

  def count_suspects
    @suspect_list.each do |item|
      @suspect_count +=1
    end
  end

  def show_suspects
    @suspect_list.each do |name, gender, skin, hair, eye|
      puts "#{name.capitalize}: #{gender.capitalize}, #{skin} skin, #{hair} hair, #{eye} eyes"
    end
  end

  def remove_suspect
  end

end

class Perp
  attr_reader :name, :gender, :skin, :hair, :eye

  def initialize
    @random = rand(0..10)
    @name = name
    @gender = gender
    @skin = skin
    @hair = hair
    @eye = eye
  end

end

suspects = Suspects.new
perp = Perp.new
puts "Hi there. Here are the suspects:\n\n"
#binding.pry
suspects.show_suspects
suspects.count_suspects
# print the rows from the csv
guess_count = 0
while guess_count < 4
  puts "\nWhat attribute would you like to guess? (G)ender, (S)kin, (H)air or (E)yes?"
  choice = gets.chomp.upcase
  #Error check
  while choice != "G" && choice != "S" && choice != "H" && choice != "E"
    puts "Invalid entry. (G)ender, (S)kin, (H)air or (E)yes?"
    choice = gets.chomp
  end

  case choice
  when "G" then puts "Which gender?"
  when "S" then puts "What skin color?"
  when "H" then puts "What hair color?"
  when "E" then puts "What eye color?"
  end

  entry = gets.chomp

end
