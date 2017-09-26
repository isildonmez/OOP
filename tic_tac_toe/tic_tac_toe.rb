puts "Rules:"
puts "1. This is a game for two players, X and O, who take turns stating the coordinates in a 3×3 grid."
puts "2. Each vertical line has 'a..c' letter name as a coordinate"
puts "3. Each horizontal line has '1..3' digit name as a coordinate"
puts "4. Each player should state the coordinate with a letter and a digit, respectively. (e.g. 'a3' or 'C2' and so on.)"
puts "5. Each player should follow the other"

class TicTacToe
  # Be careful about the class of coordinate
  def act(player)
    # Stores the steps of each act as a main method.

    # Taking the coordinate of current player
    puts "What is the coordinate of your next move?"
    @coordinate = gets.chomp.downcase.to_sym

    # Checking the validity
    valid_coordinate(@coordinate)

    # Save into memory array
    memory_of_each_player(player)

    # Visualising
    puts visualise(player)

    #Checking if there is a winner
    return a_winner? if a_winner?
  end

  def valid_coordinate(coordinate)
    # Checks if the syntax of the coordinate is valid.
    valid_digits = lambda do |coordinate|
      if coordinate[0].between?("a","c") && coordinate[1].to_i.between?(1,3)
        return true
      else
        puts "Please state a coordinate with a letter and a digit, respectively. (e.g. 'a3' or 'C2' and so on.)"
        return false
      end
    end

    # Checks if the coordinate is not occupied.
    free_space = lambda do |coordinate|
      if (@memory_of_x + @memory_of_o).include? coordinate
        puts "This coordinate is occupied. Please enter another coordinate."
        return false
      else
        return true
      end
    end

    until free_space.call(coordinate) && valid_digits.call(coordinate)
      coordinate = gets.chomp.downcase.to_sym
    end
    @coordinate = coordinate.to_sym
  end

  def memory_of_each_player(player)
    #stores each players coordinate as an array of symbols
    @memory_of_x = []
    @memory_of_o = []
    player = X ? @memory_of_x << @coordinate : @memory_of_o << @coordinate
  end

  def visualise(player)
    # prints the visualised coordinates after each act.
    0th_line = " abc"
    1st_line = "1---"
    2nd_line = "2---"
    3rd_line = "3---"

    which_line = 0th_line
    [1st_line, 2nd_line, 3rd_line].each do |line|
      if line[0].include? @coordinate.to_s[1]
        which_line = line
      end
    end
    index = 0th_line.index(@coordinate.to_s[0])

    player = X ? which_line[index] = "x" : which_line[index] = "o"

    [0th_line, 1st_line, 2nd_line, 3rd_line]
  end

  def a_winner?
    # Checks memory_of_each_player if it includes any of the below combinations.
    @@winners_array = [
      %i[a3 a2 a1], %i[b3 b2 b1], %i[c3 c2 c1],
      %i[a3 b3 c3], %i[a2 b2 c2], %i[a1 b1 c1],
      %i[a3 b2 c1], %i[a1 b2 c3]
    ]
    if (@memory_of_x || @memory_of_o).length > 2
      @@winners_array.each do |arr|
        if @memory_of_x.include? arr
          return "And this very move makes X the WINNER!"
        elsif @memory_of_o.include? arr
          return "And this very move makes O the WINNER!"
        end
    end
  end
end

X = TicTacToe.new
O = TicTacToe.new


for i in 1...10
  act(X) if i.odd?
  act(O) if i.even?
end
# p "Unfortunately, there is no winner in this game :("
