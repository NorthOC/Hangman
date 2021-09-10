require './file_filter.rb'
require 'yaml'

class Game
  include Secret
  def initialize(word = secret().downcase,
		turns = '|' * 12,
		letters_used = [],
		letter_count = '_' * word.length)

    @word = word
    @turns = turns
    @letters_used = letters_used
    @letter_count = letter_count
    play_game()
  end

  private

  def play_game()

    while @letter_count.index('_') != nil && @turns.length > 0
    print_info()
    guess = gets.chomp.downcase

    if guess == 'save'
      save()
      print "Enter a guess: "
      guess = gets.chomp.downcase
    end

    guess == 'save' ? save() : guess

    until @letters_used.index(guess) == nil && guess.length == 1 && guess.match?(/[a-z]/)
      print "Invalid input. Try again: "
      guess = gets.chomp.downcase
    end

    @letters_used.push(guess)

    if @word.index(guess) != nil
      @word.split('').each_with_index do |char, index|
        if char == guess
	  @letter_count[index] = guess
	end
      end
    else
      @turns = @turns.chop
    end
   end
   ending()
  end

  def print_info()
    
    system('clear')
    puts @letter_count
    puts "letters used: #{@letters_used.join(" ")} "
    puts "Turns #{@turns}"
    print "Enter a guess: "

  end

  def ending()

    if @letter_count.index('_') == nil
      puts "You Win!"
    else
      puts "You Loose! The answer was #{@word}!"
    end

  end

  def save()
  print "Enter the name of your save: "
  savename = gets.chomp

  until /^[[:alpha:]]+$/.match?(savename)
      print "Enter only letters: "
      savename = gets.chomp
  end

  data = {word: @word,
	turns: @turns,
	guessed: @guessed,
	letters_used: @letters_used}
  File.open("../player_saves/#{savename}.yml", "w") { |file| file.write(data.to_yaml) }

  puts "Your Game has been saved!\n"
  end

end

Game.new
