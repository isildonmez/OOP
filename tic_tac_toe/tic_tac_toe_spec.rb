require_relative 'tic_tac_toe'

describe TicTacToe do

  subject(:game) {TicTacToe.new}
  let(:empty_board) { {1 => '.', 2 => '.', 3 => '.',
                      4 => '.', 5 => '.', 6 => '.',
                      7 => '.', 8 => '.', 9 => '.',} }

  describe "#initialize" do
    it "sets board" do
      expect(game.board).to eq(empty_board)
    end
  end

  describe "#a_winner?" do
    context "checking if there is an intersection of players and winning movements arrays." do
      it "returns true" do
        game.board[1], game.board[2], game.board[3] = :x, :x, :x
        expect(game.a_winner?(:x)).to eql(true)
        game.board[1], game.board[5], game.board[9] = :o, :o, :o
        expect(game.a_winner?(:o)).to eql(true)
      end

      it "returns false" do
        game.board[3], game.board[4], game.board[5] = :x, :x, :x
        expect(game.a_winner?(:x)).to eql(false)
        game.board[1], game.board[3], game.board[5] = :o, :o, :o
        expect(game.a_winner?(:o)).to eql(false)
      end
    end
  end


end

