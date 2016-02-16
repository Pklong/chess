class Pawn < Piece

  def initialize(pos, board, color)
    super(pos, board, color)
    @moved = false
  end

  def moves
    color == :w ? i = 1 : i = -1
    new_pos = [@pos[0] + i, @pos[1]]
    moves = attack_moves(i)
    return moves if @board[new_pos] || !@board.in_bounds?(new_pos)

    moves << new_pos

    next_pos = [new_pos[0] + i, new_pos[1]]
    moves << next_pos unless @board[next_pos] && @moved
    moves
  end

  private

  def attack_moves(direction)
    moves = []
    DELTA.each do |dx|
      new_pos = [@pos[0] + direction, @pos[1] + dx]
      moves << new_pos if @board.is_enemy?(new_pos)
    end

    moves
  end
end
