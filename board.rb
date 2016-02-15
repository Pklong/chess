require_relative 'piece'
require_relative 'sliding_piece'

class InvalidMoveError < StandardError
end

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    @grid[row][col] = piece
  end

  def move(start_pos, end_pos)
    begin
      unless self[start_pos] && in_bounds?(start_pos, end_pos)
        raise InvalidMoveError("Invalid move")
      end
    end

    self[end_pos] = self[start_pos]
    self[start_pos] = nil
  end

  #private

  def in_bounds?(start_pos, end_pos = [])
    (start_pos + end_pos).all? { |coord| coord.between?(0, 7) }
  end

end
