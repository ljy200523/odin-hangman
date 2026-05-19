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
      elsif response.chomp.downcase == "save" || response.chomp.downcase == "load"
        return response
      else
        puts "Already Guessed: #{@exhausted_char}"
      end
    end
  end
end
