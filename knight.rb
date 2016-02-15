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
    moves = DELTA.map { |dx, dy| [(@pos[0] + dx), (@pos[1] + dy)] }
    moves.reject { |pos| !@board.in_bounds?(pos) || is_friend?(pos) }
  end

  def to_s
    @color == :w ? "\u2658" : "\u265E"
  end
end
