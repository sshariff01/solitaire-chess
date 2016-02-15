class Queen < Piece
  def initialize(start_x, start_y, board_dimension)
    @x = start_x
    @y = start_y
    @board_dimension = board_dimension
    @possible_moves = generate_possible_moves
  end

  private

  def generate_possible_moves
    possible_moves = []
    (1..@board_dimension).each do |i|
      possible_moves << [x+i, y+i]
      possible_moves << [x+i, y-i]
      possible_moves << [x-i, y+i]
      possible_moves << [x-i, y-i]
      possible_moves << [x+i, y]
      possible_moves << [x-i, y]
      possible_moves << [x, y+i]
      possible_moves << [x, y-i]
    end
    possible_moves.delete_if { |a, b| a < 0 or b < 0 or a > @board_dimension-1 or b > @board_dimension-1 }
  end

  def possible_moves_in_the_way(board, kill_piece)
    possible_interceptions = []
    dim = [(@x - kill_piece.x).abs, (@y - kill_piece.y).abs].max {|a,b| a <=> b } - 1
    (1..dim).each do |i|
      if @x < kill_piece.x and @y < kill_piece.y
        possible_interceptions << [@x+i, @y+i] if board.spot_empty?(@x+i, @y+i)
      elsif @x < kill_piece.x and @y > kill_piece.y
        possible_interceptions << [@x+i, @y-i] if board.spot_empty?(@x+i, @y-i)
      elsif @x > kill_piece.x and @y < kill_piece.y
        possible_interceptions << [@x-i, @y+i] if board.spot_empty?(@x-i, @y+i)
      elsif @x > kill_piece.x and @y > kill_piece.y
        possible_interceptions << [@x-i, @y-i] if board.spot_empty?(@x-i, @y-i)
      elsif @x < kill_piece.x and @y == kill_piece.y
        possible_interceptions << [@x+i, @y] if board.spot_empty?(@x+i, @y)
      elsif @x > kill_piece.x and @y == kill_piece.y
        possible_interceptions << [@x-i, @y] if board.spot_empty?(@x-i, @y)
      elsif @x == kill_piece.x and @y < kill_piece.y
        possible_interceptions << [@x, @y+i] if board.spot_empty?(@x, @y+i)
      elsif @x == kill_piece.x and @y > kill_piece.y
        possible_interceptions << [@x, @y-i] if board.spot_empty?(@x, @y-i)
      end
    end
    possible_interceptions
  end
end