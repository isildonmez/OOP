class Mastermind
  def initialize()
    which_game
  end

  def which_player
    puts "Welcome to Mastermind. Who do you want to be?"
    proposition = "Please write 'breaker' if you want to be the code breaker or 'maker' to be the code maker."
    puts proposition
    request = gets.chomp.downcase
    until request = "breaker " || "maker"
      puts proposition
      request = gets.chomp.downcase
    end
    return request
  end

  def which_game
    if which_player == "breaker"
      @code_breaker = CodeBreaker.new
    else
      @code_maker = CodeMaker.new
    end
  end
end

class CodeBreaker

end

class CodeMaker
end

game = Mastermind.new

