class TicTacToe

  def initialize()
  	puts "Rules:"
    puts "This is a game for two players, X and O, who take turns stating the coordinates in a 3×3 grid."
    puts "To state a coordinate, players should enter a number between 1..9 and not occupied number which can be seen as '.' "

    @board = {}
    (1..9).each do |num|
      @board[num] = "."
    end
    visualise
  end

  def start
    turn = 1
    while turn < 10
      player = turn.odd? ? :x : :o
      valid_coordinate(player.to_s)
      visualise
      if a_winner?(player)
        p "#{player.to_s}, the winner!"
        return
      end
      turn += 1
    end
    p "Unfortunately there is no winner :("
    return
  end

  def valid_coordinate(player)
    the_question = "Please enter a number to play as #{player}:"
    puts the_question
    coordinate = gets.chomp.to_i
    until @board[coordinate] == "."
      puts the_question
      coordinate = gets.chomp.to_i
    end
    @board[coordinate] = player
  end

  def visualise
  	@board.each do |k,v|
  	  print "#{v} "
      puts "" if k % 3 == 0
  	end
  end

  def a_winner?(index_sym)
    winners_array = [
     [1,2,3],[4,5,6],[7,8,9],
     [1,4,7],[2,5,8],[3,6,9],
     [1,5,9], [3,5,7]
    ]

    memory_array = @board.select{|k, v| v == index_sym.to_s}.keys
    winners_array.each do |arr|
      return (arr - memory_array).empty?
    end
  end
end

game = TicTacToe.new

game.start




