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

class Player
  def initialize
    @exhausted_char = []
  end
  def get_guess
    loop do
      print "Guess a character: "
      response = gets.chomp.downcase
      if response.length == 1 && response.match?(/[a-zA-Z]/) && !@exhausted_char.include?(response)
        @exhausted_char.push(response)
        return response
      else
        puts "Already Guessed: #{@exhausted_char}"
      end
    end
  end
end

class Computer
  def initialize
    @word_list = []
  end
  def get_word
    word_file = File.open("/mnt/c/Users/Family/Downloads/google-10000-english-no-swears.txt", "r") do |file|
      file.each_line do |word|
        word = word.strip
        if word.length > 4 && word.length < 13
          @word_list.push(word)
        end
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
  attr_reader :wrong_counter
  def insert_answer(answer)
    @actual_answer = answer.split("")
  end
  def insert_blank
    @actual_answer.each do
      @guessed_answer.push(" ")
    end
  end
  def fill_blank(character)
    if @actual_answer.include?(character)
      @actual_answer.each_with_index do |element, index|
        if character == element
          @guessed_answer[index] = character
        end
      end
    else
      @wrong_counter += 1
    end
  end
  def check_correct
    @actual_answer == @guessed_answer ? true : false
  end
  def print_actual_answer
    puts @actual_answer.join
  end
  def print_guessed_answer
    p @guessed_answer
  end
  def print_wrong_counter
    puts "Wrong Counter: #{@wrong_counter}"
  end
end


hangman = Hangman.new
hangman.play
