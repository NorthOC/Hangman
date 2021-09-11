require 'yaml'
require './hangman.rb'

class StartMenu
	def initialize()
	system('clear')
	puts "Welcome to Hangman - THE GAME!\n\n"
	puts "Get a word, try to guess it."
	puts "If you guess, you win. If your turns end, you loose.\n\n"
	puts "Tip for never loosing?\n"
	puts "Save the game and reload if you run out of turns!"
	puts "Good LUCK!\n\n"

        puts '1. New game'
	puts '2. Load game'	
	print "\nSo, want to start fresh or load a save?(type 1 or 2) "
	answer = gets.chomp.to_i

	until answer.between?(1,2)
	print "Enter 1 to start new game, or enter 2 to load a game "
	answer = gets.chomp.to_i
	end

	if answer == 1
		Game.new
	elsif answer == 2
		load_game
	end
	end
	def load_game()
	  arr = Dir.entries("../player_saves").filter { |item| !item.start_with?('.')}
	  if arr.count == 0
		puts "No files to load. Starting new game..."
		sleep (2)
		Game.new
	  else
	  disparr = arr.each_with_index {|item, index| item.gsub!('.yml', ''); puts "#{index + 1}. #{item}"}
	  print "\nEnter the number of a file: "
	  file_index = gets.chomp.to_i
	  until arr[file_index - 1] != nil
	  puts "Enter a correct number"
	  file_index = gets.chomp.to_i
	  end
	  load_file = YAML.load(File.read("../player_saves/#{arr[file_index - 1]}.yml"))
	  system('clear')
	  Game.new(load_file[:word],
		   load_file[:turns],
		   load_file[:letters_used],
		   load_file[:letter_count],
		   load_file[:save])
	end
	end
end

StartMenu.new
