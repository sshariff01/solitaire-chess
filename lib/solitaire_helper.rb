require 'optparse'
require_relative 'piece'
require_relative 'bishop'
require_relative 'pawn'
require_relative 'rook'
require_relative 'horse'
require_relative 'king'
require_relative 'queen'

class SolitaireHelper
  def initialize
    @success_log = []
    @pieces = []
  end

  def potential_moves(pieces)
    kill_list = []
    pieces.each do |killer|
      pieces.each do |target|
        kill_list << [killer, target] if killer.can_kill? target
      end
    end
    kill_list
  end

  def exit_if_solved(pieces)
    if pieces.length <= 1 and !@success_log.empty?
      puts 'SOLUTION:'
      @success_log.each { |step| puts "#{step}" }
      exit
    end
  end

  def solve(pieces=@pieces)
    exit_if_solved(pieces)

    possible_kills = potential_moves(pieces)
    possible_kills.each do |altercation|
      killer = altercation[0]
      victim = altercation[1]
      @success_log << "#{killer.class} at [#{killer.x}, #{killer.y}] takes #{victim.class} at [#{victim.x}, #{victim.y}]"

      pieces_dup, killer_dup = pieces.dup, killer.dup
      killer_dup.kill(victim)
      pieces_dup[pieces_dup.index(killer)] = killer_dup
      pieces_dup.delete(victim)

      solve(pieces_dup)
    end
    @success_log.pop
  end

  def solve_solitaire
    solve
    puts 'There is no solution'
  end

  def populate_horses
    @options[:horses].each do |h|
      @pieces << Horse.new(h[0], h[1], @options[:board_size])
    end
  end

  def populate_bishops
    @options[:bishops].each do |h|
      @pieces << Bishop.new(h[0], h[1], @options[:board_size])
    end
  end

  def populate_rooks
    @options[:rooks].each do |h|
      @pieces << Rook.new(h[0], h[1], @options[:board_size])
    end
  end

  def populate_pawns
    @options[:pawns].each do |h|
      @pieces << Pawn.new(h[0], h[1], @options[:board_size])
    end
  end

  def populate_kings
    @options[:kings].each do |h|
      @pieces << King.new(h[0], h[1], @options[:board_size])
    end
  end

  def populate_queens
    @options[:queens].each do |h|
      @pieces << Queen.new(h[0], h[1], @options[:board_size])
    end
  end

  def populate_chess_board
    populate_horses
    populate_bishops
    populate_rooks
    populate_pawns
    populate_kings
    populate_queens
  end

  def process_input
    @options = {}
    @options[:horses] = []
    @options[:bishops] = []
    @options[:pawns] = []
    @options[:rooks] = []
    @options[:kings] = []
    @options[:queens] = []
    OptionParser.new do |opt|
      opt.banner = "Usage: solitaire_solver.rb -d <BOARD_DIMENSION_SIZE> [options]"
      opt.on('-d', '--board-dimension BOARD_SIZE', 'Chess board length or width') { |o| @options[:board_size] = o.to_i }
      opt.on('-h', '--horse HORSE', '[x, y] of horse piece') { |o| @options[:horses] << o[1,o.length-2].split(',').map { |elem| elem.to_i } }
      opt.on('-b', '--bishop BISHOP', '[x, y] of bishop piece') { |o| @options[:bishops] << o[1,o.length-2].split(',').map { |elem| elem.to_i } }
      opt.on('-p', '--pawn PAWN', '[x, y] of pawn piece') { |o| @options[:pawns] << o[1,o.length-2].split(',').map { |elem| elem.to_i } }
      opt.on('-r', '--rook ROOK', '[x, y] of rook piece') { |o| @options[:rooks] << o[1,o.length-2].split(',').map { |elem| elem.to_i } }
      opt.on('-k', '--king KING', '[x, y] of king piece') { |o| @options[:kings] << o[1,o.length-2].split(',').map { |elem| elem.to_i } }
      opt.on('-q', '--queen QUEEN', '[x, y] of queen piece') { |o| @options[:queens] << o[1,o.length-2].split(',').map { |elem| elem.to_i } }
    end.parse!

    raise ('Missing Argument: -d arg specifying dimension size of chess board. See --help for usage.') if not @options[:board_size]

    populate_chess_board
  end
end