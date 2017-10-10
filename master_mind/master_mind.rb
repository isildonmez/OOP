module MastermindCommonMethods
  COLOURS = %w[B Y G P O R]

  def get_the_code
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
    @user_code
  end

  def positive_feedbacks
    zipped = @code.zip(@guess)
    to_update = []
    zipped.each do |arr|
      if arr[0] == arr[1]
        @each_feedback << "+"
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

    number_of_intersection = (@updated_code & @updated_guess).map do |el|
      [hash_code[el], hash_guess[el]].min
    end.reduce(&:+)
    number_of_intersection.times {@each_feedback << "-"}
  end

  def compose_feedbacks
    @each_feedback = []
    @updated_code = []
    @updated_guess = []
    positive_feedbacks unless (@code & @guess).empty?
    negative_feedbacks unless (@updated_guess & @updated_code).empty?
    @feedbacks << @each_feedback
    @each_feedback
  end
end

class Mastermind
  def initialize()
    rules
    @proposition = "Please write 'breaker' if you want to be the code breaker or 'maker' to be the code maker."
    puts @proposition
    @request = gets.chomp.downcase

    which_player
    which_game
  end

  def rules
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
  end

  def which_player
    until @request == "breaker" || @request == "maker"
      puts @proposition
      @request = gets.chomp.downcase
    end
  end

  def which_game
    if @request == "breaker"
      CodeBreaker.new.act
    else
      CodeMaker.new.act
    end
  end
end

class CodeBreaker
# Computer makes a random code
  include MastermindCommonMethods

  def initialize()
    @board = Board.new
    @code = COLOURS.repeated_permutation(4).to_a.sample
    p @code
    @feedbacks = []
  end

  def act
    number_of_guess = 1
    while (number_of_guess < 13) && (@guess != @code)
      get_the_code
      @guess = check_the_code
      compose_feedbacks
      @board.visualise(@guess, @each_feedback, number_of_guess)
      number_of_guess += 1
    end
    puts "Congratulations!" if @guess == @code
    puts "Game over!" if number_of_guess == 13
  end
end


class CodeMaker
  # Computer need to guess
  include MastermindCommonMethods
  def initialize()
    @board = Board.new
    @updated_colours = COLOURS
    @c_index = 0
    @feedbacks = []
    @each_feedback = []
    @new_colour_index = [2, 3]
    @possible_index = 0
  end

  def act
    get_the_code
    @code = check_the_code
    @number_of_guess = 1
    while (@number_of_guess < 13) && (@code != @guess)
      create_guess
      compose_feedbacks
      @board.visualise(@guess, @each_feedback, @number_of_guess)
      @number_of_guess += 1
    end
    puts "That was a nice game! :)"
  end

  # TODO
  def create_guess
    get_4_the_same = Proc.new {(@updated_colours[@c_index] * 4).split("")}
    case @each_feedback.length
      when 0
        @updated_colours.delete_at(@c_index) unless @number_of_guess == 1
        @guess = get_4_the_same.call
      when 1
        if @each_feedback == ["-"]
          @guess = @guess[2, 2] + @guess[0, 2]
          @new_colour_index = [0, 1]
        end
        @updated_colours.delete_at(@c_index + 1) if @guess.uniq.length != 1
        @guess = @guess.map.with_index do |colour, index|
          if @new_colour_index.include?(index)
            colour = @updated_colours[@c_index + 1]
          else
            colour = @updated_colours[@c_index]
          end
        end
      when 2
        if @each_feedback == %w[- -] && @possible_index == 0
          @guess = @guess[2, 2] + @guess[0, 2]
          @new_colour_index = [0, 1]
        elsif @each_feedback == %w[+ +]
          old_colour_index = [0,1,2,3] - @new_colour_index
          zipped_possible_places = old_colour_index.zip(@new_colour_index)
          zipped_index = zipped_possible_places[0]
          @new_colour_index = zipped_possible_places[1]
          @guess = @guess.map.with_index do |colour, index|
            if @new_colour_index.include?(index)
              colour = @updated_colours[@c_index + 2]
            else
              colour
            end
          end
        else
          possible_places_for_last_colour = [[0,2], [0,3], [1,2], [1,3]]
          @new_colour_index = possible_places_for_last_colour[@possible_index]
          @guess = @guess.map.with_index do |colour, index|
            if @new_colour_index.include?(index)
              colour = @updated_colours[@c_index + 1]
            else
              colour = @updated_colours[@c_index]
            end
          end
          @possible_index += 1
        end
        @guess
      when 3


    end

  end
end


# TODO
class Board

  def initialize()
    @hash_of_guesses = {}
  end

  def new_guess?(new_guess)
    !@hash_of_guesses.keys.include? new_guess
  end

  def store_guesses(guesses, each_feedback)
    @hash_of_guesses[guesses] = each_feedback
    @hash_of_guesses.each do |guesses, each_feedback|
      print "#{guesses.join(" ")}    "
      puts "#{each_feedback.join}"
    end
  end

  # TODO
  def visualise(guesses, each_feedback, line)
    store_guesses(guesses, each_feedback)
    for i in line...12
      print "_ _ _ _    "
      puts "...."
    end
  end

end

game = Mastermind.new

