module Common_Methods

end


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
    if @request == "breaker"
      @code_breaker = CodeBreaker.new
    else
      @code_maker = CodeMaker.new
    end
  end
end



class CodeBreaker
# Computer makes a random code
  def initialize()
    @board = Board.new
    @code = Board.get_colours.sample(4)
    p @code
    act
  end

  def act
    number_of_guess = 1
    while (number_of_guess < 13) || (@guessed_colours == @code)
      get_the_guess
      check_the_guess
      compose_a_feedback
      #visualise the board
      number_of_guess += 1
    end
    # The followings should be in a loop.
    # get_the_guess
    # check_the_guess
  end

  def get_the_guess
   puts "Please write your 4 letters code as a permutation of colours."
   puts "As an example, for Blue, Green, Purple and Blue, the entry should be without space and as follows 'BGPB'."
   @guessed_colours = gets.chomp.upcase.split("")
  end

  def check_the_guess
    until (@guessed_colours.uniq - Board.get_colours).empty? && @guessed_colours.size == 4
      puts "Please read the instuctions and enter a valid code"
      @guessed_colours = gets.chomp.upcase.split("")
    end
  end

  def compose_a_feedback
    puts "Hello from compose_a_feedback"
  end


end



class CodeMaker
# LATER
# Computer need to guess
  def initialize()
    @board = Board.new
  end
end



class Board
  @@colours = %w[B Y G P O R]

  def initialize()
    visualise
  end

  def self.get_colours
    @@colours
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

