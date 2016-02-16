class SteppingPiece < Piece

  def moves
    raise MoveError.new("Shouldn't be here")
  end

  def stepping_moves(delta)
    moves = delta.map { |dx, dy| [(@pos[0] + dx), (@pos[1] + dy)] }
    moves.reject { |pos| !@board.in_bounds?(pos) || is_friend?(pos) }
  end

end
