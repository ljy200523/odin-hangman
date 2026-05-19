class Hangman
  def initialize
    @player = Player.new
    @computer = Computer.new
    @counter = Counter.new
  end
  def play
    @counter.insert_answer(@computer.get_word)
    @counter.print_guessed_answer
    loop do
      guess = @player.get_guess
      counter.fill_blank(guess)
      @counter.print_guessed_answer
      if check_correct
        puts "You won! The answer is:"
        @counter.print_correct_answer
        break
      end
    end
  end
end

class Player
  def initialize
    @exhausted_char = []
  end
  def get_guess
    loop do
      print "Guess a character: "
      response = gets.chomp.downcase
      if response.length == 1 && response.match?(/[a-zA-Z]/) && !@exhuasted_char.includes(response)
        @exhuasted_char.push(response)
        return response
      end
    end
  end
end

class Computer
  def initialize
    @word_list = []
  end
  def get_word
    word_file = File.open("google-10000-english-no-swears.txt", "r") do |word|
      if word.length > 4 && word.length < 13
        @word_list.push(word)
      end
    end
    return @word_list.uniq.shuffle.sample
  end
end

class Counter
  def initialize
    @actual_answer = []
    @guessed_answer = []
    @wrong_counter = 0
  end
  attr_accessor :name
  def insert_answer(answer)
    @actual_answer = answer.split("")
  end
  def fill_blank(character)
    @actual_answer.each_with_index do |element, index|
      if character == element && !@guessed_answer.includes(character)
        @guessed_answer[index] = character
      else
        @wrong_answer += 1
      end
    end
  end
  def check_correct
    @actual_answer == @guessed_answer ? true : false
  end
  def print_actual_answer
    puts @actual_answer
  end
  def print_guessed_answer
    puts @guessed_answer
  end
  def print_wrong_counter
    puts @wrong_counter
  end
end


