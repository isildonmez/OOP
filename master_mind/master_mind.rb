module MastermindCommonMethods
  COLOURS = %w[B Y G P O R]

  def get_the_code_from_user
    puts "Please write your 4 letters code as a permutation of colours."
    puts "As an example, for Blue, Green, Purple and Blue, the entry should be without space and as follows 'BGPB'."
    @user_code = gets.chomp.upcase.split("")
  end

  def check_the_code
    until (@user_code.uniq - COLOURS).empty? &&
          @user_code.size == 4 &&
          @board.new_guess?(@user_code)
      puts "Please read the instuctions and enter a new and valid code"
      @user_code = gets.chomp.upcase.split("")
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
    @auto_code = []
    for i in 1..4
      @auto_code << COLOURS.sample
    end
    p @auto_code
    act
  end

  def act
    number_of_guess = 1
    while (number_of_guess < 13) && (@user_code != @auto_code)
      get_the_code_from_user
      check_the_code
      compose_feedbacks
      @board.visualise(@user_code, @feedbacks, number_of_guess)
      number_of_guess += 1
    end
    puts "Congratulations!" if @user_code == @auto_code
    puts "Game over!" if number_of_guess == 13
  end

  def positive_feedbacks
    zipped_code = @auto_code.zip(@user_code)
    to_update = []
    zipped_code.each do |arr|
      if arr[0] == arr[1]
        @feedbacks << "+"
        to_update << arr
      end
    end
    updated_zipped_code = zipped_code - to_update
    updated_zipped_code.each do |arr|
      @updated_auto_code << arr[0]
      @updated_user_code << arr[1]
    end
  end

  def negative_feedbacks
    # TODO
    unless (@updated_auto_code & @updated_user_code).empty?
      @feedbacks << "-"
    end
  end

  def compose_feedbacks
    @feedbacks = []
    @updated_auto_code = []
    @updated_user_code = []
    unless (@auto_code & @user_code).empty?
      positive_feedbacks
      negative_feedbacks
    end
    @feedbacks
  end

end


class CodeMaker
  # Computer need to guess
  include MastermindCommonMethods

  def initialize()
    @board = Board.new
    get_the_code_from_user
    check_the_code
    @hash_of_guesses = {}
    act
  end

  def act
    number_of_guess = 1
    while (number_of_guess < 13) && (@user_code != @auto_code)
      create_auto_code
      compose_feedbacks
      @board.visualise(@auto_code, @feedbacks, number_of_guess)
      number_of_guess += 1
    end
    puts "That was a nice game! :)"
  end

  def create_auto_code
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

