class Hangman
  def initialize
    @player = Player.new
    @Computer = Computer.new
  end
  def play
  end
end

class Player
  def get_guess
    print "Guess: "
    response = gets.chomp.downcase
    return response
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
  def insert_answer(answer)
    @actual_answer = answer.split("")
  end
  def fill_blank(character)
    @filled_answer.each_with_index do |element, index|
      if character == element && !character.includes(@guessed_answer)
        @guessed_answer[index] = character
      else
        @wrong_answer += 1
      end
    end
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


