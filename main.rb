require "json"
require_relative "player"
require_relative "computer"
require_relative "counter"

class Hangman
  def initialize
    @player = Player.new
    @computer = Computer.new
    @counter = Counter.new
  end
  def play
    @counter.insert_answer(@computer.get_word)
    @counter.insert_blank
    @counter.print_guessed_answer
    loop do
      guess = @player.get_guess
      if guess == "save"
        save_game()
        puts "Saved game"
        return
      elsif guess == "load"
        print "Input save file: "
        save_file = gets.chomp
        data = load_game(save_file)
        @counter.actual_answer = data[:actual_answer]
        @counter.guessed_answer = data[:guessed_answer]
        @counter.wrong_counter = data[:wrong_counter]
        puts "Loaded game"
      else
        @counter.fill_blank(guess)
      end
      @counter.print_guessed_answer
      @counter.print_wrong_counter
      if @counter.check_correct
        puts "You won! The answer is:"
        @counter.print_actual_answer
        break
      elsif @counter.wrong_counter > 11
        puts "You lost! The answer is:"
        @counter.print_actual_answer
        break
      end
    end
  end
  def save_game
    data = {
      actual_answer: @counter.actual_answer,
      guessed_answer: @counter.guessed_answer,
      wrong_counter: @counter.wrong_counter
      }
    json_string = data.to_json
    File.open("odin_hangman_save.json", "w") do |file|
      file.write(json_string)
    end
  end
  def load_game(user_file)
    File.open(user_file, "r") do |file|
      file_content = file.read
      data = JSON.parse(file_content, symbolize_names: true)
      puts data
      return data
    end
  end
end

hangman = Hangman.new
hangman.play
