require "colorize"
require_relative "cursorable"
require_relative "board"

class Display
  include Cursorable

  def initialize(board, debug = false)
    @board = board
    @cursor_pos = [0, 0]
    @selected = false
    @move_set = []
    @debug = debug
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
        " #{piece} ".colorize(color_options)
      else
        "   ".to_s.colorize(color_options)
      end
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif (i + j).odd?
      bg = :black
    else
      bg = :white
    end
    { background: bg }
  end

  def render
    system("clear")
    build_grid.each { |row| puts row.join }
    if @debug
      puts "Cursor_pos: #{@cursor_pos}"
      puts "selected: #{@selected}"
      puts "move_set: #{@move_set}"
      if @move_set[0]
        puts "moves for selected piece: #{@board[@move_set[0]].moves}"
      end
      puts "Is white in check? #{@board.in_check?(:w)}"
    end
  end

  def run
    while true
      until @move_set.length == 2
        render
        get_input
      end

      @board.move(@move_set[0], @move_set[1])
      @move_set = []
    end

  end
end
b = Board.new
b.populate

test = Display.new(b, true)
test.run
