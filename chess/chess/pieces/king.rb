require_relative 'pieces'

class King < Piece


  def symbol
    'K'.colorize(color)
  end


  def move_diffs
    [[-1, -1],[-1, 0],[-1, 1],[0, -1],[0, 1],[1, -1],[1, 0],[1, 1]]
  end
end
