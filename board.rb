class Board
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
    valid_move?(start_pos, end_pos)
  end

  

  private

  def valid_move?(start_pos, end_pos)
    (start_pos + end_pos).all? { |coord| coord.between?(0, 7) }
  end


end
