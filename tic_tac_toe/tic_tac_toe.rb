puts "Rules:"
puts "1. This is a game for two players, X and O, who take turns stating the coordinates in a 3×3 grid."
puts "2. Each vertical line has 'a..c' letter name as a coordinate"
puts "3. Each horizontal line has '1..3' digit name as a coordinate"
puts "4. Each player should state the coordinate with a letter and a digit, respectively. (e.g. 'a3' or 'C2' and so on.)"
puts "5. Each player should follow the other"

class TicTacToe
  # Be careful about the class of coordinate

  include Enumerable

  def act(player)
    # Stores the steps of each act as a main method.

    # Taking the coordinate of current player
    puts "What is the coordinate of your next move?"
    @coordinate = gets.chomp.downcase

    # Checking the validity
    valid_coordinate(@coordinate)

    # Save into memory array
    @player = player
    memory_of_each_player(@player)

    # Visualising
    visualise(@player)

    #Checking if there is a winner
    a_winner(@player)
  end

  def valid_coordinate(coordinate)
    # Checks if the coordinate is valid.
    # ckecks if the coordinate is not occupied.
    # I am not sure about this until!
    until coordinate[0].between?("a","c") && coordinate[1].to_i.between?(1,3)
      puts "Please state a coordinate with a letter and a digit, respectively. (e.g. 'a3' or 'C2' and so on.)"
      coordinate = gets.chomp.downcase
    end
    @coordinate = coordinate.to_sym
  end

  def memory_of_each_player(player)
    #stores each players coordinate as an array of symbols
    @memory_of_x = []
    @memory_of_y = []
    player = X ? @memory_of_x << @coordinate : @memory_of_y << @coordinate
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

    player = X ? which_line[index] = x : which_line[index] = y

    puts 0th_line, 1st_line, 2nd_line, 3rd_line
  end

  def a_winner?(player)
    # Checks memory_of_each_player if it includes any of the below combinations.
    @@winners_array = [
      %i[a3 a2 a1], %i[b3 b2 b1], %i[c3 c2 c1],
      %i[a3 b3 c3], %i[a2 b2 c2], %i[a1 b1 c1],
      %i[a3 b2 c1], %i[a1 b2 c3]
    ]

  end

end

X = TicTacToe.new
O = TicTacToe.new


for i in 0...10
  act(X) if i.odd?
  act(Y) if i.even?
end