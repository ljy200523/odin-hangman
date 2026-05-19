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
