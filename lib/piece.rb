class Piece
  def x
    @x
  end
  
  def y
    @y
  end

  def possible_moves_in_the_way(board, kill_piece)
    false
  end

  def something_in_the_way?(board, kill_piece)
    if possible_moves_in_the_way(board, kill_piece) == false or possible_moves_in_the_way(board, kill_piece).empty?
      false
    else
      true
    end
  end

  def can_kill?(board, kill_piece)
    if @possible_moves.include? [kill_piece.x, kill_piece.y]
      if something_in_the_way?(board, kill_piece)
        return false
      else
        return true
      end
    end
    false
  end

  def kill(kill_piece)
    @x = kill_piece.x
    @y = kill_piece.y
    @possible_moves = generate_possible_moves
  end
end
