class King < SteppingPiece
  DELTA = [
            [1, 0],
            [-1, 0],
            [0, 1],
            [0, -1],
            [1, 1],
            [-1, -1],
            [-1, 1],
            [1, -1]
          ]
  attr_reader :moved
  def initialize(pos, board, color)
    super(pos, board, color)
    @moved = false
  end

  def moves
    stepping_moves(DELTA)
  end

  def pos=(new_pos)
    @pos = new_pos
    @moved = true
    nil
  end

  def to_s
    @color == :w ? "\u2654" : "\u265A"
  end

end
