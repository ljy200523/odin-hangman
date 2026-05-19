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
end



hangman = Hangman.new
hangman.play
