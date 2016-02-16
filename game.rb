require 'colorize'
require_relative 'cursorable'
require_relative 'errors'
require_relative 'board'
require_relative 'display'
require_relative 'piece'
require_relative 'sliding_piece'
require_relative 'stepping_piece'
require_relative 'rook'
require_relative 'bishop'
require_relative 'queen'
require_relative 'knight'
require_relative 'king'
require_relative 'pawn'

class Game
  def initialize
    @players = [:w, :b]
    @board = Board.new
    @board.populate
    @display = Display.new(@board)
  end

  def run
    until @board.checkmate?(@players.first)
    begin
      take_turn
    rescue InvalidMoveError => e
      puts e.message
      puts "try again"
      sleep(1.5)
      retry
    end
      swap_current_player!
    end
    puts "#{@players[0]} is the victor!"

  end

  def take_turn
    moves_set = []
    until moves_set.length == 2
      @display.render
      puts "it's #{@players.first}'s turn"
      puts "#{@players.first} is in check" if @board.in_check?(@players[0])
      input = @display.get_input
      moves_set << input if input
    end

    @board.move(moves_set[0], moves_set[1], @players[0])
    promotion_piece = @board.promotion
    promote(promotion_piece) if promotion_piece
  end

  def promote(piece)
    puts "Promote pawn to which piece? (Q, R, K, B)"
    choice = gets.chomp.upcase
    case choice
    when "Q"
      @board[piece.pos] = Queen.new(piece.pos, @board, piece.color)
    when "R"
      @board[piece.pos] = Rook.new(piece.pos, @board, piece.color)
    when "K"
      @board[piece.pos] = Knight.new(piece.pos, @board, piece.color)
    when "B"
      @board[piece.pos] = Bishop.new(piece.pos, @board, piece.color)
    else
      raise InputError.new("That's not a valid choice.")
    end
  rescue InputError => e
    puts e.message
    puts "try again"
    retry
  end

  def swap_current_player!
    @players.rotate!
  end
end

if __FILE__ == $0
  Game.new.run
end
