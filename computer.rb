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
