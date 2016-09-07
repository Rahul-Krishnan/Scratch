class Animal
  attr_accessor :predator, :age, :species, :name
  attr_reader :dead

  def initialize predator, age, species, name
    @predator = predator
    @age = age
    @species = species
    @name = name
    @dead = false
  end

  def birthday
    @age +=1
    puts "I have aged a year"
  end

  def hunt
    if predator
      puts "You hunt and kill!"
    else
      puts "You are a vegetarian!"
    end
  end

  def swim
    if species == "bulldog"
      dead = true
    else
      puts "Swimming is nice!"
    end
  end

  def bite
    if age < 50
      puts "Ouch"
    else
      puts "That barely leaves a scratch"
    end
  end

  def fight opponent
    if opponent.dead
      puts "You fight a corpse well!"
    else
      if self.predator && opponent.predator
        puts "No winners here."
      elsif !self.predator && opponent.predator
        @dead = true
        puts "You dead, son."
      elsif self.predator && !opponent.predator
        puts "Congratulations on a flawless victory!"
      else
        puts "Pacifists have no war."
      end
    end
  end

end
