class Bitmap
  WHITE = 'O'

  attr_reader :errors

  def initialize(width, height)
    @errors = []
    @structure = Array.new(height) { Array.new(width, WHITE) }
  end

  def set_pixel(x, y, colour)
    @errors = []
    check_x_position(x)
    check_y_position(y)
    check_colour(colour)
    return if errors.any?
    @structure[y - 1][x - 1] = colour
  end

  def set_vertical_segment(x, y1, y2, colour)
    check_x_position(x)
    check_y_position(y1, 'Y1')
    check_y_position(y2, 'Y2')
    check_colour(colour)
    @errors << 'Y2 must be higher than Y1' unless y2 > y1
    return if errors.any?
    y1.upto(y2) do |y|
      @structure[y - 1][x - 1] = colour
    end
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

  private

  def check_x_position(x, name = 'X')
    @errors << "#{name} position too low" unless x >= 1
    @errors << "#{name} position too high" unless x <= width
  end

  def check_y_position(y, name = 'Y')
    @errors << "#{name} position too low" unless y >= 1
    @errors << "#{name} position too high" unless y <= height
  end

  def check_colour(colour)
    @errors << 'Unknown colour' unless ('A'..'Z').include? colour
  end
end
