class Bitmap
  WHITE = 'O'

  def initialize(width, height)
    @structure = Array.new(height) { Array.new(width, WHITE) }
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
