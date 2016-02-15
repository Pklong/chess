require "colorize"
require_relative "cursorable"
require_relative "board"

class Display
  include Cursorable

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
    @selected = false
  end

  def build_grid
    @board.grid.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
      if piece
        piece.to_s.colorize(color_options)
      else
        " ".to_s.colorize(color_options)
      end
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif (i + j).odd?
      bg = :white
    else
      bg = :black
    end
    { background: bg }
  end

  def render
    system("clear")
    build_grid.each { |row| puts row.join }
  end
end
b = Board.new
b.populate

test = Display.new(b)
result = nil

until result
  test.render
  result = test.get_input
end
