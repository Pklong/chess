class Queen < SlidingPiece

  def move_dirs
    diagonal_moves.concat(horizontal_vertical_moves)
  end

  def to_s
    @color == :w ? "\u2655" : "\u265B"
  end

end
