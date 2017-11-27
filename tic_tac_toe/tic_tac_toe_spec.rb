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

  describe "#visualise" do
    it 'returns string representation of board' do
      game.board[1] = "x"
      str = " x . .\n . . .\n . . .\n"
      expect(game.visualise).to eq(str)
    end
  end

  describe '#a_winner?' do
    context "checking if there is an intersection of players and winning movements arrays." do
      it 'returns false' do
        game.board[1] = "x"
        game.board[2] = "x"
        expect(game.a_winner?("x")).to eq(false)
        game.board[3] = "x"
        expect(game.a_winner?("o")).to eq(false)
      end
      it 'returns true' do
        game.board[1] = "x"
        game.board[2] = "x"
        game.board[3] = "x"
        expect(game.a_winner?("x")).to eq(true)
      end
    end
  end

  # TODO: Fix/ define to_i method for :coord
  describe `#valid_coordinate` do
    before do
      fake_obj = double
      expect(game).to receive(:gets).and_return(fake_obj)
      expect(fake_obj).to receive(:chomp).and_return(:coord)
    end

    it "sets the coordinate to do board as a player" do
      game.valid_coordinate("x")
      expect(game.board(:coord)).to eq("x")
    end
  end

end

