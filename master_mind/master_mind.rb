module CommonMethods
  COLOURS = %w[B Y G P O R]
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
  include CommonMethods

  def initialize()
    @board = Board.new
    @code = COLOURS.sample(4)
    p @code
    act
  end

  def act
    number_of_guess = 1
    while (number_of_guess < 13) && (@guessed_colours != @code)
      get_the_guess
      check_the_guess
      compose_feedbacks
      @board.visualise(@guessed_colours, @feedbacks, number_of_guess)
      number_of_guess += 1
    end
    puts "Congratulations!" if @guessed_colours == @code
    puts "Game over!" if number_of_guess == 13
  end

  def get_the_guess
   puts "Please write your 4 letters code as a permutation of colours."
   puts "As an example, for Blue, Green, Purple and Blue, the entry should be without space and as follows 'BGPB'."
   @guessed_colours = gets.chomp.upcase.split("")
  end

  def check_the_guess
    until (@guessed_colours.uniq - COLOURS).empty? &&
          @guessed_colours.size == 4 &&
          @board.new_guess?(@guessed_colours)
      puts "Please read the instuctions and enter a new and valid code"
      @guessed_colours = gets.chomp.upcase.split("")
    end
  end

  def compose_feedbacks
    # TODO
    @feedbacks = []
    array_of_common_elements = @code & @guessed_colours
    updated_guess_array = @guessed_colours
    unless array_of_common_elements.empty?
      @code.zip(@guessed_colours).each do |code, guess|
        if code == guess
          @feedbacks.push("+")
          updated_guess_array = (@guessed_colours - [code])
        end
      end
      (updated_guess_array & @code).size.times {@feedbacks.push("-")}
    end
    @feedbacks
  end

end



class CodeMaker
  include CommonMethods
# LATER
# Computer need to guess
  def initialize()
    @board = Board.new

  end
end



class Board

  def initialize()
    @hash_of_guesses = {}
  end

  def new_guess?(new_guess)
    !@hash_of_guesses.keys.include? new_guess
  end

  def store_guesses(guesses, feedbacks)
    @hash_of_guesses[guesses] = feedbacks
    @hash_of_guesses.each do |guesses, feedbacks|
      print "#{guesses.join(" ")}    "
      puts "#{feedbacks.join}"
    end
  end

  # BE SURE!
  def visualise(guesses, feedbacks, line)
    store_guesses(guesses, feedbacks)
    for i in line...12
      print "_ _ _ _    "
      puts "...."
    end
  end

end

game = Mastermind.new

