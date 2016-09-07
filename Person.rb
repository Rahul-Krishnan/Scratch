class Person
  attr_accessor :name, :age, :political_affiliation

  def initialize name, age, political_affiliation
    @name = name
    @age = age
    @political_affiliation = political_affiliation
    @say_hello
  end

  def say_hello
    puts "Hi, my name is #{:name}, I am #{:age}, and I am a #{:political_affiliation}"
  end

  def say_hello
    puts "Oh no I died"
  end

  def age
    @age +=1
    puts "I have aged a year"
  end
end
