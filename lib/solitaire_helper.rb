require 'optparse'
require_relative 'piece'
require_relative 'bishop'
require_relative 'pawn'
require_relative 'rook'
require_relative 'horse'

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

  def populate_chess_board
    populate_horses
    populate_bishops
    populate_rooks
    populate_pawns
  end

  def process_input
    @options = {}
    @options[:horses] = []
    @options[:bishops] = []
    @options[:pawns] = []
    @options[:rooks] = []
    OptionParser.new do |opt|
      opt.on('-d', '--board-dimension BOARD_SIZE', 'Chess board length or width') { |o| @options[:board_size] = o.to_i }
      opt.on('-hrs', '--horse HORSE', '[x, y] of horse piece') { |o| @options[:horses] << o[1,o.length-2].split(',').map { |elem| elem.to_i } }
      opt.on('-bp', '--bishop BISHOP', '[x, y] of bishop piece') { |o| @options[:bishops] << o[1,o.length-2].split(',').map { |elem| elem.to_i } }
      opt.on('-pn', '--pawn PAWN', '[x, y] of pawn piece') { |o| @options[:pawns] << o[1,o.length-2].split(',').map { |elem| elem.to_i } }
      opt.on('-rk', '--rook ROOK', '[x, y] of rook piece') { |o| @options[:rooks] << o[1,o.length-2].split(',').map { |elem| elem.to_i } }
    end.parse!

    populate_chess_board
  end
end