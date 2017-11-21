require_relative 'tic_tac_toe'

describe TicTacToe do

  subject(:game) {TicTacToe.new}
  it { is_expected.to respond_to(:visualise) }


end

