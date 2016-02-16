class Display
  include Cursorable
  attr_reader :selected

  def initialize(board, debug = false)
    @board = board
    @cursor_pos = [0, 0]
    @selected = [0,0]
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
        "   ".colorize(color_options)
      end
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif (i + j).odd?
      bg = :light_black
    else
      bg = :white
    end
    { background: bg, color: :black }
  end

  def render
    system("clear")
    build_grid.each { |row| puts row.join }
    if @debug

      puts "Cursor_pos: #{@cursor_pos}"
      puts "selected: #{@selected}"
      if @board[@selected]
        puts "moves for selected piece: #{@board[@selected].valid_moves}"
      end
      puts "Is white in check? #{@board.in_check?(:w)}"
      puts "Is white in checkmate? #{@board.checkmate?(:w)}"
    end
  end
end
