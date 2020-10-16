require_relative 'pieces'

class NullPiece < Piece
  attr_reader :symbol

  def initialize
    @symbol = " "
    @color = :no_color
  end

  def empty?
    true
  end

  def moves
    []
  end

end
