require_relative 'pieces'

class Knight < Piece

  def symbol
    'N'.colorize(color)
  end


  def move_diffs
    [[-2, -1],[-1, -2],[-2, 1],[-1, 2],[1, -2],[2, -1],[1, 2],[2, 1]]
  end
end
