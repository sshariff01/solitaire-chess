class King < Piece
  def initialize(start_x, start_y, board_dimension)
    @x = start_x
    @y = start_y
    @board_dimension = board_dimension
    @possible_moves = generate_possible_moves
  end

  private

  def generate_possible_moves
    [
        [x+1, y],
        [x-1, y],
        [x, y+1],
        [x, y-1],
    ].delete_if { |a, b| a < 0 or b < 0 or a > @board_dimension-1 or b > @board_dimension-1 }
  end
end