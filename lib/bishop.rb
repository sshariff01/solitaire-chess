class Bishop < Piece
  def initialize(start_x, start_y, board_dimension)
    @x = start_x
    @y = start_y
    @board_dimension = board_dimension
    @possible_moves = generate_possible_moves
  end

  def generate_possible_moves
    possible_moves = []
    (1..@board_dimension).each do |i|
      possible_moves << [x+i, y+i]
      possible_moves << [x+i, y-i]
      possible_moves << [x-i, y+i]
      possible_moves << [x-i, y-i]
    end
    possible_moves.delete_if { |a, b| a < 0 or b < 0 or a > @board_dimension-1 or b > @board_dimension-1 }
  end
end
