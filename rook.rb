class Rook < SlidingPiece

  attr_reader :moved
  def initialize(pos, board, color)
    super(pos, board, color)
    @moved = false
  end

  def move_dirs
    horizontal_vertical_moves
  end

  def pos=(new_pos)
    @pos = new_pos
    @moved = true
    nil
  end

  def to_s
    @color == :w ? "\u2656" : "\u265C"
  end

end
