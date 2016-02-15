class Rook < SlidingPiece

  def move_dirs
    horizontal_vertical_moves
  end

  def to_s
    if @color == :w
      "\u2656"
    else
      "\u265C"
    end
  end

end
