class Mastermind
  def initialize()
    puts "Instructions:"
    puts "0. It is a game for two players."
    puts "1. One player, the code breaker, tries to guess the code their opponent, the code maker, comes up with."
    puts "2. Code should consist of 4 colours in which the permutations of 6 colours: Blue, Yellow, Green, Purple, Orange and Red"
    puts "3. Colours are represented as their first letter (e.g. 'B' for blue)"
    puts "4. Code maker should give a feedback for each guess of the code breaker"
    puts "5. Each '-' on the board means that one of the guessed colours is correct, but is in the wrong order."
    puts "6. Each '+' on the board means that one of the guessed colours is correct, and is in the right order."
    puts "7. The order of the '+'s and '-'s  does not matter."
    puts "8. Code breaker have 12 turns to guess the code."
    puts "Let us begin!"

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
# Compute makes a random code
  def initialize()
    puts "Breaker Babe"
    @board = Board.new
  end
end



class CodeMaker
# Computer need to guess
  def initialize()
    puts "Maker Yoo"
    @board = Board.new
  end
end

class Board
  def initialize()
   visualise
  end

  def visualise
    for i in 1..12
      print "_ _ _ _    "
      puts "...."
    end
  end

  def colour_control
  	# Capital first letter
  	# Among colours?
  end
end

game = Mastermind.new

