

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

  def checkmate?(color)
    get_all_color_pieces(color).none? { |piece| piece.valid_moves.any? }
  end

  def find_king(color)
    @grid.each do |row|
      row.each do |piece|
        return piece.pos if piece.is_a?(King) && piece.color == color
      end
    end
  end

  def get_all_color_pieces(color)
    pieces = []
    @grid.each do |row|
      row.each do |piece|
        pieces << piece if piece && piece.color == color
      end
    end

    pieces
  end

  def in_bounds?(start_pos, end_pos = [])
    (start_pos + end_pos).all? { |coord| coord.between?(0, 7) }
  end

  def in_check?(color)
    king_pos = find_king(color)
    color == :w ? opponent_color = :b : opponent_color = :w
    enemy_pieces = get_all_color_pieces(opponent_color)

    enemy_pieces.any? { |piece| piece.moves.include?(king_pos) }
  end

  def move(start_pos, end_pos, color)
    unless self[start_pos] && self[start_pos].valid_moves.include?(end_pos)
      raise InvalidMoveError.new("Invalid move")
    end
    raise InvalidMoveError.new("Not your piece") if color != self[start_pos].color

    move!(start_pos, end_pos)
  end

  def move!(start_pos, end_pos)
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

  def promotion
    (@grid.first + @grid.last).each do |piece|
      return piece if piece.is_a?(Pawn)
    end

    nil
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

  def dup
    duped_board = Board.new

    @grid.each_with_index do |row, row_i|
      row.each_with_index do |piece, col_i|
        if piece
          new_piece = piece.class.new([row_i, col_i], duped_board, piece.color)
          duped_board[[row_i, col_i]] = new_piece
        end
      end
    end
    duped_board
  end

end
if __FILE__ == $0
  b = Board.new
  b.populate
end
