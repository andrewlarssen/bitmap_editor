class Bitmap
  WHITE = 'O'

  def initialize(width, height)
    @structure = Array.new(height) { Array.new(width, WHITE) }
  end

  def set_pixel(x, y, colour)
    @structure[y-1][x-1] = colour
  end

  def width
    @structure.first.size
  end

  def height
    @structure.size
  end

  def contents
    rows = @structure.map(&:join)
    rows.join("\n")
  end
end
