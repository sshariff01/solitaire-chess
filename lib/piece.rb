class Piece
  def x
    @x
  end
  
  def y
    @y
  end

  def can_kill?(kill_piece)
    @possible_moves.include? [kill_piece.x, kill_piece.y]
  end

  def kill(kill_piece)
    @x = kill_piece.x
    @y = kill_piece.y
    @possible_moves = generate_possible_moves
  end
end
