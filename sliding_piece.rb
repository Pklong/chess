class SlidingPiece < Piece
  

  def moves
    move_dirs
  end

  def move_dirs
    raise MoveError.new("Shouldn't be here")
  end


  private

  def explore_moves(pos, inc1, inc2)
    return [] if !@board.in_bounds?(pos) ||
                     (@board[pos] &&
                     @board[pos].color == @color)
    return [pos] if @board[pos] && @board[pos].color != @color
    new_pos = [pos.first + inc1, pos.last + inc2]
    explore_moves(new_pos, inc1, inc2) << pos
  end

  def diagonal_moves
    moves = []
    DELTA.each do |row|
      DELTA.each do |col|
        new_row = @pos[0] + row
        new_col = @pos[1] + col
        moves.concat(explore_moves([new_row, new_col], row, col))
      end
    end
    moves
  end

  def horizontal_vertical_moves
    moves = []
    DELTA.each do |dx|
      moves.concat(explore_moves([@pos[0], @pos[1] + dx], 0, dx))
      moves.concat(explore_moves([@pos[0] + dx, @pos[1]], dx, 0))
    end
    moves
  end

end


# 4 times
# my_row, col changing positive
# my_row, col changing negative
# row changing postive, my_col
# row changing negative, my_col

# if friendly, end one before
# if enemy, end there

#increment
#check if occupied
#if occupied friendly
