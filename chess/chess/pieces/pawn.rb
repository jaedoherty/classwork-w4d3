require_relative 'pieces'

class Pawn < Piece

  def symbol
    'P'.colorize(color)
  end

  def at_start_row?
    pos[0] == (color == :white) ? 6 : 1
  end

  def forward_dir
    color == :white ? -1 : 1
  end

  def forward_steps
    i, j = pos
    one_step = [i + forward_dir, j]
    return [] unless board.valid_pos?(one_step) && board.empty?(one_step)

    steps = [one_step]
    two_step = [i + 2 * forward_dir, j]
    steps << two_step if at_start_row? && board.empty?(two_step)
    steps
  end

  def side_attacks
    i, j = pos

    side_moves = [[i + forward_dir, j - 1], [i + forward_dir, j + 1]]

    side_moves.select do |new_pos|
      next false if !board.valid_pos?(new_pos)
      next false unless !board.empty?(new_pos)

      attacked = board[new_pos]
      threatened_piece && attacked.color != color
    end
  end
end
