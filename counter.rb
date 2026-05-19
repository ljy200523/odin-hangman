class Counter
  def initialize
    @actual_answer = []
    @guessed_answer = []
    @wrong_counter = 0
    @word_list = []
  end
  attr_accessor :actual_answer, :guessed_answer, :wrong_counter
  def get_answer
    word_file = File.open("/mnt/c/Users/Family/Downloads/google-10000-english-no-swears.txt", "r") do |file|
      file.each_line do |word|
        word = word.strip
        if word.length > 4 && word.length < 13
          @word_list.push(word)
        end
      end
    end
    @actual_answer = @word_list.uniq.shuffle.sample.split("")
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
    puts "Wrong Counter: #{@wrong_counter} (Game ends at 12th wrong answer)"
  end
end
