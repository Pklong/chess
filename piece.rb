class MoveError < StandardError
end

class Piece

  def initialize(pos, board, color)
    @pos = pos
    @board = board
    @color = color
  end

  def is_enemy?(pos)
    @board[pos] && @board[pos].color != @color
  end

  def is_friend?(pos)
    @board[pos] && @board[pos].color == @color
  end

  def moves
    raise MoveError.new("Shouldn't have happened!")
  end

  protected
  attr_reader :color
  
end
