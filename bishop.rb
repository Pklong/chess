class Bishop < SlidingPiece

  def move_dirs
    diagonal_moves
  end

  def to_s
    @color == :w ? "\u2657" : "\u265D"
  end

end
