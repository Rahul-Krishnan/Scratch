require 'csv'
require 'pry'
require 'terminal-table'

class Suspects
  attr_reader :suspect_list, :suspect_count

  def initialize
    @suspect_list = CSV.read('Suspects.csv')
    @suspect_count = 0
  end

  def count_suspects
    @suspect_list.each do
      @suspect_count +=1
    end
  end

  def show_suspects
    table = Terminal::Table.new :headings => ["Name","Gender","Skin Color","Hair Color","Eye Color"], :rows => @suspect_list
    puts table
  end

  def remove_guess(name)
    @suspect_list.delete_if do |item|
      if item[0].include?name
        true
      else
        false
      end
    end
  end

  def retain_correct_gender(entry)
    @suspect_list.delete_if do |item|
      if !item[1].include?entry
        true
      else
        false
      end
    end
  end

  def remove_wrong_gender(entry)
    @suspect_list.delete_if do |item|
      if item[1].include?entry
        true
      else
        false
      end
    end
  end

  def retain_correct_skin(entry)
    @suspect_list.delete_if do |item|
      if !item[2].include?entry
        true
      else
        false
      end
    end
  end

  def remove_wrong_skin(entry)
    @suspect_list.delete_if do |item|
      if item[2].include?entry
        true
      else
        false
      end
    end
  end

  def retain_correct_hair(entry)
    @suspect_list.delete_if do |item|
      if !item[3].include?entry
        true
      else
        false
      end
    end
  end

  def remove_wrong_hair(entry)
    @suspect_list.delete_if do |item|
      if item[3].include?entry
        true
      else
        false
      end
    end
  end

  def retain_correct_eye(entry)
    @suspect_list.delete_if do |item|
      if !item[4].include?entry
        true
      else
        false
      end
    end
  end

  def remove_wrong_eye(entry)
    @suspect_list.delete_if do |item|
      if item[4].include?entry
        true
      else
        false
      end
    end
  end

end

class Perp
  attr_reader :choice_number
  attr_accessor :name, :gender, :skin, :hair, :eye

  def initialize total_suspects
    @choice_number = rand(total_suspects-1)
    @name = name
    @gender = gender
    @skin = skin
    @hair = hair
    @eye = eye
  end

end

suspects = Suspects.new
puts "Welcome to the Police Department. We need your help identifiying a dangerous criminal, but you only get 3 chances to guess! Here are the suspects:\n\n"
suspects.show_suspects
suspects.count_suspects

perp = Perp.new(suspects.suspect_count)
perp.name = suspects.suspect_list[perp.choice_number][0]
perp.gender = suspects.suspect_list[perp.choice_number][1]
perp.skin = suspects.suspect_list[perp.choice_number][2]
perp.hair = suspects.suspect_list[perp.choice_number][3]
perp.eye = suspects.suspect_list[perp.choice_number][4]

guess_count = 0
answer = 0
#binding.pry
while guess_count < 3 && answer != perp.name
  puts "\nWhat attribute would you like to guess? (G)ender, (S)kin, (H)air or (E)yes?"
  choice = gets.chomp.upcase
  #Error check
  while choice != "G" && choice != "S" && choice != "H" && choice != "E"
    puts "Invalid entry. (G)ender, (S)kin, (H)air or (E)yes?"
    choice = gets.chomp.capitalize
  end

  case choice
  when "G" then puts "Which gender?"
  when "S" then puts "What skin color?"
  when "H" then puts "What hair color?"
  when "E" then puts "What eye color?"
  end
  entry = gets.chomp.downcase

  #Error check
  count = 0
  while count == 0
    suspects.suspect_list.each do |item|
      count +=1 unless !item.include?entry
    end
    if count == 0
      puts "Invalid entry, please try again:"
      entry = gets.chomp.downcase
    end
  end

  if choice == "G" && entry == perp.gender
    puts "***CORRECT***"
    suspects.retain_correct_gender(entry)
  elsif choice == "G" && entry != perp.gender
    puts "***WRONG***"
    suspects.remove_wrong_gender(entry)
  end

  if choice == "S" && entry == perp.skin
    puts "***CORRECT***"
    suspects.retain_correct_skin(entry)
  elsif choice == "S" && entry != perp.skin
    puts "***WRONG***"
    suspects.remove_wrong_skin(entry)
  end

  if choice == "H" && entry == perp.hair
    puts "***CORRECT***"
    suspects.retain_correct_hair(entry)
  elsif choice == "H" && entry != perp.hair
    puts "***WRONG***"
    suspects.remove_wrong_hair(entry)
  end

  if choice == "E" && entry == perp.eye
    puts "***CORRECT***"
    suspects.retain_correct_eye(entry)
  elsif choice == "E" && entry != perp.eye
    puts "***WRONG***"
    suspects.remove_wrong_eye(entry)
  end

  puts "\nHere are the remaining suspects:"
  suspects.show_suspects
  puts "\nTake a guess at the name!"
  answer = gets.chomp.downcase
  if answer != perp.name
    puts "Nope, that isn't right. Guesses left: #{2-guess_count}"
    guess_count +=1
    suspects.remove_guess(answer)
  else
  end
end

if answer == perp.name
  puts "***CONGRATULATIONS*** You guessed right! #{perp.name.capitalize} is now locked up."
else
  puts "Tough luck. #{perp.name.capitalize} got away. Get outta here!"
end
