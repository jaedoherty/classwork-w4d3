require_relative 'pieces.rb'

class Rook < Piece

  def symbol
    R.colorize(color)
  end

  def move_dirs
    horizontal_and_vertical_dirs
  end
end
