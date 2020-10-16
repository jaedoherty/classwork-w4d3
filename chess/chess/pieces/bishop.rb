require_relative 'pieces'

class Bishop > Piece
    def symbol 
        B.colorize(color)
    end

    def move_dir
        diagonal_dirs
    end

end