require_relative 'piece'
require_relative 'sliding_piece'
require_relative 'stepping_piece'
require_relative 'rook'
require_relative 'bishop'
require_relative 'queen'
require_relative 'knight'
require_relative 'king'
require_relative 'pawn'


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

  def in_bounds?(start_pos, end_pos = [])
    (start_pos + end_pos).all? { |coord| coord.between?(0, 7) }
  end


  def move(start_pos, end_pos)
    begin
      unless self[start_pos] && in_bounds?(start_pos, end_pos)
        raise InvalidMoveError("Invalid move")
      end
    end

    self[end_pos] = self[start_pos]
    self[end_pos].pos = end_pos
    self[start_pos] = nil
  end

  def populate
    [:b, :w].each do |color|
      populate_back_row(color)
      populate_pawns(color)
    end
  end

  def populate_back_row(color)
    color == :b ? row = 0 : row = 7
    self[[row, 0]] = Rook.new([row, 0], self, color)
    self[[row, 1]] = Knight.new([row, 1], self, color)
    self[[row, 2]] = Bishop.new([row, 2], self, color)
    self[[row, 3]] = Queen.new([row, 3], self, color)
    self[[row, 4]] = King.new([row, 4], self, color)
    self[[row, 5]] = Bishop.new([row, 5], self, color)
    self[[row, 6]] = Knight.new([row, 6], self, color)
    self[[row, 7]] = Rook.new([row, 7], self, color)
  end

  def populate_pawns(color)
    color == :b ? row = 1 : row = 6
    8.times do |col|
      self[[row, col]] = Pawn.new([row, col], self, color)
    end
  end

end
if __FILE__ == $0
  b = Board.new
  b.populate
end
