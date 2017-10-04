module MastermindCommonMethods
  COLOURS = %w[B Y G P O R]

  def get_the_code
    puts "Please write your 4 letters code as a permutation of colours."
    puts "As an example, for Blue, Green, Purple and Blue, the entry should be without space and as follows 'BGPB'."
    @guess = gets.chomp.upcase.split("")
  end

  def check_the_code
    until (@guess.uniq - COLOURS).empty? &&
          @guess.size == 4 &&
          @board.new_guess?(@guess)
      puts "Please read the instuctions and enter a new and valid code"
      @guess = gets.chomp.upcase.split("")
    end
  end

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
      @auto_code_breaker = CodeBreaker.new
    else
      @code_maker = CodeMaker.new
    end
  end
end

class CodeBreaker
# Computer makes a random code
  include MastermindCommonMethods

  def initialize()
    @board = Board.new
    @code = COLOURS.repeated_permutation(4).to_a.sample
    act
  end

  def act
    number_of_guess = 1
    while (number_of_guess < 13) && (@guess != @code)
      get_the_code
      check_the_code
      compose_feedbacks
      @board.visualise(@guess, @feedbacks, number_of_guess)
      number_of_guess += 1
    end
    puts "Congratulations!" if @guess == @code
    puts "Game over!" if number_of_guess == 13
  end

  def positive_feedbacks
    zipped = @code.zip(@guess)
    to_update = []
    zipped.each do |arr|
      if arr[0] == arr[1]
        @feedbacks << "+"
        to_update << arr
      end
    end
    updated_zipped = zipped - to_update
    updated_zipped.each do |arr|
      @updated_code << arr[0]
      @updated_guess << arr[1]
    end
  end

  def negative_feedbacks
    hash_proc = Proc.new do |array|
      hash = {}
      array.each do |el|
        if hash.include? el
          hash[el] += 1
        else
          hash[el] = 1
        end
      end
      hash
    end

    hash_code = hash_proc.call(@updated_code)
    hash_guess = hash_proc.call(@updated_guess)

    number_of_intersection = (@updated_code & @updated_guess).flat_map {|el| [hash_code[el], hash_guess[el]].min}.reduce(&:+)
    number_of_intersection.times {@feedbacks << "-"}

  end

  def compose_feedbacks
    @feedbacks = []
    @updated_code = []
    @updated_guess = []
    positive_feedbacks unless (@code & @guess).empty?
    negative_feedbacks unless (@updated_guess & @updated_code).empty?
    @feedbacks
  end

end


class CodeMaker
  # Computer need to guess
  include MastermindCommonMethods
  # TODO: Consider the methods in initialize again.
  def initialize()
    @board = Board.new
    get_the_code
    check_the_code
    @hash_of_guesses = {}
    act
  end

  def act
    number_of_guess = 1
    while (number_of_guess < 13) && (@code != @guess)
      create_guess
      compose_feedbacks
      @board.visualise(@guess, @feedbacks, number_of_guess)
      number_of_guess += 1
    end
    puts "That was a nice game! :)"
  end

  def create_guess
    # TODO
  end

  def compose_feedbacks
    # TODO
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

  def visualise(guesses, feedbacks, line)
    store_guesses(guesses, feedbacks)
    for i in line...12
      print "_ _ _ _    "
      puts "...."
    end
  end

end

game = Mastermind.new

