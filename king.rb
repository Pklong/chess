class King < SteppingPiece

  def moves
    moves = []

    DELTA.each do |row|
      DELTA.each do |col|
        new_pos = [@pos[0] + row, @pos[1] + col]
        moves << new_pos if @board.in_bounds?(new_pos) &&
                                  !is_friend?(new_pos)
      end
    end

    DELTA.each do |dx|
      new_pos = [@pos[0], @pos[1] + dx]
      moves << new_pos if @board.in_bounds?(new_pos) && !is_friend?(new_pos)
      new_pos = [@pos[0] + dx, @pos[1]]
      moves << new_pos if @board.in_bounds?(new_pos) && !is_friend?(new_pos)
    end

    moves
  end

  def to_s
    @color == :w ? "\u2654" : "\u265A"
  end

end
