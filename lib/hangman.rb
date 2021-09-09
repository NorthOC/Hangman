class Game

  def initialize()
    @word = "hello".downcase
    @turns = '|' * 12
    @letters_used = []
    @letter_count = '_' * @word.length
    play_game()
  end

  private

  def play_game()
    while @letter_count.index('_') != nil && @turns.length > 0
    print_info()
    guess = gets.chomp.downcase
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


end

Game.new
