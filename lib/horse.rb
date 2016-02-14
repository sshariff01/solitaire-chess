class Horse < Piece
  def initialize(start_x, start_y, board_dimension)
    @x = start_x
    @y = start_y
    @board_dimension = board_dimension
    @possible_moves = generate_possible_moves
  end
  
  private

  def generate_possible_moves
    [
      [x+1, y+2],
      [x+1, y-2],
      [x-1, y+2],
      [x-1, y-2],

      [x+2, y+1],
      [x+2, y-1],
      [x-2, y+1],
      [x-2, y-1]
    ].delete_if { |a, b| a < 0 or b < 0 or a > @board_dimension-1 or b > @board_dimension-1 }
  end
end
