class Board
  def initialize(board_dimension)
    @size = board_dimension
    @board = Array.new(board_dimension) { Array.new(board_dimension) }
  end

  def size
    @size
  end

  def add_piece(new_piece)
    @board[new_piece.x][new_piece.y] = new_piece
  end

  def remove_piece(dead_piece)
    @board[dead_piece.x][dead_piece.y] = nil
  end
end