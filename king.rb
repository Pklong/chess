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

  def moves
    stepping_moves(DELTA)
  end

  def to_s
    @color == :w ? "\u2654" : "\u265A"
  end

end
