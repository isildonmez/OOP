puts "Rules:"
puts "1. This is a game for two players, X and O, who take turns stating the coordinates in a 3×3 grid."
puts "2. Each vertical line has 'a..c' letter name as a coordinate"
puts "3. Each horizontal line has '3..1' digit name as a coordinate"
puts "4. Each player should state the coordinate with a letter and a digit, respectively. (e.g. 'a3' or 'C2' and so on.)"
puts "5. Each player should follow the other"

class Tic_tac_toe

  def act
  	# Memory of each player << gets.chomp.to_sym
  end

  def memory_of_each_player
  	#stores each players coordinate as an array of symbols
  end

  def visualise
  	# prints the visualised coordinates after each act.
  end

  def is_a_defeat_or_what
  	# Checks memory_of_each_player if it includes any of the below combinations.
    @@winners_array = [
      %i[a3 a2 a1], %i[b3 b2 b1], %i[c3 c2 c1],
      %i[a3 b3 c3], %i[a2 b2 c2], %i[a1 b1 c1],
      %i[a3 b2 c1], %i[a1 b2 c3]
    ]

  end

end