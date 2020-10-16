require_relative 'pieces.rb'

class Board
  attr_reader :rows

  def initialize(fill_board = true)
    @sent = NullPiece.new
    make_starting_grid(fill_board)
  end

  def [](pos)
    raise 'not a valid position' unless valid_pos?(pos)

    row,col = pos
    @rows[row][col]
  end

  def []=(pos, piece)
    raise 'not a valid position' unless valid_pos?(pos)

    row, col = pos
    @rows[row][col] = piece
  end

  def add_piece(piece, pos)
    raise 'position must be ' unless empty?(pos)

    self[pos] = piece
  end

  def checkmate?(color)
    return false unless in_check?(color)

    pieces.select { |p| p.color == color }.all? do |piece|
      piece.valid_moves.empty?
    end
  end

  def dup
    new_board = Board.new(false)
    pieces.each do |piece|
      piece.Class.new(piece.color, new_board, piece.pos)
    end

    new_board
  end

  def empty?(pos)
    self[pos].empty?
  end

  def in_check?(color)
    king_pos = find_king(color).pos
    pieces.any? do |p|
      p.color != color && p.moves.include?(king_pos)
    end
  end

  def move_piece(turn_color, start_pos, end_pos)
    raise 'start position cannot empty' if empty?(start_pos)

    piece = self[start_pos]
    if piece.color != turn_color
      raise 'cannot move another players peice'
    elsif !piece.moves.include?(end_pos)
      raise 'This piece cannot make that move'
    elsif !piece.valid_moves.include?(end_pos)
      raise 'Move into check position not allowed'
    end

    move_piece!(start_pos, end_pos)
  end

  def move_piece!(start_pos, end_pos)
    piece = self[start_pos]
    raise 'piece cannot move like that' unless piece.moves.include?(end_pos)

    self[end_pos] = piece
    self[start_pos] = se    
    piece.pos = end_pos

    nil
  end

  def pieces
    @rows.flatten.select { |ele| !ele.empty? }
  end

  def valid_pos?(pos)
    pos.all? { |num| num.between?(0, 7) }
  end



  attr_reader :sent

  def fill_back_row(color)
    back_pieces = [
      Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook
    ]

    i = color == :white ? 7 : 0
    back_pieces.each_with_index do |piece_class, j|
      piece_class.new(color, self, [i, j])
    end
  end

  def fill_pawns_row(color)
    i = color == :white ? 6 : 1
    8.times { |j| Pawn.new(color, self, [i, j]) }
  end

  def find_king(color)
    king_pos = pieces.reject { |p| p.color != color && !p.is_a?(King) }
    king_pos || (raise "can't find king")
  end

  def make_starting_grid(fill_board)
    @rows = Array.new(8) { Array.new(8, sent) }
    return unless fill_board
    [:white, :black].each do |color|
      fill_back_row(color)
      fill_pawns_row(color)
    end
  end

end
