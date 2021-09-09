class Game

  def initialize()
    @word = "hello".downcase
    @turns = '|' * 12
    @letters_used = []
    play_game()
  end

  def play_game()
    letter_count = '_' * @word.length
    while letter_count.index('_') != nil && @turns.length > 0
    system('clear')
    puts letter_count
    puts "letters used: #{@letters_used} "
    puts "Turns #{@turns}"
    print "Enter a guess: "
    guess = gets.chomp.downcase
    until @letters_used.index(guess) == nil && guess.length == 1 && guess.match?(/[a-z]/)
      print "Invalid input. Try again: "
      guess = gets.chomp.downcase
    end
    @letters_used.push(guess)
    if @word.index(guess) != nil
      @word.split('').each_with_index do |char, index|
        if char == guess
	  letter_count[index] = guess
	end
      end
    else
      @turns = @turns.chop
    end
   end
  end


end

Game.new
