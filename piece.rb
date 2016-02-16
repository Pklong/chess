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
    raise MoveError.new("Subclasses should implement #move.")
  end

  def valid_moves
    moves.reject do |end_pos|
      dupped_board = @board.dup
      dupped_board.move!(@pos, end_pos)
      dupped_board.in_check?(@color)
    end
  end

  private

  def is_enemy?(pos)
    @board[pos] && @board[pos].color != @color
  end

  def is_friend?(pos)
    @board[pos] && @board[pos].color == @color
  end

end
