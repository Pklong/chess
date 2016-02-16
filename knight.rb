class Knight < SteppingPiece
  DELTA = [
            [-2, 1],
            [-2, -1],
            [-1, -2],
            [-1, 2],
            [1, -2],
            [1, 2],
            [2, -1],
            [2, 1]
          ]

  def moves
    stepping_moves(DELTA)
  end

  def to_s
    @color == :w ? "\u2658" : "\u265E"
  end
end
