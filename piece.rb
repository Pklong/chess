class MoveError < StandardError
end

class Piece
  attr_reader :color
  attr_accessor :pos
  DELTA = [1, -1]

  def initialize(pos, board, color)
    @pos = pos
    @board = board
    @color = color
  end

  def moves
    raise MoveError.new("Shouldn't have happened!")
  end

  private

  def is_enemy?(pos)
    @board[pos] && @board[pos].color != @color
  end

  def is_friend?(pos)
    @board[pos] && @board[pos].color == @color
  end

end
