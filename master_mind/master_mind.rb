class Mastermind
  def initialize()
    puts "Welcome to Mastermind. Who do you want to be?"
    @proposition = "Please write 'breaker' if you want to be the code breaker or 'maker' to be the code maker."
    puts @proposition
    @request = gets.chomp.downcase
    puts @request

    which_player
    which_game
  end

  def which_player
    until @request == "breaker" || @request == "maker"
      puts @proposition
      @request = gets.chomp.downcase
    end
  end

  def which_game
    @request == "breaker" ? @code_breaker = CodeBreaker.new : @code_maker = CodeMaker.new

    # case @request
    #   when "breaker"
    #   	@code_breaker = CodeBreaker.new
    #   else
    #   	@code_maker = CodeMaker.new
    # end

    # if @request == "breaker"
    #   @code_breaker = CodeBreaker.new
    # else
    #   @code_maker = CodeMaker.new
    # end
  end
end

class CodeBreaker
  def initialize()
    puts "Breaker Babe"
  end
end

class CodeMaker
  def initialize()
    puts "Maker Yoo"
  end
end

game = Mastermind.new

