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
      end
      @counter.fill_blank(guess)
      @counter.print_guessed_answer
      @counter.print_wrong_counter
      if @counter.check_correct
        puts "You won! The answer is:"
        @counter.print_actual_answer
        break
      elsif @counter.wrong_counter > 12
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
end

hangman = Hangman.new
hangman.play
