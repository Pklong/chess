class Bishop < SlidingPiece

  def move_dirs
    diagonal_moves
  end

  def to_s
    if @color == :w
      "\u2657"
    else
      "\u265D"
    end
  end

end
