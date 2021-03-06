require './lib/file_filter.rb'
require 'yaml'

#Game class handles logic and saving game state
class Game
#Secret provides a random word for player (Array.sample => String)
  include Secret
  def initialize(word = secret().downcase,
		turns = '|' * 12,
		letters_used = [],
		letter_count = '_' * word.length,
		save = false)

    @word = word
    @turns = turns
    @letters_used = letters_used
    @letter_count = letter_count
    @save = save
    play_game()
  end

  private

#Game logic
  def play_game()

    while @letter_count.index('_') != nil && @turns.length > 0
    print_info()
    guess = gets.chomp.downcase

    if guess == 'save'
      save()
      print "  Enter a letter: "
      guess = gets.chomp.downcase
    end

    guess == 'save' ? save() : guess

    until @letters_used.index(guess) == nil && guess.length == 1 && guess.match?(/[a-z]/)
      print "  Invalid input. Try again: "
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

#Visuals for the player
  def print_info()
    
    system('clear')
    puts "\n\n\n\n"
    puts "  #{@letter_count}", "\n"
    puts "  letters used: #{@letters_used.join(" ")} \n\n"
    puts "  Turns #{@turns}\n\n"
    print "  Enter a letter or type 'save':  "

  end

#If player wins after loading the save file, the save file gets deleted.
#On loosing, the word is revealed

  def ending()

    if @letter_count.index('_') == nil
      system('clear')
      puts "You Win!\n"
      if @save
	File.delete("./player_saves/#{@save}.yml")
      end
    else
      system('clear')
      puts "You Loose! The answer was #{@word}!\n"
    end

  end

#serializes the current state of the game into a yaml file and resumes the game.
  def save()
  print "  Enter the name of your save: "
  savename = gets.chomp

  until /^[[:alpha:]]+$/.match?(savename)
      print "Enter only letters: "
      savename = gets.chomp
  end
  data = {word: @word,
	turns: @turns,
	letter_count: @letter_count,
	letters_used: @letters_used,
	save: savename}
  File.open("./player_saves/#{savename}.yml", "w") { |file| file.write(data.to_yaml) }

  puts "  Your Game has been saved!\n"
  end

end
