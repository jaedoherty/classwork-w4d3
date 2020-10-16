require_relative 'pieces'


class Queen < Piece

  def symbol
    Q.colorize(color)
  end


  def move_dirs
    horizontal_and_vertical_dirs + diagonal_dirs
  end
end
