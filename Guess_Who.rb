require 'csv'
require 'terminal-table'

class Suspects
  attr_reader :suspect_list, :suspect_count, :suspect_names

  def initialize
    @suspect_list = CSV.read('Suspects.csv')
    @suspect_names = []
    @suspect_count = 0
    @suspect_list.each do |name, gender, skin, hair, eye|
      name.capitalize!
      gender.capitalize!
      skin.capitalize!
      hair.capitalize!
      eye.capitalize!
    end
    @suspect_list.shuffle!
  end

  def name_suspects
    @suspect_names = []
    @suspect_list.each do |name, gender, skin, hair, eye|
      @suspect_names << name
    end
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
      item[0].include?name
    end
  end

  def retain_correct_gender(entry)
    @suspect_list.delete_if do |item|
      !item[1].include?entry
    end
  end

  def remove_wrong_gender(entry)
    @suspect_list.delete_if do |item|
      item[1].include?entry
    end
  end

  def retain_correct_skin(entry)
    @suspect_list.delete_if do |item|
      !item[2].include?entry
    end
  end

  def remove_wrong_skin(entry)
    @suspect_list.delete_if do |item|
      item[2].include?entry
    end
  end

  def retain_correct_hair(entry)
    @suspect_list.delete_if do |item|
      !item[3].include?entry
    end
  end

  def remove_wrong_hair(entry)
    @suspect_list.delete_if do |item|
      item[3].include?entry
    end
  end

  def retain_correct_eye(entry)
    @suspect_list.delete_if do |item|
      !item[4].include?entry
    end
  end

  def remove_wrong_eye(entry)
    @suspect_list.delete_if do |item|
      item[4].include?entry
    end
  end
end

class Perp
  attr_accessor :name, :gender, :skin, :hair, :eye
  attr_reader :choice_number

  def initialize total_suspects
    @choice_number = rand(total_suspects-1)
    @name = name
    @gender = gender
    @skin = skin
    @hair = hair
    @eye = eye
  end
end

class Guesses
  attr_accessor :guess_list
  attr_reader :guess_count, :available_choices

  def initialize
    @guess_list = []
    @guess_count = 0
    @available_choices = ["G", "H", "S", "E"]
  end

  def count_guesses
    @guess_count = @guess_list.count
  end
end
###################################################
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

guesses = Guesses.new

answer = 0

while guesses.guess_count < 3 && answer != perp.name
  puts "\nWhat attribute would you like to guess? (G)ender, (S)kin, (H)air or (E)yes?"
  choice = gets.chomp.capitalize
  #Error check
  while !guesses.available_choices.include?(choice)
    puts "Invalid entry. (G)ender, (S)kin, (H)air or (E)yes?"
    choice = gets.chomp.capitalize
  end

  guesses.guess_list << choice
  guesses.count_guesses

  case choice
  when "G" then puts "Which gender?"
  when "S" then puts "What skin color?"
  when "H" then puts "What hair color?"
  when "E" then puts "What eye color?"
  end
  entry = gets.chomp.capitalize

  #Error check
  count = 0
  while count == 0
    suspects.suspect_list.each do |item|
      count +=1 unless !item.include?entry
    end
    if count == 0
      puts "Invalid entry, please try again:"
      entry = gets.chomp.capitalize
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

  suspects.name_suspects

  puts "\nHere are the remaining suspects:"
  suspects.show_suspects
  puts "\nTake a guess at the name!"
  answer = gets.chomp.capitalize
  while !suspects.suspect_names.include?(answer)
    puts "Whoops, that isn't a suspect! Take a real guess:"
    answer = gets.chomp.capitalize
  end

  if answer != perp.name
    puts "Nope, that isn't right. Guesses left: #{3-guesses.guess_count}"
    suspects.remove_guess(answer)
  else
  end
end

if answer == perp.name
  puts "\n***CONGRATULATIONS*** You guessed right! #{perp.name.capitalize} is now locked up."
else
  puts "\nYOU SUCK. #{perp.name.capitalize} got away and eventually murdered a family. You are a disgrace to this department and to your country. Get outta here!"
end
